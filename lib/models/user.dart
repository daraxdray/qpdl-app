class User {
  String? email;
  String? name;
  String? phone;
  String? address;
  String? lat;
  String? lng;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? token;

  User(
      {this.email,
        this.name,
        this.phone,
        this.address,
        this.lat,
        this.lng,
        this.updatedAt,
        this.createdAt,
        this.id});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}

//{
//"user": {
//"email": "DamilolaDaramola@trashcoin.com.ng",
//"name": "Damilola Daramola",
//"phone": "08105259928",
//"address": "efumadami",
//"lat": "92.2222",
//"lng": "19.2222",
//"updated_at": "2020-07-08T22:41:39.000000Z",
//"created_at": "2020-07-08T22:41:39.000000Z",
//"id": 202
//},
//"token": "1|tf0NVEtDnNKHteDm42Dpkt4WdX70UHrm0blg5Hp6HDU6Jf9kVCqViLXgK5TLPHcQie4X4WthOQZkVFBb"
//}