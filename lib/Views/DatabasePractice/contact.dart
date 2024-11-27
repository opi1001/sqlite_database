class Contact {
  int? id;
  String name;
  String phone;
  Contact({this.id, required this.name, required this.phone});
  factory Contact.fromMap(Map<String, dynamic> s) =>
      Contact(id: s['id'], phone: s['phone'], name: s['name']);
  Map<String, dynamic> toMap() => {
        'id': id,
        'phone': phone,
        'name': name,
      };
}
