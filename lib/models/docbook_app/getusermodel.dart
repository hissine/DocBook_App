class GetUserModel {
  late String sId;
  String? userName;
  String? email;
  String? birthDate;
  List<String>? roles;
  String? allergies;
  String? blood;
  String? height;
  String? maritalStatus;
  String? smoking;
  String? weight;

  GetUserModel(
      {
        required this.sId,
        this.userName,
        this.email,
        this.birthDate,
        this.roles,
        this.allergies,
        this.blood,
        this.height,
        this.maritalStatus,
        this.smoking,
        this.weight});

  GetUserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    email = json['email'];
    birthDate = json['birthDate'];
    roles = json['roles'].cast<String>();
    allergies = json['allergies'];
    blood = json['blood'];
    height = json['height'];
    maritalStatus = json['maritalstatus'];
    smoking = json['smoking'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = sId;
    data['userName'] = userName;
    data['email'] = email;
    data['birthDate'] = birthDate;
    data['roles'] = roles;
    data['allergies'] = allergies;
    data['blood'] = blood;
    data['height'] = height;
    data['maritalstatus'] = maritalStatus;
    data['smoking'] = smoking;
    data['weight'] = weight;
    return data;
  }
}