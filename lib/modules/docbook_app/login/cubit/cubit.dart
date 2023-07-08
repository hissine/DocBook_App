import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ramdan_proj/models/docbook_app/getdoctormodel.dart';
import 'package:ramdan_proj/models/docbook_app/login_model.dart';
import 'package:ramdan_proj/modules/docbook_app/login/cubit/states.dart';
import 'package:ramdan_proj/shared/network/remote/dio_helper/dio_helper.dart';
import '../../../../models/docbook_app/doctor_appointment.dart';
import '../../../../models/docbook_app/doctor_reports.dart';
import '../../../../models/docbook_app/doctorsonhome.dart';
import '../../../../models/docbook_app/getusermodel.dart';
import '../../../../models/docbook_app/userreservation.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
class DocLoginCubit extends Cubit<DocLoginStates> {
  DocLoginCubit() : super(DocLoginInitialState());

  static DocLoginCubit get(context) => BlocProvider.of(context);
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(DocChangePasswordVisibilityState());
  }

  IconData suffixPasswordConfirmVisible = Icons.visibility_outlined;
  bool passwordConfirmVisible = true;

  void changeConfirmPasswordVisibility() {
    passwordConfirmVisible = !passwordConfirmVisible;
    suffixPasswordConfirmVisible =
    passwordConfirmVisible ? Icons.visibility_outlined : Icons
        .visibility_off_outlined;
    emit(ConfirmPasswordVisibilityState());
  }

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final allergiesController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final bloodController = TextEditingController();
  final martialController = TextEditingController();
  final ageController = TextEditingController();
  final smokerController = TextEditingController();
  final aboutMeController = TextEditingController();
  final specialtyController = TextEditingController();
  final doctorNameController = TextEditingController();
  final doctorPriceController = TextEditingController();
  final aboutDoctorController = TextEditingController();
  String radioValue = '';

  void changeRadio(value) {
    radioValue = value;
    emit(ChangeRadioState());
  }


  LoginModel? loginModel;

  void userLogin({required String email, required String password}) async {
    emit(DocLoginLoadingState());
    await DioHelper.postData(
        url: "auth/loginUser",
        data: {
          'email': email,
          'password': password,
        }
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(DocLoginSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(DocLoginErrorState(error.toString()));
    });
  }

  void doctorLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    await DioHelper.postData(
        url: "auth/loginDoctor",
        data: {
          'email': email,
          'password': password,
        }
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel!.role);
      print(loginModel!.userId);
      emit(LoginSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState());
    });
  }

  GetUserModel? userModel;

  void getUserData(String id) async {
    emit(DocBookLoadingUserDataState());
    await DioHelper.getData(
      url: 'user/account/profile/$id',
      token: token,
    ).then((value) {
      userModel = GetUserModel.fromJson(value.data);
      print(userModel!.userName);
      print(userModel!.birthDate);
      print(userModel!.sId);
      emit(DocBookSuccessUserDataState(userModel!));
    }).catchError((error) {
      if (error is DioError) {
        print(error.toString());
      }
      print(error.toString());
      emit(DocBookErrorUserDataState(error.toString()));
    });
  }


  getDoctorModel? doctorModel;
  Map ratingCount = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};

  Future<void> getDoctorData(String id) async {
    ratingCount = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};
    emit(GetDoctorDataLoadingState());
    await DioHelper.getData(
      url: 'doctor/account/profile/$id',
      token: token,
    ).then((value) {
      doctorModel = getDoctorModel.fromJson(value.data);
      doctorModel?.reviews?.forEach((element) {
        ratingCount[element.rating]++;
      });
      print("...........${ratingCount}");
      print(token);
      print(doctorModel!.photo);
      print(doctorModel!.sId);
      print(doctorModel!.birthDate);
      print(doctorModel!.userName);
      print(doctorModel!.raiting);
      emit(GetDoctorDataSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        print(error.toString());
      }
      print(token);
      print(id);
      emit(GetDoctorDataErrorState(error.toString()));
    });
  }


  void getProfileData(String id) {
    if (doctor == true) {
      getDoctorData(id);
    } else {
      getUserData(id);
    }
  }

  void updateUser({
    String? userName,
    String? email,
    String? id,
    String? maritalStatus,
    String? allergies,
    String? blood,
    String? smoking,
    String? height,
    String? weight,
  }) async {
    emit(DocBookUpdateUserDataLoadingState());
    await DioHelper.putData(
        url: 'user/account/profilenew/$id',
        token: token,
        data: {
          'userName': userName,
          //'email':email,
          'maritalstatus': maritalStatus,
          'allergies': allergies,
          'blood': blood,
          'smoking': smoking,
          'height': height,
          'weight': weight,
        }).then((value) {
      getUserData(id.toString());
      showToast(
        text: 'Update Successfully',
        state: ToastStates.SUCCESS,
      );
      emit(DocBookUpdateUserDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(DocBookUpdateUserDataErrorState());
    });
  }

  void updateDoctor({
    String? id,
    String? userName,
    String? price,
    String? aboutMe,
    String? specialty,
  }) async {
    emit(DoctorUpdateDataLoadingState());
    await DioHelper.putData(
        url: 'doctor/account/profile/$id',
        token: token,
        data: {
          'userName': userName,
          'price': price,
          'aboutme': aboutMe,
          'specialty': specialty
        }).then((value) {
      getDoctorData(id.toString());
      showToast(
        text: 'Update Successfully',
        state: ToastStates.SUCCESS,
      );
      emit(DoctorUpdateDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(DoctorUpdateDataErrorState());
      // print(error);
    });
  }

  void updateUserPassword({
    String? id,
    String? password,
    String? confirmPassword,
  }) {
    emit(DocBookUpdatePasswordLoadingState());
    DioHelper.putData(
        url: 'user/account/changePassword/$id',
        token: token,
        data: {
          'password': password,
          'confirmPassword': confirmPassword,
        }).then((value) {
      getUserData(id.toString());
      showToast(
        text: 'Update Successfully',
        state: ToastStates.SUCCESS,
      );
      emit(DocBookUpdatePasswordSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(DocBookUpdatePasswordErrorState());
    });
  }

  void updateDoctorPassword({
    String? id,
    String? password,
    String? confirmPassword,
  }) {
    emit(DoctorUpdatePasswordLoadingState());
    DioHelper.putData(
        url: '{doctor/account/changePassword/$id',
        token: token,
        data: {
          'password': password,
          'confirmPassword': confirmPassword,
        }).then((value) {
      getUserData(id.toString());
      showToast(
        text: 'Update Successfully',
        state: ToastStates.SUCCESS,
      );
      emit(DoctorUpdatePasswordSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(DoctorUpdatePasswordErrorState());
    });
  }

  AllDoctors? allDoctors;

  void getAllDoctors() async {
    if (doctor == null) {
      emit(AllDoctorsLoadingState());
      await DioHelper.getData(
        url: 'admin/accepted-doctors',
      ).then((value) {
        allDoctors = AllDoctors.fromJson(value.data);
        print(allDoctors!.message);
        emit(AllDoctorsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(AllDoctorsErrorState());
      });
    }
  }

  //ترتيب الحجوزات
  //استبعادالمواعيد الي خلاص خلصت
  //ولو معاد 4 عايز الميعاد يختفي الساعه5

  List<UserAppointment>appointments = [];

  //UserAppointment? userAppointment;
  void getUserAppointment(String? id) async {
    if (doctor == null) {
      emit(UserAppointmentLoadingState());
      appointments = [];
      DioHelper.getData(
          url: 'user/reservation/$id',
          token: token
      ).then((value) {
        //  appointments[0].time
        print("..............${value.data}..........");
        // appointments=value.data;
        value.data.forEach((element) {
          print("...........${element["time"]}.............");
          if (DateTime.tryParse(element["time"])!.isAfter(
              DateTime.now()) ||
              DateTime.tryParse(element["time"]).toString() ==
                  DateFormat("yyyyy-MM-dd").format(DateTime.now()).toString()) {
            appointments.add(UserAppointment.fromJson(element));
          } else {
            print("before");
          }
        });
        appointments.sort((a, b) { //sorting in ascending order
          return DateTime.parse(a.time!).compareTo(DateTime.parse(b.time!));
        });
        emit(UserAppointmentSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(UserAppointmentErrorState());
      });
    }
  }

  void deleteUserAppointment(String? id) async {
    if (doctor == null) {
      emit(DeleteAppointmentLoadingState());
      DioHelper.deleteData(
          url: 'doctor/getResrvationDay/$id',
          token: token
      ).then((value) {
        //  appointments[0].time
        print("..............${value.data}..........");

        emit(DeleteAppointmentSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(DeleteAppointmentErrorState());
      });
    }
  }

  Future<void> addReview({
    required String? id,
    required String name,
    required dynamic rating,
    required String comment,
    required String userId,
  }) async {
    emit(AddReviewLoadingState());
    await DioHelper.postData(
      url: 'doctor/$id/review',
      token: token,
      data: {
        'name': name,
        'rating': rating,
        'comment': comment,
        'user': userId,
      },
    ).then((value) {
      emit(AddReviewSuccessState());
    }).catchError((error) {
      emit(AddReviewErrorState());
    });
  }

  Future<void> addComplaints({
    required String? details,
    required String? userId,
    required String? doctorId,
  }) async {
    emit(AddComplaintsLoadingState());
    await DioHelper.postData(
      url: 'doctor/complaints/$doctorId',
      token: token,
      data: {
        'details': details,
        'user': userId,
        'doctor': doctorId
      },
    ).then((value) {
      emit(AddComplaintsSuccessState());
    }).catchError((error) {
      emit(AddComplaintsErrorState());
    });
  }

  Future<void> appComplaints({
    required String? details,
    required String? userName,
    required String? email,
  }) async {
    emit(AppComplaintsLoadingState());
    await DioHelper.postData(
      url: 'contactus',
      token: token,
      data: {
        'details': details,
        'userName': userName,
        'email': email
      },
    ).then((value) {
      emit(AppComplaintsSuccessState());
    }).catchError((error) {
      emit(AppComplaintsErrorState());
    });
  }


  DoctorReports? doctorReports;

  Future<void> getDoctorReports(String? id) async {
    if (doctor == true) {
      emit(GetDoctorReportsLoadingState());
      await DioHelper.getData(
          url: 'admin/accounts/$id',
          token: token
      ).then((value) {
        doctorReports = DoctorReports.fromJson(value.data);
        print('from cubit');
        print(doctorReports?.totals!.profit);
        print(doctorReports?.doctorData!.sId);
        emit(GetDoctorReportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetDoctorReportsErrorState());
      });
    }
  }

  DoctorAppointments? doctorAppointment;
  DateTime date = DateTime.now();
  List<DoctorAppointments>docAppointment = [];
  Future<void> getDoctorAppointment(String? id, String date) async {
    print(id);
    print("..............$date");
    if (doctor == true) {
      emit(GetDoctorAppointmentLoadingState());
      await DioHelper.getData(
        url: 'doctor/getResrvationDays/$id/time/$date',
        token: token,
      ).then((value) {
        //doctorAppointment=DoctorAppointments.fromJson(value.data);
        value.data.forEach((element) {
          docAppointment.add(DoctorAppointments.fromJson(element));
        });
        print('print from cubit');
        print(doctorAppointment!.sId);
        emit(GetDoctorAppointmentSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetDoctorAppointmentErrorState());
      });
    }
  }

}