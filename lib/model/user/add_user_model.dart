class AddUserModel {
  String? name;
  String? username;
  String? email;
  int? id;

  AddUserModel({this.name, this.username, this.email, this.id});

  AddUserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    username = json['username'];
    email = json['email'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['id'] = this.id;
    return data;
  }
}
