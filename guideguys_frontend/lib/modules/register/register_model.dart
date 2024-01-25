class RegisterModel {
  late String username;
  late String email;
  late String password;
  late String firstName;
  late String lastName;
  late String phoneNumber;

  RegisterModel({
    required this.username,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
        "first_name": firstName,
        "last_name": lastName,
        "phone_number": phoneNumber,
      };
}
