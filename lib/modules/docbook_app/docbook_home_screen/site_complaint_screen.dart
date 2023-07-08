import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramdan_proj/modules/docbook_app/login/cubit/cubit.dart';
import 'package:ramdan_proj/modules/docbook_app/login/cubit/states.dart';
import 'package:ramdan_proj/shared/components/components.dart';
import '../../../layout/docbook_app/docbook_layout.dart';
import '../../../shared/styles/colors.dart';

class ComplaintsScreen extends StatelessWidget {
  ComplaintsScreen({Key? key}) : super(key: key);
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var complaintsController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DocLoginCubit,DocLoginStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: defColor,
              ),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello',
                    style: TextStyle(
                      color: defColor,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    width: 250,
                    child: Text(
                      'Contact us any time. we will get back to you as soon as we can!',
                      style: TextStyle(
                          fontSize: 16
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Your name',
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'must not be empty';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0))
                        ),
                      hintText: ('example')
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'E-mail',
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'must not be empty';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0))
                        ),
                      hintText: 'example@gmail.com'
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Message',
                    style: TextStyle(
                        color: defColor
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    minLines: 1,
                    maxLines: 4,
                    controller: complaintsController,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(
                          color: Colors.grey
                      ),
                      hintText: 'add complaints',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: (){
                      DocLoginCubit.get(context).appComplaints(
                          details: complaintsController.text,
                          userName: nameController.text,
                          email: emailController.text,
                      ).then((value){
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: defColor,
                              content: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'Nice To Meet You We Will Chat Soon!',
                                      style: TextStyle(
                                          color: Colors.white
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    InkWell(
                                      onTap: (){
                                        navigateTo(context,const DocBookLayout());
                                      },
                                      child: Container(
                                        width: 200,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child:Center(
                                          child: Text(
                                            'Back To Home',
                                            style: TextStyle(
                                                color: defColor
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: defColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: 150,
                      height: 40,
                      child: const Center(
                        child: Text(
                          'Send',
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
