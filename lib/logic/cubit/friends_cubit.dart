import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_kv/logic/cubit/friends_state.dart';

class FriendsCubit extends Cubit<FriendsState> {
  FriendsCubit() : super(FriendsInitial());

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  void loadFriends() async {
    emit(FriendsLoading());
    try {
      final currentUserId = _auth.currentUser?.uid;
      if (currentUserId == null) return;

      final userDoc = await _firestore
          .collection('users')
          .doc(currentUserId)
          .get();
      final List<dynamic> friendIds = userDoc.data()?['friends'] ?? [];

      if (friendIds.isEmpty) {
        emit(FriendsLoaded([]));
        return;
      }

      final snapshot = await _firestore
          .collection('users')
          .where(FieldPath.documentId, whereIn: friendIds)
          .get();

      final friendsList = snapshot.docs
          .map((doc) => {...doc.data(), 'uid': doc.id})
          .toList();

      emit(FriendsLoaded(friendsList));
    } catch (e) {
      emit(FriendsLoaded([]));
    }
  }

  // Do'st qo'shish funksiyasi
  Future<void> addFriend(String friendId) async {
    final currentUserId = _auth.currentUser?.uid;
    if (currentUserId == null) return;

    await _firestore.collection('users').doc(currentUserId).update({
      'friends': FieldValue.arrayUnion([friendId]),
    });

    loadFriends();
  }
}
