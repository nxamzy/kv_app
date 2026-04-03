import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Map<String, dynamic> userData;
  ProfileLoaded(this.userData);
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}

class ProfileCubit extends Cubit<ProfileState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ProfileCubit() : super(ProfileInitial());

  void loadMyProfile() {
    final user = _auth.currentUser;
    if (user == null) {
      emit(ProfileError("Tizimga kirmagansiz"));
      return;
    }

    emit(ProfileLoading());

    _firestore.collection('users').doc(user.uid).snapshots().listen((snapshot) {
      if (snapshot.exists) {
        emit(ProfileLoaded(snapshot.data()!));
      } else {
        emit(ProfileError("Profil topilmadi"));
      }
    }, onError: (e) => emit(ProfileError("Xatolik: $e")));
  }

  Future<void> updateProfile({
    required String firstName,
    required String lastName,
    required String gender,
    required String phoneNumber,
    required String occupation,
    required String region,
    required DateTime birthDate,
    required String bio,
    required String language,
    required String username,
  }) async {
    final user = _auth.currentUser;
    if (user == null) return;

    emit(ProfileLoading());
    try {
      await _firestore.collection('users').doc(user.uid).update({
        'firstName': firstName,
        'lastName': lastName,
        'gender': gender,
        'phoneNumber': phoneNumber,
        'occupation': occupation,
        'region': region,
        'birthDate': Timestamp.fromDate(birthDate),
        'bio': bio,
        'language': language,
        'username': username,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      emit(ProfileSuccess());
    } catch (e) {
      emit(ProfileError("Yangilashda xato: $e"));
    }
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }
}
