class DscUser {
  String uid;
  String email;
  String firstName;
  String lastName;
  String username;
  String gender;
  String profilePicUrl;
  String intro;
  String bio;
  String location;
  String github;
  String website;

  DscUser({
    this.uid,
    this.email,
    this.firstName,
    this.username,
    this.gender,
    this.profilePicUrl,
    this.intro,
    this.bio,
    this.location,
    this.github,
    this.website,
  });

  DscUser.fromMap(Map<String, dynamic> map) {
    uid = map['uid'];
    email = map['email'];
    firstName = map['first_name'];
    lastName = map['last_name'];
    username = map['username'];
    gender = map['gender'];
    profilePicUrl = map['profile_pic_url'];
    intro = map['intro'];
    bio = map['bio'];
    location = map['location'];
    github = map['github'];
    website = map['website'];
  }
}
