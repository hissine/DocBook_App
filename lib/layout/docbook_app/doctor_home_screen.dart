import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ramdan_proj/modules/docbook_app/login/cubit/cubit.dart';
import 'package:ramdan_proj/modules/docbook_app/login/cubit/states.dart';
import 'package:ramdan_proj/shared/components/constants.dart';
import 'package:ramdan_proj/shared/styles/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/docbook_app/doctor_appointment.dart';


class DoctorHomeScreen extends StatelessWidget {
  DoctorHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DocLoginCubit,DocLoginStates>(
      listener: (context,state){},
      builder: (context,state){
        var model = DocLoginCubit.get(context).doctorReports;
        var list=DocLoginCubit.get(context).docAppointment;
        print('from home page');
        print(userid);
        //DocLoginCubit.get(context).getDoctorReports(userid);
        return Scaffold(
          appBar: AppBar(
            title: Text('Dashboard',style: TextStyle(
                color: defColor
            ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child:SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Weekly reports',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          height: 140,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children:  [
                              IconButton(
                                onPressed: (){},
                                icon: Icon(Icons.person,color: defColor),
                              ),
                              const Text('Total patient'),
                              Container(
                                width: 60,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    '${model?.totals!.totalOrders??'1'}',
                                    style: TextStyle(
                                      color: defColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 100,
                          height: 140,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children:  [
                              IconButton(
                                onPressed: (){},
                                icon: Icon(Icons.monetization_on,color: defColor,),
                              ),
                              const Text('Total payment'),
                              Container(
                                width: 60,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    '${model?.totals!.totalPaid??'150'}\$',
                                    style: TextStyle(
                                      color: defColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 100,
                          height: 140,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children:  [
                              IconButton(
                                onPressed: (){},
                                icon: Icon(Ionicons.videocam,color:defColor,),
                              ),
                              const Text('Video calls'),
                              Container(
                                width: 60,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    '${model?.totals!.totalOrders??'1'}',
                                    style: TextStyle(
                                      color: defColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 100,
                          height: 140,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children:  [
                              IconButton(
                                onPressed: (){},
                                icon: Icon(Icons.favorite,color: defColor,),
                              ),
                              const Text('Ratings'),
                              Container(
                                width: 60,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    '${model?.totals!.profit??'1'}',
                                    style: TextStyle(
                                      color: defColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:const [
                      Text(
                        'Today\'s Apponintment',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'View all',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ConditionalBuilder(
                    condition: list.isNotEmpty,
                    builder: (BuildContext context) {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index)=>DoctorSchedule(context,list[index]),
                        separatorBuilder: (context,index)=>const SizedBox(
                          height: 20,
                        ),
                        itemCount:list.length,
                      );
                    },
                    fallback: (BuildContext context) {
                      return const Center(
                        child: Text(
                          'There is no appointments today'
                        ),
                      );
                    },
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
_launchURL() async {
  const url = 'https://genius0x1.github.io/camera/DocBookVideoAndChat.html';
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}

Widget DoctorSchedule(context,DoctorAppointments model){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                spreadRadius: 2,
              ),
            ],
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    "${model.patient?.userName??'User'}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text("${model.patient!.birthDate??"20"}"),
                  trailing: const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/images/man.png'),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Divider(
                    thickness: 1,
                    height: 20,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month,
                              color: Colors.black54,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${model.time??'2023-07-11'}',
                              style:const TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Row(
                          children:  [
                           const  Icon(
                              Icons.access_time_filled,
                              color: Colors.black54,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "${model.start??'12:30 PM'}",
                              style: const TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${model.reservationPlace??'video call'}',
                              style: const TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    /*InkWell(
                      onTap: () {},
                      child: Container(
                        width: 150,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            )),
                      ),
                    ),*/
                    InkWell(
                      onTap: () {
                        print('url clicked');
                        _launchURL();
                      },
                      child: Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                                color: defColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Center(
                              child: Text(
                                'Start Session',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
