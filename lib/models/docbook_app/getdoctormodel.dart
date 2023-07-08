
class getDoctorModel {
  String? sId;
  String? photo;
  String? region;
  String? specialty;
  Null? title;
  int? price;
  String? aboutMe;
  List<Reviews>? reviews;
  dynamic raiting;
  int? numReviews;
  String? userName;
  String? birthDate;
  String? sT;
  String? city;
  /*
  String? sId;
  String? photo;
  String? specialty;
  String? title;
  int? price;
  String? aboutMe;
  List<Reviews>? reviews;
  dynamic raiting;
  int? numReviews;
  String? userName;
  String? birthDate;
  String? sT;
  String? city;
*/
  getDoctorModel(
      {this.sId,
        this.photo,
        this.region,
        this.specialty,
        this.title,
        this.price,
        this.aboutMe,
        this.reviews,
        this.raiting,
        this.numReviews,
        this.userName,
        this.birthDate,
        this.sT,
        this.city});

  getDoctorModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    photo = json['photo'];
    region = json['region'];
    specialty = json['specialty'];
    title = json['title'];
    price = json['price'];
    aboutMe = json['aboutme'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
    raiting = json['raiting'];
    numReviews = json['numReviews'];
    userName = json['userName'];
    birthDate = json['birthDate'];
    sT = json['__t'];
    city = json['city'];
    /*sId = json['_id'];
    photo = json['photo'];
    specialty = json['specialty'];
    title = json['title'];
    price = json['price'];
    aboutMe = json['aboutme'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
    raiting = json['raiting'];
    numReviews = json['numReviews'];
    userName = json['userName'];
    birthDate = json['birthDate'];
    sT = json['__t'];
    */
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['photo'] = this.photo;
    data['specialty'] = this.specialty;
    data['title'] = this.title;
    data['price'] = this.price;
    data['aboutme'] = this.aboutMe;
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    data['raiting'] = this.raiting;
    data['numReviews'] = this.numReviews;
    data['userName'] = this.userName;
    data['birthDate'] = this.birthDate;
    data['__t'] = this.sT;
    return data;
  }
}

class Reviews {
  String? sId;
  int? rating;
  String? comment;
  String? doctor;
  String? time;
  int? iV;

  Reviews(
      {this.sId, this.rating, this.comment, this.doctor, this.time, this.iV});

  Reviews.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    rating = json['rating'];
    comment = json['comment'];
    doctor = json['doctor'];
    time = json['time'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['rating'] = this.rating;
    data['comment'] = this.comment;
    data['doctor'] = this.doctor;
    data['time'] = this.time;
    data['__v'] = this.iV;
    return data;
  }
}