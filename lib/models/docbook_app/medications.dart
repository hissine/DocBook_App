class GetMedications {
  String? sId;
  String? userName;
  List<Medicines>? medicines;

  GetMedications({this.sId, this.userName, this.medicines});

  GetMedications.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    if (json['medicines'] != null) {
      medicines = <Medicines>[];
      json['medicines'].forEach((v) {
        medicines!.add(new Medicines.fromJson(v));
      });
    }
  }
}

class Medicines {
  String? sId;
  String? content;

  Medicines({this.sId, this.content});

  Medicines.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    content = json['content'];
  }

}