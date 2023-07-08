class DoctorReports {
  DoctorData? doctorData;
  List<DoctorOrderOnline>? doctorOrderOnline;
  Totals? totals;

  DoctorReports({this.doctorData, this.doctorOrderOnline, this.totals});

  DoctorReports.fromJson(Map<String, dynamic> json) {
    doctorData = json['doctorData'] != null
        ? new DoctorData.fromJson(json['doctorData'])
        : null;
    if (json['DoctorOrderOnline'] != null) {
      doctorOrderOnline = <DoctorOrderOnline>[];
      json['DoctorOrderOnline'].forEach((v) {
        doctorOrderOnline!.add(new DoctorOrderOnline.fromJson(v));
      });
    }
    totals =
    json['totals'] != null ? new Totals.fromJson(json['totals']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.doctorData != null) {
      data['doctorData'] = this.doctorData!.toJson();
    }
    if (this.doctorOrderOnline != null) {
      data['DoctorOrderOnline'] =
          this.doctorOrderOnline!.map((v) => v.toJson()).toList();
    }
    if (this.totals != null) {
      data['totals'] = this.totals!.toJson();
    }
    return data;
  }
}

class DoctorData {
  String? sId;
  String? photo;
  String? specialty;
  double? raiting;
  String? userName;
  String? email;
  String? birthDate;
  String? sT;
  String? city;

  DoctorData(
      {this.sId,
        this.photo,
        this.specialty,
        this.raiting,
        this.userName,
        this.email,
        this.birthDate,
        this.sT,
        this.city});

  DoctorData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    photo = json['photo'];
    specialty = json['specialty'];
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
    data['specialty'] = this.specialty;
    data['raiting'] = this.raiting;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['birthDate'] = this.birthDate;
    data['__t'] = this.sT;
    data['city'] = this.city;
    return data;
  }
}

class DoctorOrderOnline {
  String? sId;
  int? totalPaid;
  int? totalOrders;

  DoctorOrderOnline({this.sId, this.totalPaid, this.totalOrders});

  DoctorOrderOnline.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    totalPaid = json['totalPaid'];
    totalOrders = json['totalOrders'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['totalPaid'] = this.totalPaid;
    data['totalOrders'] = this.totalOrders;
    return data;
  }
}

class Totals {
  int? totalPaid;
  int? totalOrders;
  int? doctorGained;
  int? profit;

  Totals({this.totalPaid, this.totalOrders, this.doctorGained, this.profit});

  Totals.fromJson(Map<String, dynamic> json) {
    totalPaid = json['totalPaid'];
    totalOrders = json['totalOrders'];
    doctorGained = json['doctorGained'];
    profit = json['profit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalPaid'] = this.totalPaid;
    data['totalOrders'] = this.totalOrders;
    data['doctorGained'] = this.doctorGained;
    data['profit'] = this.profit;
    return data;
  }
}