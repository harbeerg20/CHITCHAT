
class Usser {
  String name;
  String gender;
  String phone;
  String gmail;
  Usser(
      {required this.name,
      required this.gender,
      required this.phone,
      required this.gmail});

  factory Usser.fromJson(Map<String, dynamic>? json) {
    return Usser(
      gender: json!['Gender'],
      name: json['Name'],
      phone: json['Phone'],
      gmail: json['Gmail'],
    );
  }

  Map<String, dynamic> toJson() => {
        'Name': name,
        'Gender': gender,
        'Phone': phone,
        'Gmail': gmail,
      };
}
