class Client {
  String? fullName;
  String? mailId;
  String? phoneNumber;
  String? city;
  int? age;

  Client({this.fullName, this.mailId, this.phoneNumber, this.city, this.age});

  Client.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    mailId = json['mail_id'];
    phoneNumber = json['phone_number'];
    city = json['city'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this.fullName;
    data['mail_id'] = this.mailId;
    data['phone_number'] = this.phoneNumber;
    data['city'] = this.city;
    data['age'] = this.age;
    return data;
  }
}
