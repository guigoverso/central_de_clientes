class ClientModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String birthAt;

  ClientModel._({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.birthAt,
  });

  ClientModel.new({
    required this.name,
    required this.email,
    required this.phone,
    required this.birthAt,
  }) : id = -1;

  ClientModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        phone = json['phone'],
        birthAt = json['birth_at'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['birth_at'] = birthAt;
    return data;
  }

  ClientModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? birthAt,
  }) =>
      ClientModel._(
        id: id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        birthAt: birthAt ?? this.birthAt,
      );
}
