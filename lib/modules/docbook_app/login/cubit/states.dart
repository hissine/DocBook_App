import 'package:ramdan_proj/models/docbook_app/getusermodel.dart';
import 'package:ramdan_proj/models/docbook_app/login_model.dart';

import '../../../../models/shop_app/profile_model.dart';

abstract class DocLoginStates {}

class DocLoginInitialState extends DocLoginStates {}

class DocLoginLoadingState extends DocLoginStates {}

class DocLoginSuccessState extends DocLoginStates {
  final LoginModel loginModel;
  DocLoginSuccessState(this.loginModel);
}

class DocLoginErrorState extends DocLoginStates {
  final String error;
  DocLoginErrorState(this.error);
}

class DocChangePasswordVisibilityState extends DocLoginStates {}


class DocBookLoadingUserDataState extends DocLoginStates {}

class DocBookSuccessUserDataState extends DocLoginStates {
  final GetUserModel userModel;
  DocBookSuccessUserDataState(this.userModel);
}

class DocBookErrorUserDataState extends DocLoginStates {
  final String error;
  DocBookErrorUserDataState(this.error);
}

class DocBookUpdateUserDataLoadingState extends DocLoginStates{}

class DocBookUpdateUserDataSuccessState extends DocLoginStates{}

class DocBookUpdateUserDataErrorState extends DocLoginStates{}

class DocBookUpdatePasswordLoadingState extends DocLoginStates{}

class DocBookUpdatePasswordSuccessState extends DocLoginStates{}

class DocBookUpdatePasswordErrorState extends DocLoginStates{}

class ChangeRadioState extends DocLoginStates{}

class LoginLoadingState extends DocLoginStates{}

class LoginSuccessState extends DocLoginStates{
  final LoginModel loginModel;
  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends DocLoginStates{}

class ConfirmPasswordVisibilityState extends DocLoginStates{}

class GetDoctorDataLoadingState extends DocLoginStates{}

class GetDoctorDataSuccessState extends DocLoginStates{}

class GetDoctorDataErrorState extends DocLoginStates{
  final String error;

  GetDoctorDataErrorState(this.error);
}

class DoctorUpdateDataLoadingState extends DocLoginStates{}

class DoctorUpdateDataSuccessState extends DocLoginStates{}

class DoctorUpdateDataErrorState extends DocLoginStates{}

class DoctorUpdatePasswordLoadingState extends DocLoginStates{}

class DoctorUpdatePasswordSuccessState extends DocLoginStates{}

class DoctorUpdatePasswordErrorState extends DocLoginStates{}

class GetDoctorPictureLoadingState extends DocLoginStates{}

class GetDoctorPictureSuccessState extends DocLoginStates{}

class GetDoctorPictureErrorState extends DocLoginStates{}

class AllDoctorsLoadingState extends DocLoginStates{}

class AllDoctorsSuccessState extends DocLoginStates{}

class AllDoctorsErrorState extends DocLoginStates{}

class UserAppointmentLoadingState extends DocLoginStates{}

class UserAppointmentSuccessState extends DocLoginStates{}

class UserAppointmentErrorState extends DocLoginStates{}

class DoctorProfileLoadingState extends DocLoginStates{}

class DoctorProfileSuccessState extends DocLoginStates{}

class DoctorProfileErrorState extends DocLoginStates{}

class AddReviewLoadingState extends DocLoginStates{}

class AddReviewSuccessState extends DocLoginStates{}

class AddReviewErrorState extends DocLoginStates{}

class AddComplaintsLoadingState extends DocLoginStates{}

class AddComplaintsSuccessState extends DocLoginStates{}

class AddComplaintsErrorState extends DocLoginStates{}

class AppComplaintsLoadingState extends DocLoginStates{}

class AppComplaintsSuccessState extends DocLoginStates{}

class AppComplaintsErrorState extends DocLoginStates{}

class GetDoctorReportsLoadingState extends DocLoginStates{}

class GetDoctorReportsSuccessState extends DocLoginStates{}

class GetDoctorReportsErrorState extends DocLoginStates{}

class GetDoctorAppointmentLoadingState extends DocLoginStates{}

class GetDoctorAppointmentSuccessState extends DocLoginStates{}

class GetDoctorAppointmentErrorState extends DocLoginStates{}

class DeleteAppointmentLoadingState extends DocLoginStates{}

class DeleteAppointmentSuccessState extends DocLoginStates{}

class DeleteAppointmentErrorState extends DocLoginStates{}










