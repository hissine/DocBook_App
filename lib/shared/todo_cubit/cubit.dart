import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramdan_proj/shared/network/local/cashe_helper.dart';
import 'package:ramdan_proj/shared/todo_cubit/states.dart';
import 'package:sqflite/sqflite.dart';
import '../../modules/todo_app/archived_tasks/archived_tasks_screen.dart';
import '../../modules/todo_app/done_tasks/done_tasks_screen.dart';
import '../../modules/todo_app/new_tasks/new_tasks_screen.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit():super(AppInitialState());

  static AppCubit get(context)=>BlocProvider.of(context);
  int curIndex = 0;
  List<Widget> screens = [
     const NewTasksScreen(),
     const DoneTasksScreen(),
     const ArchivedTasksScreen(),
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeIndex(int index){
    curIndex=index;
    emit(AppChangeBottomNavBarState());
  }

  Database? database;
  List<Map> newTasks=[];
  List<Map> doneTasks=[];
  List<Map> archivedTasks=[];
  void createDatabase() {
    openDatabase(
        'todoapp.db',
        version: 1,
        onCreate: (database, version) {
          print('database created');
          database
              .execute(
              'CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
              .then((value) {
            print('table created');
          }).catchError((error) {
            print('error when creating table ${error.toString()}');
          });
        }, onOpen: (database) {
      //عشان احنا عايزين نعمل جيت داتا بيز لما نفتح الداتابيز عشان يجيب الداتا الموجوده اصلا
          getDataFromDatabase(database);
          print('database opened');
        }).then((value) {
          database = value;
          emit(AppCreateDataBaseState());
    });
  }

  insertToDatabase({
    required title,
    required date,
    required time,
  }) async {
    await database?.transaction((txn) {
      var result = txn
          .rawInsert(
          'INSERT INTO tasks(title,date,time,status) VALUES("$title","$date","$time","new")')
          .then((value) {
        print('$value inserted successfully');
        emit(AppInsertDataBaseState());
        //عشان احنا عايزين نجيب الداتا بيز الجديده بعد ما نعمل انسيرت عشان تظهر علطول من غير ريفريش
        getDataFromDatabase(database);
          }).catchError((error) {
        print('error when inserting new record ${error.toString()}');
      });
      return result;
    });
  }

  void getDataFromDatabase(database){
    newTasks=[];
    doneTasks=[];
    archivedTasks=[];
    emit(AppGetDataBaseLoadingState());
    database!.rawQuery('SELECT * FROM tasks').then((value) {
      //مينفعش يبقا فيه اي مشكلة هنا
      value.forEach((element) {
        //اليمنت اوف ستيتوس == نيو يعني بقارن الستيتوس بتاعت الايليمنت ب الحاله التانيه
        // عشان كدا التانيه مش بتتحط جوا براكيتس
        if(element['status'] == 'new') {
          newTasks.add(element);
        } else if(element['status'] == 'done') {
          doneTasks.add(element);
        } else{
          archivedTasks.add(element);
        }
      });
      emit(AppGetDataBaseState());
    });
  }

  void updateData({
    required String status,
    required int id,
}){
    database!.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        [status, id]
    ).then((value) {
      getDataFromDatabase(database);
      //عشان لما ادوس ابديت اجيب الداتا من الداتا بيز بعد ما اتعملها ابديت
      emit(AppUpdateDataBaseState());
    });
  }

  void deleteData({
    required int id,
  }){
    database!.rawDelete(
        'DELETE FROM tasks WHERE id = ?',
        [id]
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDataBaseState());
    });
  }
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
}){
    isBottomSheetShown=isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }
  bool isDark = false;
  void changeAppMode({
  bool? fromShared,
}){
    if(fromShared!=null) {
      isDark=fromShared;
      emit(AppChangeModeState());
    } else{
      isDark = !isDark;
      CasheHelper.putBool(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}