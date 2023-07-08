import 'dart:core';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramdan_proj/layout/docbook_app/docbook_layout.dart';
import 'package:ramdan_proj/modules/docbook_app/login/cubit/cubit.dart';
import 'package:ramdan_proj/modules/docbook_app/login/cubit/states.dart';
import 'package:ramdan_proj/modules/docbook_app/register/doctor_register_screen.dart';
import 'package:ramdan_proj/modules/docbook_app/register/patient_register_screen.dart';
import 'package:ramdan_proj/shared/components/components.dart';
import 'package:ramdan_proj/shared/components/constants.dart';
import 'package:ramdan_proj/shared/styles/colors.dart';

import '../../../layout/docbook_app/doctor_layout_screen.dart';
import '../../../shared/network/local/cashe_helper.dart';

class DocLoginScreen extends StatelessWidget {
  DocLoginScreen({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DocLoginCubit, DocLoginStates>(
      listener: (BuildContext context, state) {
        if(state is LoginSuccessState){
          print(state.loginModel.role);
          print('logged in from Here!!!!');
          CasheHelper.saveData(key: 'token', value: state.loginModel.token).then((value) {
            CasheHelper.saveData(key: 'doctor', value: isDoctor(context,state.loginModel.role![0]));
            CasheHelper.saveData(key: 'userid', value: state.loginModel.userId);
            DocLoginCubit.get(context).getDoctorData(userid.toString());
            DocLoginCubit.get(context).getDoctorReports(userid.toString());
            token = state.loginModel.token;
            userid=state.loginModel.userId;
            role=state.loginModel.role;
            print(userid);
            print(role);
            if (state.loginModel.role![0] == "doctor") {
              navigateAndFinish(context, const DoctorLayout());
            }
          });

          showToast(
            text: state.loginModel.message!.toString(),
            state: ToastStates.SUCCESS,
          );
        }
        if (state is DocLoginSuccessState) {
          if (state.loginModel.status == null) {
            print(state.loginModel.role);
            CasheHelper.saveData(key: 'token', value: state.loginModel.token,)
                .then((value) {
              CasheHelper.saveData(key: 'userid', value: state.loginModel.userId,);
              token = state.loginModel.token;
              userid = state.loginModel.userId;
              role=state.loginModel.role;
              print(state.loginModel.role);
              DocLoginCubit.get(context).getUserData(userid.toString());
              DocLoginCubit.get(context).getUserAppointment(userid);
              DocLoginCubit.get(context).getAllDoctors();
              if (state.loginModel.role![0] == "user") {
                navigateAndFinish(context, const DocBookLayout());
              }
            });
            showToast(
              text: state.loginModel.message!.toString(),
              state: ToastStates.SUCCESS,
            );
          } else {
            showToast(
              text: state.loginModel.message!,
              state: ToastStates.ERROR,
            );
          }
        } else if (state is DocLoginErrorState||state is LoginErrorState) {
          showToast(
            text:
                'This credentials does not meet any of ou..r records, please make sure you have entered the right credentials',
            state: ToastStates.ERROR,
          );
        }
      },
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('DocBook'),
          ),
          body: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hello.',
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Welcome Back.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.text,
                        validate: (value){
                          if (value!.isEmpty) {
                            return 'Email Address must not be empty';
                          }
                          return null;
                        },
                        label: 'User name',
                        prefix: Icons.person,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        validate: (value){
                          if (value!.isEmpty) {
                            return 'Password is not right';
                          }
                          return null;
                        },
                        label: 'Password',
                        prefix: Icons.lock,
                        suffix: DocLoginCubit.get(context).suffix,
                        isPassword: DocLoginCubit.get(context).isPassword,
                        suffixPressed: () {
                          DocLoginCubit.get(context)
                              .changePasswordVisibility();
                        },
                        onSubmit: (value) {
                          if(DocLoginCubit.get(context).radioValue=='doctor'){
                            if (formKey.currentState!.validate()) {
                              DocLoginCubit.get(context).doctorLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          }else if(DocLoginCubit.get(context).radioValue=='patient'){
                            if (formKey.currentState!.validate()) {
                              DocLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          }else{
                            showToast(text: 'Choose Radio Button Please', state: ToastStates.ERROR);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildRadioBig('doctor', context),
                          buildRadioBig('patient', context),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ConditionalBuilder(
                        condition: state is! DocLoginLoadingState || state is! LoginLoadingState,
                        builder: (context) => defaultButton(
                            function: () {
                              if(DocLoginCubit.get(context).radioValue=='doctor'){
                                if (formKey.currentState!.validate()) {
                                  DocLoginCubit.get(context).doctorLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                   print('logged in as a doctor ');
                                }
                              }else if(DocLoginCubit.get(context).radioValue=='patient'){
                                if (formKey.currentState!.validate()) {
                                  DocLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                  print('logged in as a user');
                                }
                              }else{
                                showToast(text: 'Choose Radio Button Please', state: ToastStates.ERROR);
                              }
                            },
                            background: defColor,
                            text: 'Join now',
                            isUpperCase: false,
                            radius: 15.0),
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t Have an account? ',
                          ),
                          TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: SizedBox(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text('Are You ?'),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: InkWell(
                                                  onTap:(){
                                                    navigateTo(context, PatientRegisterScreen());
                                                  },
                                                  child: Container(
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                      color: defColor,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                        10,
                                                      ),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                            spreadRadius: 1,
                                                            blurRadius: 1,
                                                            color: Colors.grey,
                                                        ),
                                                      ],
                                                    ),
                                                    child: const Center(
                                                      child: Text(
                                                        'Patient',
                                                        style: TextStyle
                                                          (
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                'OR',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: InkWell(
                                                  onTap:(){
                                                    navigateTo(context, DoctorRegisterScreen());
                                                  },
                                                  child: Container(
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                      color: defColor,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          10),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          spreadRadius: 1,
                                                          blurRadius: 1,
                                                          color: Colors.grey,
                                                        ),
                                                      ],
                                                    ),
                                                    child: const Center(
                                                      child: Text(
                                                        'Doctor',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Text(
                                'Sign Up!',
                              style: TextStyle(
                                color: defColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );

      },
    );

  }
  Widget buildRadioBig(String value, context) {
    return Row(
      children: [
        Radio(
            value: value,
            activeColor: defColor,
            groupValue: DocLoginCubit.get(context).radioValue,
            onChanged: (value) {
              DocLoginCubit.get(context).changeRadio(value);
            }),
        Text(
          value,
          style:const TextStyle(fontSize: 16),
        )
      ],
    );
  }
}
