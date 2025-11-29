class Contact {
  String? email;

  Contact({this.email});

  factory Contact.fromJson(Map<String, dynamic> json) =>
      Contact(email: json['email'] as String?);

  Map<String, dynamic> toJson() => {'email': email};
}
