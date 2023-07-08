import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ramdan_proj/layout/docbook_app/cubit/cubit.dart';
import 'package:ramdan_proj/modules/docbook_app/docbook_home_screen/medications.dart';
import 'package:ramdan_proj/modules/docbook_app/login/cubit/cubit.dart';
import 'package:ramdan_proj/modules/docbook_app/register/cubit/cubit.dart';
import 'package:ramdan_proj/shared/bloc_observer/bloc_observer.dart';
import 'package:ramdan_proj/shared/components/constants.dart';
import 'package:ramdan_proj/shared/network/local/cashe_helper.dart';
import 'package:ramdan_proj/shared/network/remote/dio_helper/dio_helper.dart';
import 'package:ramdan_proj/shared/styles/themes.dart';
import 'package:ramdan_proj/shared/todo_cubit/cubit.dart';
import 'layout/docbook_app/docbook_layout.dart';
import 'layout/docbook_app/doctor_layout_screen.dart';
import 'modules/docbook_app/login/login_screen.dart';
import 'modules/docbook_app/on_boarding/on_boarding_screen.dart';
import 'shared/todo_cubit/states.dart';
/*
change password put old password,
hogozat
 */
void main() async {
  //el method de btdmn en el await ytnfz b3den y3ml run
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CasheHelper.init();
  //bool? isDark = CasheHelper.getData(key: 'isDark');
  Widget widget;
  bool? onBoarding = CasheHelper.getData(key: 'onBoarding');
  token = CasheHelper.getData(key: 'token');
  userid = CasheHelper.getData(key: 'userid');
  doctor = CasheHelper.getData(key: 'doctor');
  print('start of main');
  print(token);
  print(userid);
  print(doctor);
  print('end of main');
  if (onBoarding != null) {
    if (token != null) {
      if(doctor==true){
        widget = const DoctorLayout();
      }else{
        widget = const DocBookLayout();
      }
    } else {
      widget = DocLoginScreen();
    }
  } else {
    widget = const OnBoardingDocScreen();
  }
  runApp(MyApp(
    // isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  //final bool? isDark;
  final Widget startWidget;
  const MyApp({
    super.key,
    //this.isDark,
    required this.startWidget,
  });
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..changeAppMode(
                //fromShared: isDark,
                ),
        ),
        BlocProvider(
          create: (context) => DocLoginCubit()
            ..getProfileData(userid.toString())
            ..getDoctorReports(userid.toString())
            ..getAllDoctors()
            ..getUserAppointment(userid.toString())
          ..getDoctorAppointment(userid, DateFormat("yyy-MM-dd").format(DateTime.now()).toString())
          ,
        //    DateFormat("yyy-MM-dd","en").format(DateTime.now()).toString()
          //DateFormat("yyy-MM-dd","en").format(DateTime.tryParse(_focusDay.toString())!)
        ),
        BlocProvider(
            create: (
                BuildContext context) => DocBookCubit()
        ),
        BlocProvider(
          create: (context) =>  RegisterCubit(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            // AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
