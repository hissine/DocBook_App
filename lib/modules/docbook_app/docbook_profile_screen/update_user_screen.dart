import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramdan_proj/modules/docbook_app/login/cubit/cubit.dart';
import 'package:ramdan_proj/modules/docbook_app/login/cubit/states.dart';
import 'package:ramdan_proj/shared/components/constants.dart';
import 'package:ramdan_proj/shared/styles/colors.dart';

class SettingsDocScreen extends StatefulWidget {
  const SettingsDocScreen({Key? key}) : super(key: key);

  @override
  State<SettingsDocScreen> createState() => _SettingsDocScreenState();
}

class _SettingsDocScreenState extends State<SettingsDocScreen> {
  List<String> martialStatus = <String>[
    'Single',
    'Married',
    'Widower',
    'Divorced'
  ];

  List<String> blood = <String>['A', 'B', 'AB', 'O'];

  List<String> smoker = <String>['Smoking', 'Not smoking'];
  String? bloodValue;
  String? smokerValue;
  String? martialStatusValue;

  final formKey=GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DocLoginCubit,DocLoginStates>(
      listener: (BuildContext context, state) {
        if(state is DocBookSuccessUserDataState){
        }

      },
      builder: (BuildContext context, Object? state) {
        var cubit = DocLoginCubit.get(context);
        var model = DocLoginCubit.get(context).userModel;
        cubit.nameController.text='${model?.userName}';
        cubit.emailController.text='${model?.email}';
        cubit.allergiesController.text='${model?.allergies}';
        cubit.heightController.text='${model?.height}';
        cubit.weightController.text='${model?.weight}';
        cubit.bloodController.text='${model?.blood}';
        cubit.martialController.text='${model?.maritalStatus}';
        cubit.smokerController.text='${model?.smoking}';
        cubit.ageController.text='${model?.birthDate}';
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
              padding:const EdgeInsets.only(
                left: 20,
                right: 20
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'User information',
                      style: TextStyle(
                        color: defColor,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: cubit.nameController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'must not be empty';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                        labelText: 'User Name',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: cubit.emailController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'must not be empty';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                        labelText: 'E-mail',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: cubit.martialController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'must not be empty';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                        labelText: 'Marital Status',
                      ),
                    ),
                    /*
                    DropdownButtonHideUnderline(
                      child: DropdownButtonFormField(
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: defColor,
                          size: 30,
                        ),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )
                        ),
                        hint: Text(
                          'Marital Status',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: martialStatus
                            .map(
                              (item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        )
                            .toList(),
                        value: martialStatusValue,
                        onChanged: (value) {
                          setState(() {
                            martialStatusValue = value as String;
                          });
                        },
                      ),

                    ),*/
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: cubit.allergiesController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'must not be empty';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                        labelText: 'Allergies',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                TextFormField(
                  controller: cubit.bloodController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'must not be empty';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    labelText: 'Blood',
                  ),
                ),
                    /*
                    DropdownButtonHideUnderline(
                      child: DropdownButtonFormField(
                        icon: Icon(Icons.keyboard_arrow_down,color: defColor,size: 30,),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )
                        ),
                        hint: Text(
                          'Blood',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: blood
                            .map(
                              (item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        )
                            .toList(),
                        value: bloodValue,
                        onChanged: (value) {
                          setState(() {
                            bloodValue = value as String;
                          });
                        },
                      ),
                    ),*/
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: cubit.smokerController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'must not be empty';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                        labelText: 'Smoking',
                      ),
                    ),
                    /*
                    DropdownButtonHideUnderline(
                      child: DropdownButtonFormField(
                        icon: Icon(Icons.keyboard_arrow_down,color: defColor,size: 30,),
                        decoration: InputDecoration(
                          hoverColor: defColor,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        hint: Text(
                          'Smoking',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: smoker
                            .map(
                              (item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        )
                            .toList(),
                        value: smokerValue,
                        onChanged: (value) {
                          setState(() {
                            smokerValue = value as String;
                          });
                        },
                      ),
                    ),*/
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: cubit.heightController,
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
                              labelText: 'Height',
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: cubit.weightController,
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
                              labelText: 'Weight',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap:(){
                            if(formKey.currentState!.validate()){
                              DocLoginCubit.get(context)
                                    .updateUser(
                                  id: userid,
                                  userName: cubit.nameController.text,
                                  //email: cubit.emailController.text,
                                  maritalStatus: cubit.martialController.text,
                                  allergies: cubit.allergiesController.text,
                                  blood: cubit.bloodController.text,
                                  height: cubit.heightController.text,
                                  weight: cubit.weightController.text,
                                  smoking: cubit.smokerController.text,
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
                    const SizedBox(
                      height: 20,
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
