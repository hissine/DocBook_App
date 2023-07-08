
import '../../../../models/docbook_app/login_model.dart';

abstract class RegisterStates{}

class RegisterInitialState extends RegisterStates{}

class RegisterLoadingState extends RegisterStates{}

class RegisterSuccessState extends RegisterStates{
  final LoginModel loginModel;
  RegisterSuccessState(this.loginModel);

}

class RegisterErrorState extends RegisterStates{
  final String error;
  RegisterErrorState(this.error);

}
class ChangeRadioState extends RegisterStates{}

class ChangeRadioServiceState extends RegisterStates{}

class RegisterChangePasswordVisibilityState extends RegisterStates{}

class RegisterConfirmPasswordVisibilityState extends RegisterStates{}

class ImagePickerProfileSuccess extends RegisterStates{}
