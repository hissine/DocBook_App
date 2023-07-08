class UserAppointment {
  String? sId;
  String? patient;
  Doctor? doctor;
  String? start;
  String? time;
  int? meetingStart;
  bool? isPaid;
  String? cardnumber;
  String? securitycode;
  String? expiration;
  int? totalPaid;
  String? createdAt;
  String? updatedAt;
  int? iV;

  UserAppointment(
      {this.sId,
        this.patient,
        this.doctor,
        this.start,
        this.time,
        this.meetingStart,
        this.isPaid,
        this.cardnumber,
        this.securitycode,
        this.expiration,
        this.totalPaid,
        this.createdAt,
        this.updatedAt,
        this.iV});

  UserAppointment.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    patient = json['patient'];
    doctor =
    json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null;
    start = json['start'];
    time = json['time'];
    meetingStart = json['meetingStart'];
    isPaid = json['isPaid'];
    cardnumber = json['cardnumber'];
    securitycode = json['securitycode'];
    expiration = json['expiration'];
    totalPaid = json['totalPaid'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

}

class Doctor {
  String? sId;
  String? photo;
  String? userName;
  String? sT;

  Doctor({this.sId, this.photo, this.userName, this.sT});

  Doctor.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    photo = json['photo'];
    userName = json['userName'];
    sT = json['__t'];
  }

}