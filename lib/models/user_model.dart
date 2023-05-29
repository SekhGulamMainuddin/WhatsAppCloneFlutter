class UserModel{
  final String userName;
  final String phoneNumber;
  final String uid;
  final bool isOnline;
  final String photoUrl;
  final List<String> groupId;

  const UserModel({
    required this.userName,
    required this.phoneNumber,
    required this.uid,
    required this.isOnline,
    required this.photoUrl,
    required this.groupId,
  });

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'phoneNumber': phoneNumber,
      'uid': uid,
      'isOnline': isOnline,
      'photoUrl': photoUrl,
      'groupId': groupId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userName: map['userName'] as String,
      phoneNumber: map['phoneNumber'] as String,
      uid: map['uid'] as String,
      isOnline: map['isOnline'] as bool,
      photoUrl: map['photoUrl'] as String,
      groupId: map['groupId'] as List<String>,
    );
  }
}