import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramdan_proj/modules/docbook_app/login/cubit/cubit.dart';
import 'package:ramdan_proj/modules/docbook_app/login/cubit/states.dart';
import 'package:ramdan_proj/shared/components/components.dart';
import 'package:ramdan_proj/shared/components/constants.dart';
import 'package:ramdan_proj/shared/styles/colors.dart';

class EditDocScreen extends StatefulWidget {
  const EditDocScreen({Key? key}) : super(key: key);

  @override
  State<EditDocScreen> createState() => _EditDocScreenState();
}

class _EditDocScreenState extends State<EditDocScreen> {

  @override
  Widget build(BuildContext context) {
    var cubit = DocLoginCubit.get(context);
    var model = DocLoginCubit.get(context).doctorModel;
    var formKey=GlobalKey<FormState>();
    cubit.doctorNameController.text='${model?.userName}';
    cubit.doctorPriceController.text='${model?.price}';
    cubit.aboutDoctorController.text='${model?.aboutMe}';
    return BlocConsumer<DocLoginCubit,DocLoginStates>(
      listener: (context,state){},
      builder: (context,state){
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
              padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 10
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                                '${model?.photo??const AssetImage('assets/images/man.png')}',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: cubit.doctorNameController,
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
                      controller: cubit.specialtyController,
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
                        labelText: 'specialty',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: cubit.doctorPriceController,
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
                        labelText: 'Prize',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      minLines: 3,
                      maxLines: 5,
                      controller: cubit.aboutDoctorController,
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
                        labelText: 'About me',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: (){
                            if(formKey.currentState!.validate()){
                              DocLoginCubit.get(context)
                                  .updateDoctor(
                                id: userid,
                                userName: cubit.doctorNameController.text,
                                price: cubit.doctorPriceController.text,
                                specialty: cubit.specialtyController.text,
                                aboutMe: cubit.aboutMeController.text,
                              );
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: defColor,
                                borderRadius: BorderRadius.circular(20)),
                            width: 150,
                            height: 40,
                            child: const Center(
                              child: Text(
                                'Save',
                                style: TextStyle(color: Colors.white),
                              ),
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
        );
      },
    );
  }
}
