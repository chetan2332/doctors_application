class Doctor {
  final String name;
  final String uid;
  final String profilePic;
  final String spec;
  final int enrolled;
  Doctor(
      {required this.name,
      required this.uid,
      required this.profilePic,
      required this.spec,
      required this.enrolled});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'profilePic': profilePic,
      'spec': spec,
      'enrolled': enrolled,
    };
  }

  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
      name: map['name'] ?? '',
      uid: map['uid'] ?? '',
      profilePic: map['profilePic'] ?? '',
      spec: map['spec'] ?? '',
      enrolled: map['enrolled'] ?? 0,
    );
  }
}
