import 'package:flutter/material.dart';
import 'package:my_kv/data/model/user_model.dart';

abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final UserModel user;
  final Locale locale;

  SettingsLoaded({required this.user, required this.locale});

  SettingsLoaded copyWith({UserModel? user, Locale? locale, bool? isDarkMode}) {
    return SettingsLoaded(
      user: user ?? this.user,
      locale: locale ?? this.locale,
    );
  }
}

class SettingsUpdateSuccess extends SettingsState {}

class SettingsError extends SettingsState {
  final String message;
  SettingsError(this.message);
}
