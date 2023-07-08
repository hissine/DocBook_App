import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramdan_proj/layout/docbook_app/cubit/cubit.dart';
import 'package:ramdan_proj/layout/docbook_app/cubit/states.dart';
import 'package:ramdan_proj/models/docbook_app/notes_model.dart';
import 'package:ramdan_proj/shared/styles/colors.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var list = DocBookCubit.get(context).notes;
    var list=DocBookCubit.get(context).userNote!.notes;
    return BlocConsumer<DocBookCubit,DocBookStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back,color: defColor,),
              onPressed: () {
                Navigator.pop(context);
              },

            ),
            title: Text(
              'Notes',
              style: TextStyle(
                color: defColor,
                fontSize: 30,
              ),
            ),
            centerTitle: true,
            elevation: 8.0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                ConditionalBuilder(
                  condition: list!.isNotEmpty,
                  builder: (BuildContext context) {
                    return Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => buildNote(list[index]),
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: list.length,
                      ),
                    );
                  },
                  fallback: (BuildContext context) {
                    return Column(
                      children:const [
                        Image(
                          image: AssetImage(
                          'assets/images/no_notes.png'
                          ),
                        ),
                        Text(
                          'There is no notes yet!',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildNote(Notes? note) => Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      children: [
        Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(blurRadius: 2, spreadRadius: 2, color: Colors.grey),
                ],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      color: defColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        '${note!.content??'not found'}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.edit_note,color: defColor,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        '${note.doctor!.userName??'unknown'}',
                        style: TextStyle(
                          color: defColor
                        ),
                      ),
                      Spacer(),
                      Text(
                        '${note.doctor!.specialty??'unkown'}',
                        style: TextStyle(
                          color: defColor
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
      ],
    ),
  );
}
