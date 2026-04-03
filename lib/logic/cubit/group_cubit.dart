import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GroupCubit extends Cubit<GroupState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  GroupCubit() : super(GroupInitial());

  Future<void> deleteGroup(String groupId) async {
    emit(GroupLoading());
    try {
      await _firestore.collection('groups').doc(groupId).delete();

      final expenses = await _firestore
          .collection('expenses')
          .where('groupId', isEqualTo: groupId)
          .get();

      for (var doc in expenses.docs) {
        await doc.reference.delete();
      }

      emit(GroupSuccess());
    } catch (e) {
      emit(GroupError("Guruhni o'chirishda xato: $e"));
    }
  }

  void loadMyGroups() {
    final user = _auth.currentUser;
    if (user == null) return;

    emit(GroupLoading());

    _firestore
        .collection('groups')
        .where('members', arrayContains: user.uid)
        .snapshots()
        .listen(
          (snapshot) {
            emit(GroupLoaded(snapshot.docs));
          },
          onError: (e) {
            emit(GroupError("Guruhlarni yuklashda xato: $e"));
          },
        );
  }

  Future<void> createGroup({
    required String name,
    required String type,
    required int iconCode,
    required List<String> memberEmails,
  }) async {
    emit(GroupLoading());
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      await _firestore.collection('groups').add({
        'name': name,
        'type': type,
        'iconCode': iconCode,
        'members': [user.uid],
        'createdBy': user.uid,
        'createdAt': FieldValue.serverTimestamp(),
        'memberCount': 1,
      });

      emit(GroupSuccess());
      loadMyGroups();
    } catch (e) {
      emit(GroupError("Xato: $e"));
    }
  }

  Future<void> joinGroup(String groupId) async {
    final user = _auth.currentUser;
    if (user == null) return;

    emit(GroupLoading());

    try {
      DocumentReference groupRef = _firestore.collection('groups').doc(groupId);
      DocumentSnapshot doc = await groupRef.get();

      if (!doc.exists) {
        emit(GroupError("Bunday ID bilan guruh topilmadi!"));
        return;
      }

      List members = List.from(doc['members'] ?? []);

      if (!members.contains(user.uid)) {
        members.add(user.uid);

        await groupRef.update({
          'members': members,
          'memberCount': members.length,
        });
      }

      emit(GroupSuccess());
    } catch (e) {
      emit(GroupError("Guruhga qo'shilishda xato: $e"));
    }
  }
}

abstract class GroupState {}

class GroupInitial extends GroupState {}

class GroupLoading extends GroupState {}

class GroupSuccess extends GroupState {}

class GroupLoaded extends GroupState {
  final List<dynamic> groups;
  GroupLoaded(this.groups);
}

class GroupError extends GroupState {
  final String message;
  GroupError(this.message);
}
