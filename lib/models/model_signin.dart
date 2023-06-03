class User{
  int id;
  String nickname;
  String email;

  User({required this.id,required this.nickname,required this.email});


   Map<String, dynamic> toJson() => {
     'nickname': nickname,
     'email': email
  };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      nickname: json["nickname"],
      email: json["email"],
    );
  }

}