class ReservationModel {
  String? message;
  CreateAppointment? createAppointment;
  String? id;

  ReservationModel({this.message, this.createAppointment, this.id});

  ReservationModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    createAppointment = json['createAppointment'] != null
        ? CreateAppointment.fromJson(json['createAppointment'])
        : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.createAppointment != null) {
      data['createAppointment'] = this.createAppointment!.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}

class CreateAppointment {
  Patient? patient;
  String? doctor;
  String? start;
  String? time;
  String? reservationPlace;
  bool? reservationStatus;
  int? meetingStart;
  bool? isPaid;
  String? cardnumber;
  String? securitycode;
  String? expiration;
  int? totalPaid;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CreateAppointment(
      {this.patient,
        this.doctor,
        this.start,
        this.time,
        this.reservationPlace,
        this.reservationStatus,
        this.meetingStart,
        this.isPaid,
        this.cardnumber,
        this.securitycode,
        this.expiration,
        this.totalPaid,
        this.sId,
        this.createdAt,
        this.updatedAt,
        this.iV});

  CreateAppointment.fromJson(Map<String, dynamic> json) {
    patient =
    json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
    doctor = json['doctor'];
    start = json['start'];
    time = json['time'];
    reservationPlace = json['reservationPlace'];
    reservationStatus = json['reservationStatus'];
    meetingStart = json['meetingStart'];
    isPaid = json['isPaid'];
    cardnumber = json['cardnumber'];
    securitycode = json['securitycode'];
    expiration = json['expiration'];
    totalPaid = json['totalPaid'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.patient != null) {
      data['patient'] = this.patient!.toJson();
    }
    data['doctor'] = this.doctor;
    data['start'] = this.start;
    data['time'] = this.time;
    data['reservationPlace'] = this.reservationPlace;
    data['reservationStatus'] = this.reservationStatus;
    data['meetingStart'] = this.meetingStart;
    data['isPaid'] = this.isPaid;
    data['cardnumber'] = this.cardnumber;
    data['securitycode'] = this.securitycode;
    data['expiration'] = this.expiration;
    data['totalPaid'] = this.totalPaid;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Patient {
  List<dynamic>? notes;
  String? sId;
  String? userName;
  String? email;
  String? password;
  String? birthDate;
  List<String>? roles;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? address;
  String? allergies;
  String? blood;
  String? height;
  String? smoking;
  String? weight;
  String? photo;
  String? photoId;
  String? maritalstatus;

  Patient(
      {this.notes,
        this.sId,
        this.userName,
        this.email,
        this.password,
        this.birthDate,
        this.roles,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.address,
        this.allergies,
        this.blood,
        this.height,
        this.smoking,
        this.weight,
        this.photo,
        this.photoId,
        this.maritalstatus});

  Patient.fromJson(Map<String, dynamic> json) {

    sId = json['_id'];
    userName = json['userName'];
    email = json['email'];
    password = json['password'];
    birthDate = json['birthDate'];
    roles = json['roles'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    address = json['address'];
    allergies = json['allergies'];
    blood = json['blood'];
    height = json['height'];
    smoking = json['smoking'];
    weight = json['weight'];
    photo = json['photo'];
    photoId = json['photoId'];
    maritalstatus = json['maritalstatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notes != null) {
      data['notes'] = this.notes!.map((v) => v?.toJson()).toList();
    }
    data['_id'] = this.sId;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['birthDate'] = this.birthDate;
    data['roles'] = this.roles;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['address'] = this.address;
    data['allergies'] = this.allergies;
    data['blood'] = this.blood;
    data['height'] = this.height;
    data['smoking'] = this.smoking;
    data['weight'] = this.weight;
    data['photo'] = this.photo;
    data['photoId'] = this.photoId;
    data['maritalstatus'] = this.maritalstatus;
    return data;
  }
}