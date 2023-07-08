class CreateReservationModel {
  String? message;
  CreateAppointment? createAppointment;
  String? id;

  CreateReservationModel({this.message, this.createAppointment, this.id});

  CreateReservationModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    createAppointment = json['createAppointment'] != null
        ? new CreateAppointment.fromJson(json['createAppointment'])
        : null;
    id = json['id'];
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
}

class Patient {
  String? sId;
  String? userName;
  String? email;
  String? password;
  String? birthDate;
  List<String>? roles;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? allergies;
  String? blood;
  String? height;
  String? maritalstatus;
  String? smoking;
  String? weight;

  Patient(
      {this.sId,
        this.userName,
        this.email,
        this.password,
        this.birthDate,
        this.roles,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.allergies,
        this.blood,
        this.height,
        this.maritalstatus,
        this.smoking,
        this.weight,
        });

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
    allergies = json['allergies'];
    blood = json['blood'];
    height = json['height'];
    maritalstatus = json['maritalstatus'];
    smoking = json['smoking'];
    weight = json['weight'];

  }


}