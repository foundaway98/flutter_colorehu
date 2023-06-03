class User{
  String nickname;
  String email;

  User({required this.nickname, required this.email});

  Map<String,dynamic> toJson(){
    return {
      'nickname': nickname,
      'email': email
    };
  }

  factory User.fromJson(Map<String,dynamic> json) {
    return User(
        nickname: json['nickname'],
        email: json['email']
    );
  }
}