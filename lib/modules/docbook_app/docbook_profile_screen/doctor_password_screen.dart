import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramdan_proj/modules/docbook_app/login/cubit/cubit.dart';
import 'package:ramdan_proj/modules/docbook_app/login/cubit/states.dart';
import 'package:ramdan_proj/modules/docbook_app/login/login_screen.dart';
import 'package:ramdan_proj/shared/components/components.dart';
import 'package:ramdan_proj/shared/styles/colors.dart';

import '../../../shared/components/constants.dart';

class DocPasswordScreen extends StatelessWidget {
  const DocPasswordScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var passwordController = TextEditingController();
    var confirmPasswordController = TextEditingController();
    var formKey=GlobalKey<FormState>();
    return BlocConsumer<DocLoginCubit,DocLoginStates>(
      listener: (BuildContext context, state) {
        if(state is DoctorUpdatePasswordSuccessState) {
          navigateAndFinish(context, DocLoginScreen());
        }
      },
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: defColor,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(40),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Change Password',
                      style: TextStyle(
                        color: defColor,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    /*defaultFormField(
                      controller: TextEditingController(),
                      type: TextInputType.visiblePassword,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'must not be empty';
                        }
                        return null;
                      },
                      label: 'Current Password',
                      prefix: Icons.visibility_off_outlined,
                    ),
                    SizedBox(
                      height: 10,
                    ),*/
                    defaultFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        isPassword: DocLoginCubit.get(context).isPassword,
                        suffixPressed: () {
                          DocLoginCubit.get(context)
                              .changePasswordVisibility();
                        },
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'must not be empty';
                          }
                          return null;
                        },
                        label: 'New Password',
                        prefix: Icons.lock,
                        suffix:Icons.visibility_off_outlined
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultFormField(
                        controller: confirmPasswordController,
                        type: TextInputType.visiblePassword,
                        isPassword: DocLoginCubit.get(context).passwordConfirmVisible,
                        suffixPressed: () {
                          DocLoginCubit.get(context)
                              .changeConfirmPasswordVisibility();
                        },
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'must not be empty';
                          }else if(value != passwordController.text){
                            return 'password not match';
                          }
                          return null;
                        },
                        label: 'Confirm Password',
                        prefix: Icons.lock,
                        suffix: Icons.visibility_off_outlined
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: (){
                            if(formKey.currentState!.validate()){
                              DocLoginCubit.get(context).updateDoctorPassword(
                                id: userid,
                                password: passwordController.text,
                                confirmPassword: confirmPasswordController.text,
                              );
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: defColor,
                                borderRadius: BorderRadius.circular(20)),
                            width: 150,
                            height: 40,
                            child:const Center(
                              child: Text(
                                'Save',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Image(
                      image: AssetImage(
                          'assets/images/password.png'
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },

    );
  }
}
