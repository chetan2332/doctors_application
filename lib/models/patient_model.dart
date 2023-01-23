class Patient {
  final String name;
  final String uid;
  final String profilePic;
  final String phoneNumber;
  Patient({
    required this.name,
    required this.uid,
    required this.profilePic,
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'profilePic': profilePic,
      'phoneNumber': phoneNumber,
    };
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      name: map['name'] ?? '',
      uid: map['uid'] ?? '',
      profilePic: map['profilePic'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
    );
  }
}
