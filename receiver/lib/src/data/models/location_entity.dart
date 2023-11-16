class LocationEntity {
  final String uid;
  final String name;

  LocationEntity({required this.uid, required this.name});

  factory LocationEntity.fromMap(Map<String, dynamic> data) {
    return LocationEntity(
      uid: data['uid'],
      name: data['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
    };
  }
}
