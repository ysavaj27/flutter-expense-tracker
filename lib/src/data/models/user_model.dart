class UserModel {
  final String id;
  final String email;
  final String displayName;
  final String? photoURL;
  final String role; // admin | member
  final String? familyId;
  final DateTime createdAt;
  final String? invitedBy;

  UserModel({
    required this.id,
    required this.email,
    required this.displayName,
    this.photoURL,
    required this.role,
    this.familyId,
    required this.createdAt,
    this.invitedBy,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
      'role': role,
      'familyId': familyId,
      'createdAt': createdAt.toIso8601String(),
      'invitedBy': invitedBy,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      displayName: map['displayName'],
      photoURL: map['photoURL'],
      role: map['role'],
      familyId: map['familyId'],
      createdAt: DateTime.parse(map['createdAt']),
      invitedBy: map['invitedBy'],
    );
  }
}
