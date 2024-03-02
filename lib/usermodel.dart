class UserModel {
  String? name;
  String? image;
  String? mail;
  String? no;

  UserModel();

  UserModel.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.image = json['image'];
    this.mail = json['email'];
    this.no = json['mobile'];
  }
}
