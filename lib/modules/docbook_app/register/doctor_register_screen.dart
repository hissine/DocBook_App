import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ramdan_proj/modules/docbook_app/login/login_screen.dart';
import 'package:ramdan_proj/shared/styles/colors.dart';
import '../../../shared/components/components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class DoctorRegisterScreen extends StatefulWidget {
  DoctorRegisterScreen({Key? key}) : super(key: key);

  @override
  State<DoctorRegisterScreen> createState() => _DoctorRegisterScreenState();
}

class _DoctorRegisterScreenState extends State<DoctorRegisterScreen> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  final nameController = TextEditingController();

  final birthdateController = TextEditingController();

  final experienceController = TextEditingController();

  final phoneController = TextEditingController();

  String roles = 'doctor';

  String? specializationValue;

  List<String> specialization = <String>[
    'Cardiology(Heart)',
    'Neurology(Brain&Nerves)',
    'Pediatrics and New born',
    'Orthopedics(Bones)',
    'Chest and Respiratory',
    'Scan Centers',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (BuildContext context, state) {
        if (state is RegisterSuccessState) {
          navigateTo(context, DocLoginScreen());
          showToast(text: 'Regist is Done', state: ToastStates.SUCCESS);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
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
                            style:
                                Theme.of(context).textTheme.headline4!.copyWith(
                                      color: Colors.black,
                                    ),
                          ),
                          Text(
                            'Sign up now to browse our hot offers',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Colors.grey,
                                    ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your Name!';
                              } else {
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
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your email';
                              } else {
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
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your Phone';
                              } else {
                                return null;
                              }
                            },
                            label: 'Phone',
                            prefix: Icons.phone,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultFormField(
                            controller: experienceController,
                            type: TextInputType.number,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your Experience';
                              } else {
                                return null;
                              }
                            },
                            label: 'Years of experience',
                            prefix: Icons.verified,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultFormField(
                            controller: birthdateController,
                            type: TextInputType.datetime,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your birthdate';
                              } else {
                                return null;
                              }
                            },
                            label: '10-10-2010',
                            prefix: Icons.calendar_month,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'password must not be empty';
                              }
                              return null;
                            },
                            label: 'Create Password',
                            prefix: Icons.lock_outline,
                            isPassword: RegisterCubit.get(context).isPassword,
                            suffix: RegisterCubit.get(context).suffix,
                            suffixPressed: () {
                              RegisterCubit.get(context)
                                  .changeRegisterPasswordVisibility();
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultFormField(
                            controller: confirmPasswordController,
                            type: TextInputType.visiblePassword,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'password must not be empty';
                              } else if (value != passwordController.text) {
                                return 'password not match';
                              }
                              return null;
                            },
                            label: 'Confirm Password',
                            prefix: Icons.lock_outline,
                            isPassword: RegisterCubit.get(context)
                                .passwordConfirmVisible,
                            suffix: RegisterCubit.get(context)
                                .suffixPasswordConfirmVisible,
                            suffixPressed: () {
                              RegisterCubit.get(context)
                                  .changeRegisterConfirmPasswordVisibility();
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField(
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: defColor,
                                      size: 20,
                                    ),
                                    decoration: InputDecoration(
                                      hoverColor: defColor,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    hint: Text(
                                      'Specialization',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                    items: specialization
                                        .map(
                                          (item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    value: specializationValue,
                                    onChanged: (value) {
                                      setState(() {
                                        specializationValue = value as String;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: defaultFormField(
                                  controller: TextEditingController(),
                                  type: TextInputType.text,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter Your Session Prise';
                                    } else {
                                      return null;
                                    }
                                  },
                                  label: 'Session Prise',
                                  prefix: Icons.attach_money,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text('Profile Photo',
                                    style: TextStyle(
                                        color: defColor, fontSize: 18)),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  'License',
                                  style:
                                      TextStyle(color: defColor, fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    RegisterCubit.get(context)
                                        .getProfileImage(ImageSource.gallery);
                                  },
                                  child: Container(
                                    height: 45,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                              blurRadius: 1,
                                              spreadRadius: 1,
                                              color: Colors.grey)
                                        ]),
                                    child: Center(
                                      child: Text(
                                        'Upload Photo+',
                                        style: TextStyle(color: defColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    RegisterCubit.get(context)
                                        .getProfileImage(ImageSource.gallery);
                                  },
                                  child: Container(
                                    height: 45,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                              blurRadius: 1,
                                              spreadRadius: 1,
                                              color: Colors.grey)
                                        ]),
                                    child: Center(
                                      child: Text(
                                        'Upload Photo+',
                                        style: TextStyle(color: defColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            minLines: 3,
                            maxLines: 5,
                            controller: TextEditingController(),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'must not be empty';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              hintText: 'About me',
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ConditionalBuilder(
                            condition: state is! RegisterLoadingState,
                            builder: (BuildContext context) => defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  RegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    confirmPassword:
                                        confirmPasswordController.text,
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
                            fallback: (BuildContext context) => const Center(
                                child: CircularProgressIndicator()),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Already have an account'),
                              defaultTextButton(
                                function: () {
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
