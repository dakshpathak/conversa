class UserModel {
  final String? id;
  final String fullname;
  final String email;
  final String password;
  final String imageurl;
  final String bio;
  final String uid;

  const UserModel({
    this.id,
    required this.email,
    required this.password,
    required this.fullname,
    required this.imageurl,
    required this.bio,
    required this.uid
});

  toJson(){
    return{
      "name": fullname,
      "Email": email,
      "Password":password,
      "Image": imageurl,
      "Bio": bio,
      "uid": uid
    };
  }
}
