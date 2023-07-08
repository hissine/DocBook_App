class UserNotes {
  String? sId;
  String? userName;
  List<Notes>? notes;

  UserNotes({this.sId, this.userName, this.notes});

  UserNotes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    if (json['notes'] != null) {
      notes = <Notes>[];
      json['notes'].forEach((v) {
        notes!.add(new Notes.fromJson(v));
      });
    }
  }

}

class Notes {
  String? sId;
  String? content;
  String? user;
  Doctor? doctor;

  Notes({this.sId, this.content, this.user, this.doctor});

  Notes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    content = json['content'];
    user = json['user'];
    doctor =
    json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
  }
}

class Doctor {
  String? sId;
  String? userName;
  String? sT;
  String? specialty;

  Doctor({this.sId, this.userName, this.sT, this.specialty});

  Doctor.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    sT = json['__t'];
    specialty = json['specialty'];
  }
}