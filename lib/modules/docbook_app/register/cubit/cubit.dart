import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ramdan_proj/models/docbook_app/login_model.dart';
import 'package:ramdan_proj/modules/docbook_app/register/cubit/states.dart';
import 'package:ramdan_proj/shared/components/components.dart';
import 'package:ramdan_proj/shared/network/remote/dio_helper/dio_helper.dart';


class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit(): super(RegisterInitialState());

  static RegisterCubit get(context)=>BlocProvider.of(context);



  IconData suffix= Icons.visibility_outlined;
  bool isPassword=true;
  void changeRegisterPasswordVisibility(){
    isPassword=!isPassword;
    suffix= isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibilityState());
  }

  IconData suffixPasswordConfirmVisible=Icons.visibility_outlined;
  bool passwordConfirmVisible=true;
  void changeRegisterConfirmPasswordVisibility(){
    passwordConfirmVisible=!passwordConfirmVisible;
    suffixPasswordConfirmVisible=passwordConfirmVisible?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(RegisterConfirmPasswordVisibilityState());
  }

  String radioValue='';
  void changeRadio(value){
    radioValue=value;
    emit(ChangeRadioState());
  }

  final ImagePicker picker = ImagePicker();
  File? profileImage;

  Future getProfileImage(
      ImageSource source,
      ) async {
    final XFile? image = await picker.pickImage(
        source: source, imageQuality: 50, maxHeight: 500, maxWidth: 500);
    if (image == null) {
      return null;
    }
    profileImage = File(image.path);
    emit(ImagePickerProfileSuccess());
  }

  LoginModel? loginModel;
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String birthDate,
    required String roles,
  })async{
    emit(RegisterLoadingState());
    DioHelper.postData(
        url: '/auth/signupUser',
        data: {
          'userName':name,
          'email':email,
          'password':password,
          'confirmPassword':confirmPassword,
          'birthDate':birthDate,
          'roles':'user'
        },
    ).then((value) {
      print(value.data);
      loginModel=LoginModel.fromJson(value.data);
      emit(RegisterSuccessState(loginModel!));
    }).catchError((error){
      if(error is DioError){
        loginModel = LoginModel.fromJson(error.response!.data);
        showToast(text: 'Cant Register', state: ToastStates.ERROR);
      }
      emit(RegisterErrorState(error.toString()));
    });
  }
}