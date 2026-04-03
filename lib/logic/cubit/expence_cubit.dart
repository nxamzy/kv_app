import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_kv/logic/cubit/expence_state.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  StreamSubscription? _expenseSubscription;

  ExpenseCubit() : super(ExpenseInitial()) {
    getExpenses();
  }
  Future<void> updateIcon(String docId, int iconCode) async {
    try {
      await _firestore.collection('expenses').doc(docId).update({
        'iconCode': iconCode,
      });

      await getExpenses();

      print("Ikonka muvaffaqiyatli yangilandi!");
    } catch (e) {
      print("Ikonkani yangilashda Cubit-da xato: $e");
    }
  }

  Future<void> refreshExpenses() async {
    await getExpenses();
  }

  Future<void> getExpenses() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    await _expenseSubscription?.cancel();
    emit(ExpenseLoading());

    try {
      final groupsQuery = await _firestore
          .collection('groups')
          .where('members', arrayContains: userId)
          .get();

      final groupIds = groupsQuery.docs.map((doc) => doc.id).toList();

      if (groupIds.isEmpty) {
        emit(ExpenseLoaded([]));
        return;
      }

      _expenseSubscription = _firestore
          .collection('expenses')
          .where('groupId', whereIn: groupIds)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .listen(
            (snapshot) {
              emit(ExpenseLoaded(snapshot.docs));
            },
            onError: (e) {
              emit(ExpenseError("Xarajatlarni yuklashda xato: $e"));
            },
          );
    } catch (e) {
      emit(ExpenseError("Xatolik yuz berdi: $e"));
    }
  }

  void getExpensesByGroup(String? groupId) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (groupId == null || userId == null) return;

    if (groupId == 'all') {
      getExpenses();
      return;
    }

    await _expenseSubscription?.cancel();
    emit(ExpenseLoading());

    _expenseSubscription = _firestore
        .collection('expenses')
        .where('groupId', isEqualTo: groupId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen(
          (snapshot) {
            emit(ExpenseLoaded(snapshot.docs));
          },
          onError: (e) {
            emit(ExpenseError("Guruh xarajatlarini yuklashda xato: $e"));
          },
        );
  }

  Future<void> addExpense(String title, double amount, String groupId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      final groupDoc = await _firestore.collection('groups').doc(groupId).get();
      final groupName = groupDoc.data()?['name'] ?? "Guruh xarajati";

      await _firestore.collection('expenses').add({
        'title': title,
        'amount': amount,
        'userId': user.uid,
        'userName':
            user.displayName ?? user.email?.split('@')[0] ?? "Do'stimiz",
        'groupId': groupId,
        'groupName': groupName,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Qo'shishda xato: $e");
    }
  }

  Future<void> deleteExpense(String docId) async {
    try {
      await _firestore.collection('expenses').doc(docId).delete();
    } catch (e) {
      print("O'chirishda xato: $e");
    }
  }

  @override
  Future<void> close() {
    _expenseSubscription?.cancel();
    return super.close();
  }

  void loadExpenses({String? groupId}) {
    if (groupId == null || groupId == 'all') {
      getExpenses();
    } else {
      getExpensesByGroup(groupId);
    }
  }
}
