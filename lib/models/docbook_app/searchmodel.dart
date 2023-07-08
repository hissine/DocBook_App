class SearchModel {
  String? message;
  List<DoctorsModel>? doctors;
  int? totalDoc;

  SearchModel({this.message, required this.doctors, this.totalDoc});

  SearchModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['doctors'] != null) {
      doctors = <DoctorsModel>[];
      json['doctors'].forEach((v) {
        doctors!.add(DoctorsModel.fromJson(v));
      });
    }
    totalDoc = json['totalDoc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = message;
    if (doctors != null) {
      data['doctors'] = doctors!.map((v) => v.toJson()).toList();
    }
    data['totalDoc'] = totalDoc;
    return data;
  }
}

class DoctorsModel {
  String? sId;
  String? photo;
  String? region;
  String? specialty;
  dynamic raiting;
  dynamic numReviews;
  String? userName;
  String? phone;
  String? birthDate;
  String? sT;
  String? city;

  DoctorsModel({
      this.sId,
      this.photo,
      this.region,
      this.specialty,
      this.raiting,
      this.numReviews,
      this.userName,
      this.phone,
      this.birthDate,
      this.sT,
      this.city
  });

  DoctorsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    photo = json['photo'];
    region = json['region'];
    specialty = json['specialty'];

    raiting = json['raiting'];
    numReviews = json['numReviews'];
    userName = json['userName'];
    phone = json['phone'];
    birthDate = json['birthDate'];
    sT = json['__t'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['photo'] = photo;
    data['region'] = region;
    data['specialty'] = specialty;
    data['raiting'] = raiting;
    data['numReviews'] = numReviews;
    data['userName'] = userName;
    data['phone'] = phone;
    data['birthDate'] = birthDate;
    data['__t'] = sT;
    data['city'] = city;
    return data;
  }
}
