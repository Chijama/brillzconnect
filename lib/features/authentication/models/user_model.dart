class User {
  String username;
  String email;
  String phone;
  String password;
  List<String> interests;

  // Regular constructor for creating custom user objects
  User({
    required this.username,
    required this.email,
    required this.phone,
    required this.interests,required this.password
  });

  // Factory constructor for default user
  factory User.defaultUser() {
    return User(
      username: 'Guest User', // Default username
      password: "password123",
      email: 'guest@example.com', // Default email
      phone: '08000000000', // Default phone number
      interests: ['Football', 'Basketball'], // Default interests
    );
  }
}
