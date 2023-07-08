import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramdan_proj/layout/docbook_app/cubit/cubit.dart';
import 'package:ramdan_proj/layout/docbook_app/cubit/states.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ramdan_proj/shared/styles/colors.dart';

class DocBookLayout extends StatelessWidget {
  const DocBookLayout({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DocBookCubit,DocBookStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = DocBookCubit.get(context);
        final items=<Widget>[
          const Icon(Ionicons.home_outline,size: 30,),
          const Image(image: AssetImage('assets/images/scan.png',),height: 30,width: 30,color: Colors.white,),
          const Icon(Ionicons.calendar_outline,size: 30,),
          const Icon(Ionicons.person_outline,size: 30,),
        ];

        return Scaffold(
          extendBody: true,
          body: cubit.bottomScreens[cubit.curIndex],
          bottomNavigationBar:Theme(
            data: Theme.of(context).copyWith(
              iconTheme:const IconThemeData(color:Colors.white),
            ),
            child: CurvedNavigationBar(
              index: cubit.curIndex,
              height: 60,
              backgroundColor: Colors.transparent,
              items: items,
              color:defColor,
              onTap: (index){
                cubit.changeBottom(index);
              },
            ),
          ),
        );
      },
    );
  }
}

/* currentIndex: cubit.currentIndex,
            onTap:(index){
              cubit.changeBottom(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon:Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon:Icon(Icons.chat_bubble_outline),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon:Icon(Icons.calendar_today_sharp),
                label: 'Calendar',
              ),
              BottomNavigationBarItem(
                icon:Icon(Icons.person_outline),
                label: 'Home',
              ),
              
 */
