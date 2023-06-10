class UserDm {
  static String collectionName = "users";
  static UserDm? currentUser;

  static String? currentEmail;

  String id;
  String username;
  String email;

  UserDm({required this.id, required this.username, required this.email});
}
