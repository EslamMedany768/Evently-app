class MyUser {
  static const String collectionName="Users";
  String id;
  String name;
  String email;

  MyUser({required this.name, required this.id, required this.email});

  MyUser.fromJson(Map<String, dynamic> data)
      : this(
          id: data["id"],
          email: data["email"],
          name: data["name"],
        );

  static Map<String, dynamic> toJson(MyUser user) {
    return {"id": user.id, "name": user.name, "email": user.email};
  }
}
