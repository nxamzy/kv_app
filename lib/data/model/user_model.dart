class UserModel {
  final String uid;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String timeZone;
  final String currency;
  final String language;
  final bool allowSuggestions;

  UserModel({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    this.timeZone = '(GMT+05:00) Tashkent',
    this.currency = 'UZS',
    this.language = 'English',
    this.allowSuggestions = true,
  });

  UserModel copyWith({
    String? uid,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? timeZone,
    String? currency,
    String? language,
    bool? allowSuggestions,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      timeZone: timeZone ?? this.timeZone,
      currency: currency ?? this.currency,
      language: language ?? this.language,
      allowSuggestions: allowSuggestions ?? this.allowSuggestions,
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      uid: id,
      fullName: map['fullName'] ?? map['name'] ?? map['displayName'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? map['phone'] ?? '',
      timeZone: map['timeZone'] ?? '(GMT+05:00) Tashkent',
      currency: map['currency'] ?? 'UZS',
      language: map['language'] ?? 'English',
      allowSuggestions: map['allowSuggestions'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'timeZone': timeZone,
      'currency': currency,
      'language': language,
      'allowSuggestions': allowSuggestions,
    };
  }
}
