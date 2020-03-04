class DscUser {
  String uid;
  String email;
  String name;
  String username;
  String gender;
  String profilePicUrl;

  DscUser({
    this.uid,
    this.email,
    this.name,
    this.username,
    this.gender,
    this.profilePicUrl,
  });

  DscUser.fromMap(Map<String, dynamic> map) {
    uid = map['uid'];
    email = map['email'];
    name = map['name'];
    username = map['username'];
    gender = map['gender'];
    profilePicUrl = map['profile_pic_url'];
  }
}
