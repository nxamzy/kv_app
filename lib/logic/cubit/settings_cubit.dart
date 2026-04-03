import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_kv/data/model/user_model.dart';
import 'package:my_kv/logic/cubit/settings_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  SettingsCubit() : super(SettingsInitial());

  Future<void> loadSettings() async {
    final user = _auth.currentUser;
    if (user == null) return;

    emit(SettingsLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final String langCode = prefs.getString('language_code') ?? 'uz';

      final currentLocale = Locale(langCode);

      _firestore
          .collection('users')
          .doc(user.uid)
          .snapshots()
          .listen(
            (doc) {
              if (doc.exists && doc.data() != null) {
                final userModel = UserModel.fromMap(doc.data()!, doc.id);

                emit(SettingsLoaded(user: userModel, locale: currentLocale));
              }
            },
            onError: (e) {
              emit(SettingsError(e.toString()));
            },
          );
    } catch (e) {
      emit(SettingsError("Sozlamalarni yuklashda xatolik: $e"));
    }
  }

  Future<void> toggleTheme(bool isDark) async {
    if (state is SettingsLoaded) {
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('is_dark_mode', isDark);

        final currentState = state as SettingsLoaded;
        emit(currentState.copyWith(isDarkMode: isDark));
      } catch (e) {
        print("Mavzuni saqlashda xato: $e");
      }
    }
  }

  Future<void> updateLanguage(String langCode) async {
    if (state is SettingsLoaded) {
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('language_code', langCode);

        final currentState = state as SettingsLoaded;
        emit(currentState.copyWith(locale: Locale(langCode)));
      } catch (e) {
        print("Tilni saqlashda xato: $e");
      }
    }
  }

  Future<void> updateCurrency(String newCurrency) async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      await _firestore.collection('users').doc(user.uid).update({
        'currency': newCurrency,
      });
      if (state is SettingsLoaded) {
        final currentState = state as SettingsLoaded;
        final updatedUser = currentState.user.copyWith(currency: newCurrency);
        emit(currentState.copyWith(user: updatedUser));
      }
    } catch (e) {
      print("Valyutani yangilashda xato: $e");
    }
  }

  Future<void> updateUserSettings({
    required String fullName,
    required String phoneNumber,
    required String email,
  }) async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      if (user.email != email) {
        await user.verifyBeforeUpdateEmail(email);
      }

      await _firestore.collection('users').doc(user.uid).set({
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'email': email,
      }, SetOptions(merge: true));

      if (state is SettingsLoaded) {
        final currentState = state as SettingsLoaded;
        final updatedUser = currentState.user.copyWith(
          fullName: fullName,
          phoneNumber: phoneNumber,
          email: email,
        );
        emit(currentState.copyWith(user: updatedUser));
      }
    } catch (e) {
      emit(SettingsError("Ma'lumotlarni saqlashda muammo bo'ldi."));
    }
  }
}
