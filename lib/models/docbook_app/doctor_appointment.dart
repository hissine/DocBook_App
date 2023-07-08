class DoctorAppointments {
  String? sId;
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
  String? createdAt;
  String? updatedAt;
  int? iV;

  DoctorAppointments(
      {this.sId,
        this.patient,
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
        this.createdAt,
        this.updatedAt,
        this.iV});

  DoctorAppointments.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
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
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
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
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Patient {
  String? sId;
  String? userName;
  String? birthDate;

  Patient({this.sId, this.userName, this.birthDate});

  Patient.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    birthDate = json['birthDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userName'] = this.userName;
    data['birthDate'] = this.birthDate;
    return data;
  }
}