import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramdan_proj/layout/docbook_app/cubit/cubit.dart';
import 'package:ramdan_proj/models/docbook_app/medications.dart';
import 'package:ramdan_proj/shared/components/components.dart';
import 'package:ramdan_proj/shared/components/constants.dart';
import 'package:ramdan_proj/shared/styles/colors.dart';

import '../../../layout/docbook_app/cubit/states.dart';

class Medications extends StatelessWidget {
  Medications({Key? key}) : super(key: key);

  var medicationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DocBookCubit, DocBookStates>(
      listener: (context, state) {
        if (state is AddMedicationSuccessState) {
          showToast(
              text:
              'Your Medications has been add Successfully',
              state: ToastStates.SUCCESS);
          DocBookCubit.get(context).viewMedications(userid).then((value) {
            Navigator.pop(context);
          });
        }
      },
      builder: (context, state) {
        var list=DocBookCubit.get(context).medications!.medicines;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Medications',
              style: TextStyle(
                color: defColor,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: defColor,
              ),
            ),
            elevation: 8.0,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Add Medication',
                            style: TextStyle(
                              color: defColor,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: medicationController,
                            decoration: InputDecoration(
                                hintText: 'Medication Name',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: defColor,
                                    width: 1,
                                  ),
                                ),
                                filled: true),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
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
                                    child: Center(
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                          color: defColor,
                                        ),
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
                                    DocBookCubit.get(context)
                                        .addMedication(
                                      userid,
                                      medicationController.text,
                                    );
                                  },
                                  child: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                          spreadRadius: 1,
                                          blurRadius: 1,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Submit',
                                        style: TextStyle(
                                          color: defColor,
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
            child: const Icon(
              Icons.add,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ConditionalBuilder(
              condition: list!.isNotEmpty,
              builder: (BuildContext context) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context,index)=>medicationBuilder(list[index]),
                        separatorBuilder: (context,index)=>const SizedBox(
                          height: 20,
                        ),
                        itemCount: list.length,
                      ),
                    ),
                  ],
                );
              },
              fallback: (BuildContext context) {
                return Column(
                  children:const [
                    Image(
                        image:AssetImage(
                          'assets/images/items.png'
                        )
                    ),
                    Text(
                      'Add Your first Medication!',
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget medicationBuilder(Medicines model) => Row(
    children: [
      Icon(
        Icons.circle,
        color: defColor,
        size: 20,
      ),
      const SizedBox(
        width: 20,
      ),
      Text(
        model.content??'not found',
        style: const TextStyle(
          fontSize: 22,
        ),
      ),
    ],
  );
}

