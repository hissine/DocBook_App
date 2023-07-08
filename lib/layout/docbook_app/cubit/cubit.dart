import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:ramdan_proj/layout/docbook_app/cubit/states.dart';
import 'package:ramdan_proj/layout/docbook_app/doctor_home_screen.dart';
import 'package:ramdan_proj/models/docbook_app/notes_model.dart';
import 'package:ramdan_proj/models/docbook_app/reservationmodel.dart';
import 'package:ramdan_proj/modules/docbook_app/docbook_calendar_screen/user_appointments_screen.dart';
import 'package:ramdan_proj/modules/docbook_app/docbook_home_screen/user_home_screen.dart';
import 'package:ramdan_proj/modules/docbook_app/docbook_profile_screen/user_profile_screen.dart';
import '../../../models/docbook_app/create_reservation.dart';
import '../../../models/docbook_app/medications.dart';
import '../../../modules/docbook_app/docbook_home_screen/scan_screen.dart';
import '../../../modules/docbook_app/docbook_profile_screen/doctor_profile_screen.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/remote/dio_helper/dio_helper.dart';

class DocBookCubit extends Cubit<DocBookStates> {
  DocBookCubit() : super(DocBookInitialState());

  static DocBookCubit get(context) => BlocProvider.of(context);

  int curIndex = 0;

  List<Widget> screensOnBottom = [
    DoctorHomeScreen(),
    const ScanScreen(),
    const DoctorProfile(),
  ];

  List<Widget> bottomScreens = [
    DocBookHomeScreen(),
    const ScanScreen(),
    DocBookCalendarScreen(),
    const DocBookProfileScreen(),
  ];
  void changeBottom(int index) {
    curIndex = index;
    emit(DocBookChangeBottomNavState());
  }

  File? profileImage;
  final ImagePicker picker = ImagePicker();

  Future getProfileImage(
    ImageSource source,
  ) async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    profileImage = File(image.path);
    emit(UploadImageSuccessState(image.path));
  }

  String result = '';
  void getResult(String image)async{
    emit(GetResultLoadingState());
    var formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(image, filename: image),
    });
    final response = await Dio().post(
      'https://0e36-197-54-23-58.ngrok-free.app/scan_tumor',
      data: formData,
    ).then((value) {
      print(value.data);
      result = value.data["prediction"];
      emit(GetResultSuccessState());
    }).catchError((e){
      print(e);
      emit(GetResultErrorState());});
  }


  ReservationModel? reservationModel;
  void userReservation({
    required String time,
    required String start,
    required String patient,
    required String doctor,
    required String type,
    required int cardNumber,
    required String expiration,
    required String securitycode,
  }) async {
    emit(ReservationLoadingState());
    await DioHelper.postData(url: "createReservation", data: {
      'start': start,
      'time': time,
      'patient': patient,
      'doctor': doctor,
      'cardnumber': cardNumber,
      'expiration': expiration,
      'securitycode': securitycode,
      'type': type,
    }).then((value) {
      reservationModel = ReservationModel?.fromJson(value.data);
      emit(ReservationSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ReservationErrorState());
    });
  }

  CreateReservationModel? createReservation;
  Future<void> iCreateReservation({
    required String time,
    required String start,
    required String idPatient,
    required String idDoctor,
    required dynamic cardNumber,
    required String expiration,
    required String securityCode,
    required String type,
  }) async {
    emit(CreateReservationLoadingState());
    initializeDateFormatting();
    await DioHelper.postData(url: "createReservation", token: token, data: {
      'time': DateFormat("yyy-MM-dd", "en")
          .format(DateTime.tryParse(time.toString())!),
      'start': start,
      'patient': idPatient,
      'doctor': idDoctor,
      'cardnumber': cardNumber,
      'expiration': expiration,
      'securitycode': securityCode,
      'type': type,
    }).then((value) {
      print(time);
      print(start);
      createReservation = CreateReservationModel.fromJson(value.data);
      emit(CreateReservationSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CreateReservationErrorState());
    });
  }

  Future<void> addMedication(String id, String? content) async {
    emit(AddMedicationLoadingState());
    await DioHelper.postData(
      url: 'createMedicines/$id',
      token: token,
      data: {
        'content': content,
      },
    ).then((value) {
      emit(AddMedicationSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AddMedicationErrorState());
    });
  }

  GetMedications? medications;
  Future<void> viewMedications(String? id) async {
    emit(GetMedicationLoadingState());
    await DioHelper.getData(
        url: 'Medicines/$id',
    ).then((value) {
      medications = GetMedications.fromJson(value.data);
      print(medications?.medicines);
      emit(GetMedicationSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetMedicationErrorState());
    });
  }

  UserNotes? userNote;
  //List<Notes> notes = [];
  Future<void> viewNotes(String? id) async {
    emit(GetNotesLoadingState());
    await DioHelper.getData(url: 'Notes/$id').then((value) {
      userNote = UserNotes.fromJson(value.data);
      /*userNote?.notes!.forEach((element) {
        userNote!.notes!.add(element);
      });*/
      /*value.data.forEach((element) {
        notes.add(Notes.fromJson(element));
      });*/
      emit(GetNotesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetNotesErrorState());
    });
  }
}
