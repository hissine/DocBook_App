class AllDoctors {
  String? message;
  List<DoctorModel>? data;

  AllDoctors({this.message, this.data});

  AllDoctors.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <DoctorModel>[];
      json['data'].forEach((v) {
        data!.add(DoctorModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DoctorModel {
  String? sId;
  String? photo;
  String? license;
  String? specialty;
  Null? title;
  dynamic raiting;
  String? userName;
  String? email;
  String? birthDate;
  String? sT;
  String? city;

  DoctorModel(
      {this.sId,
        this.photo,
        this.license,
        this.specialty,
        this.title,
        this.raiting,
        this.userName,
        this.email,
        this.birthDate,
        this.sT,
        this.city});

  DoctorModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    photo = json['photo'];
    license = json['license'];
    specialty = json['specialty'];
    title = json['title'];
    raiting = json['raiting'];
    userName = json['userName'];
    email = json['email'];
    birthDate = json['birthDate'];
    sT = json['__t'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['photo'] = this.photo;
    data['license'] = this.license;
    data['specialty'] = this.specialty;
    data['title'] = this.title;
    data['raiting'] = this.raiting;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['birthDate'] = this.birthDate;
    data['__t'] = this.sT;
    data['city'] = this.city;
    return data;
  }
}