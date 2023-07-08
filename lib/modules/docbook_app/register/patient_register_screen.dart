import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramdan_proj/modules/docbook_app/login/login_screen.dart';
import 'package:ramdan_proj/shared/styles/colors.dart';
import '../../../shared/components/components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class PatientRegisterScreen extends StatelessWidget {
  PatientRegisterScreen({Key? key}) : super(key: key);
  final formKey= GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final birthdateController = TextEditingController();
  String roles='user';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit,RegisterStates>(
      listener: (BuildContext context, state) {
        if(state is RegisterSuccessState){
          navigateTo(context, DocLoginScreen());
          showToast(text: 'Regist is Done', state: ToastStates.SUCCESS);

        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body:Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sign up',
                            style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Sign up now to browse our hot offers',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color:Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (value){
                              if(value!.isEmpty)
                              {
                                return 'Please Enter Your Name!';
                              }else{
                                return null;
                              }
                            },
                            label: 'User Name',
                            prefix: Icons.person,

                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (value){
                              if(value!.isEmpty)
                              {
                                return 'Please Enter Your email';
                              }else{
                                return null;
                              }
                            },
                            label: 'E-mail',
                            prefix: Icons.email_outlined,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultFormField(
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              validate: (value){
                                if(value!.isEmpty){
                                  return 'password must not be empty';
                                }
                                return null;
                              },
                              label: 'Create Password',
                              prefix: Icons.lock_outline,
                              isPassword: RegisterCubit.get(context).isPassword,
                              suffix: RegisterCubit.get(context).suffix,
                              suffixPressed:(){
                                RegisterCubit.get(context).changeRegisterPasswordVisibility();
                              },
                          ),
                          const SizedBox(height: 20,),
                          defaultFormField(
                            controller: confirmPasswordController,
                            type: TextInputType.visiblePassword,
                            validate: (value){
                              if(value!.isEmpty){
                                return 'password must not be empty';
                              }else if(value!=passwordController.text){
                                return 'password not match';
                              }
                              return null;
                            },
                            label: 'Confirm Password',
                            prefix: Icons.lock_outline,
                            isPassword: RegisterCubit.get(context).passwordConfirmVisible,
                            suffix: RegisterCubit.get(context).suffixPasswordConfirmVisible,
                            suffixPressed:(){
                              RegisterCubit.get(context).changeRegisterConfirmPasswordVisibility();
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultFormField(
                            controller: birthdateController,
                            type: TextInputType.text,
                            validate: (value){
                              if(value!.isEmpty)
                              {
                                return 'Please Enter Your birthdate';
                              }else{
                                return null;
                              }
                            },
                            label: '2001-12-31',
                            prefix: Icons.calendar_month,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ConditionalBuilder(
                            condition: state is! RegisterLoadingState,
                            builder: (BuildContext context) =>
                                defaultButton(
                                  function: (){
                                    if(formKey.currentState!.validate()){
                                      RegisterCubit.get(context).userRegister(
                                        name: nameController.text,
                                        email:emailController.text ,
                                        password: passwordController.text,
                                        confirmPassword: confirmPasswordController.text,
                                        birthDate: birthdateController.text,
                                        roles: 'user',
                                      );
                                    }
                                  },
                                  text: 'Join now',
                                  background: defColor,
                                  isUpperCase: true,
                                  radius: 5.0,
                                ),
                            fallback: (BuildContext context)=>
                            const Center(
                                child:
                                CircularProgressIndicator()
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Already have an account'),
                              defaultTextButton(
                                function: (){
                                  navigateTo(
                                    context,
                                    DocLoginScreen(),
                                  );
                                },
                                text: 'login',

                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
