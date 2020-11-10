class Login_Response_Data {
  Data data;

  Login_Response_Data({this.data});

  Login_Response_Data.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String email;
  int status;
  bool success;
  String password;
  String lastName;
  String firstName;

  Data(
      {this.email,
        this.status,
        this.success,
        this.password,
        this.lastName,
        this.firstName});

  Data.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    status = json['status'];
    success = json['success'];
    password = json['password'];
    lastName = json['last_name'];
    firstName = json['first_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['status'] = this.status;
    data['success'] = this.success;
    data['password'] = this.password;
    data['last_name'] = this.lastName;
    data['first_name'] = this.firstName;
    return data;
  }
}