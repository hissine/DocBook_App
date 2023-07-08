import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramdan_proj/models/docbook_app/userreservation.dart';
import 'package:ramdan_proj/modules/docbook_app/login/cubit/cubit.dart';
import 'package:ramdan_proj/modules/docbook_app/login/cubit/states.dart';
import 'package:ramdan_proj/shared/components/constants.dart';
import 'package:ramdan_proj/shared/styles/colors.dart';
import 'package:url_launcher/url_launcher.dart';
class DocBookCalendarScreen extends StatelessWidget {
 DocBookCalendarScreen({Key? key}) : super(key: key);
 @override
  Widget build(BuildContext context) {
    return BlocConsumer<DocLoginCubit,DocLoginStates>(
      listener: (context,state){
        if(state is DeleteAppointmentSuccessState) {
          DocLoginCubit.get(context).getUserAppointment(userid);
        }
      },
      builder: (context,state){
        var list = DocLoginCubit.get(context).appointments;
        /*
        String? date1;
        date1=DocLoginCubit.get(context).userAppointment!.time;
        DateTime.tryParse(date1!);
        */
        return Scaffold(
          body: state is UserAppointmentLoadingState ? const Center(
            child: CircularProgressIndicator(),
          ): Padding(
            padding: const EdgeInsets.only(top:40,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:const EdgeInsets.symmetric(horizontal: 15),
                  child:Center(
                    child: Text(
                      "My Appointment",
                      style: TextStyle(
                        fontSize: 28,
                        color: defColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ConditionalBuilder(
                    condition: list.isNotEmpty,
                    builder: (context)=>Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context,index)=>upComingSchedule(context,list[index]),
                        separatorBuilder: (context,index)=>const SizedBox(
                          height: 20,
                        ),
                        itemCount: DocLoginCubit.get(context).appointments.length,
                      ),
                    ),
                    fallback: (context)=>Column(
                      children:const [
                        Image(
                          image: AssetImage(
                            'assets/images/items.png'
                          ),
                        ),
                        Text(
                          'Waiting For Your Appointments.',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20
                          ),
                        ),
                      ],
                    ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget upComingSchedule(context,UserAppointment model)=>Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
                10
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                spreadRadius: 2,
              ),
            ],
          ),
          child: SizedBox(
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    model.doctor?.userName??'not found',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                      model.doctor?.sT??'not found'
                  ),
                  trailing: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                      '${model.doctor?.photo??const AssetImage('assets/images/doc2.png')}',
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Divider(
                    thickness: 2,
                    height: 20,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                              model.time??'not found',
                              style: const TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time_filled,
                              color: Colors.black54,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              model.start??'not found',
                              style: const TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.videocam,
                              color: Colors.green,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              model.isPaid==true?'Video Call':'Chat',
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
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          DocLoginCubit.get(context).deleteUserAppointment(model.sId);
                        },
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
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: InkWell(
                          onTap:DateTime.tryParse(model.time.toString()!) == DateTime.now() ? () async{
                            /*
                            PermissionStatus cameraStatus=await Permission.camera.request();
                            if(cameraStatus==PermissionStatus.denied){
                              openAppSettings();
                            }
                            Map<Permission,PermissionStatus>status=await [
                              Permission.camera,
                              Permission.microphone,
                            ].request();
                            if(await Permission.camera.isGranted){
                              print('camera is granted');
                            }*/
                            //debugPrint(status.toString());
                            _launchURL();
                          }:(){},
                          child: Container(
                            width: 150,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                                color: DateTime.tryParse(model.time.toString()!) == DateTime.now() ? defColor : Colors.grey,
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
 _launchURL() async {
   const url = 'https://genius0x1.github.io/camera/DocBookVideoAndChat.html';
   if (await canLaunchUrl(Uri.parse(url))) {
     await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication);
   } else {
     throw 'Could not launch $url';
   }
 }
}

