import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramdan_proj/shared/components/components.dart';
import 'package:ramdan_proj/shared/todo_cubit/cubit.dart';
import 'package:ramdan_proj/shared/todo_cubit/states.dart';

class NewTasksScreen extends StatelessWidget {
  const NewTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return BlocConsumer<AppCubit,AppStates>(
       listener: (BuildContext context, state) {  },
       builder: (BuildContext context, Object? state) {
         var tasks = AppCubit.get(context).newTasks;
         return  buildBuilder(tasks: tasks,doneShow: true,archivedShow: true);
       },
     );
  }
}