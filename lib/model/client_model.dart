class ClientModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String birthAt;

  ClientModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.birthAt,
  });

  ClientModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        phone = json['phone'],
        birthAt = json['birth_at'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['birth_at'] = birthAt;
    return data;
  }
}
