import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ExpenseState {}

class ExpenseInitial extends ExpenseState {}

class ExpenseLoading extends ExpenseState {}

class ExpenseLoaded extends ExpenseState {
  final List<QueryDocumentSnapshot> expenses;
  ExpenseLoaded(this.expenses);
}

class ExpenseError extends ExpenseState {
  final String message;
  ExpenseError(this.message);
}
