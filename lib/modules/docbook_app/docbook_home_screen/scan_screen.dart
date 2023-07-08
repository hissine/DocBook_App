
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';import 'package:ramdan_proj/shared/styles/colors.dart';

import '../../../layout/docbook_app/cubit/cubit.dart';
import '../../../layout/docbook_app/cubit/states.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Scan',
          style: TextStyle(
            color: defColor,
            fontSize: 28
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<DocBookCubit,DocBookStates>(
        listener: (context, state) {
          if(state is  UploadImageSuccessState){
            DocBookCubit.get(context).getResult(state.image
            );
          }
          if(state is GetResultSuccessState){
            showDialog(context: context, builder: (context) {
              return AlertDialog(
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        DocBookCubit.get(context).result=='yes' ? "You have this diseas ":'You dont have this diseas',
                        style: TextStyle(
                          color: defColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
        builder: (context, state) {
          return  Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                const Image(
                  image: AssetImage
                    (
                    'assets/images/scanscreen.png',
                  ),
                ),
                Text(
                  'Liver MRI Scan',
                  style: TextStyle(
                    fontSize: 18,
                    color: defColor,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Scan your MRI and get the result immediately',
                  style: TextStyle(
                      fontSize: 14,
                      color: defColor
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    DocBookCubit.get(context).getProfileImage(ImageSource.gallery);
                  },

                  child: Container(
                    width: 150,
                    height: 40,
                    decoration: BoxDecoration(
                      color: defColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const[
                        Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 18,
                        ),
                        Text(
                          'Upload image',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
         },
        ),
     );
  }
}
