import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:ramdan_proj/models/docbook_app/getdoctormodel.dart';
import 'package:ramdan_proj/modules/docbook_app/docbook_profile_screen/doctor_password_screen.dart';
import 'package:ramdan_proj/modules/docbook_app/docbook_profile_screen/update_doctor_screen.dart';
import 'package:ramdan_proj/modules/docbook_app/login/cubit/cubit.dart';
import 'package:ramdan_proj/modules/docbook_app/login/cubit/states.dart';
import 'package:ramdan_proj/shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/styles/colors.dart';

class DoctorProfile extends StatelessWidget {
  const DoctorProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = DocLoginCubit.get(context);
    final model = DocLoginCubit.get(context).doctorModel;
    cubit.doctorNameController.text=model?.userName??'Not found';
    cubit.specialtyController.text=model?.specialty??'not Found';
    cubit.aboutDoctorController.text=model?.aboutMe??'Not Found';
    cubit.doctorPriceController.text=model?.price.toString()??'not Found';
    /*Map<int,int> ratingCounts= {
      5: 0,
      4: 0,
      3: 0,
      2: 0,
      1: 0
    };*/
    //dynamic rating=0;
    /*model?.reviews!.forEach((review) =>{
      rating=review.rating,
      ratingCounts[rating]=ratingCounts[rating]++!,
    });*/
    return BlocConsumer<DocLoginCubit,DocLoginStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 1.75,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: defColor,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top:16.0),
                          child: Row(
                            children:  [
                              CircleAvatar(
                                radius: 35,
                            backgroundImage: NetworkImage(
                                '${model?.photo ?? const AssetImage('assets/images/doc2.png')}'),
                          ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [
                                  Text(
                                    cubit.doctorNameController.text,
                                    style: const TextStyle(
                                        color: Colors.white
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: 220,
                                    child: Text(
                                      cubit.specialtyController.text,
                                      style:const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              PopupMenuButton(
                                child:const Icon(
                                  Icons.more_vert_rounded,
                                  color: Colors.white,
                                ),
                                onSelected: (value) {
                                  if(value == 0){
                                    navigateTo(context, const EditDocScreen());
                                  }else if(value == 1){
                                    navigateTo(context,const DocPasswordScreen());
                                  }else if(value==2){
                                    signOut(context);
                                  }
                                },
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    value: 0,
                                    child: Text('Edit Profile'),

                                  ),
                                  const PopupMenuItem(
                                    value: 1,
                                    child: Text('Change Password'),
                                  ),
                                  const PopupMenuItem(
                                    value: 2,
                                    child: Text('Log out'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'About me : ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                children:  [
                                  Text(
                                    '${cubit.aboutDoctorController.text} Graduate from FCI',
                                    style:const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Location : ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    '${model?.city??'Cairo'}',
                                    style:const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Rating : ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    '${model?.numReviews}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Prise :',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    '${cubit.doctorPriceController.text} \$',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap:(){
                                  navigateTo(context, const EditDocScreen());
                                },
                                child: Container(
                                  width: 180,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Edit Profile',
                                      style: TextStyle(
                                        color: defColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Container(
                                width: 180,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    'Edit Appointment',
                                    style: TextStyle(
                                      color: defColor,
                                      fontSize: 16,
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
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow:const [
                          BoxShadow(
                            blurRadius: 2,
                            spreadRadius: 1,
                            color: Colors.black12,
                          )
                        ]
                    ),
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Patient Reviews',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: defColor,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding:const EdgeInsets.all(2.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${model?.raiting.toStringAsFixed(1)}',
                                    style:const  TextStyle(
                                        fontSize: 18
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 20,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'from ${model?.numReviews} visitors',
                                style:const TextStyle(
                                    color: Colors.grey
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.star,color: Colors.amber,),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text('5',style: TextStyle(fontSize: 16),),
                                  const SizedBox(
                                    width: 10,
                                  ),

                                   LinearPercentIndicator(
                                     lineHeight: 3,
                                     width: MediaQuery.of(context).size.width - 130,
                                     percent: (cubit.ratingCount[5] / cubit.doctorModel?.numReviews ),progressColor: Colors.blue,
                                   ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.star,color: Colors.amber,),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text('4',style: TextStyle(fontSize: 16),),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  LinearPercentIndicator(
                                    lineHeight: 3,

                                    width: MediaQuery.of(context).size.width - 130,
                                    percent: (cubit.ratingCount[4] / cubit.doctorModel?.numReviews ),
                                    progressColor: Colors.green,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.star,color: Colors.amber,),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text('3',style: TextStyle(fontSize: 16),),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  LinearPercentIndicator(
                                    lineHeight: 3,
                                    width: MediaQuery.of(context).size.width - 130,
                                    percent: (cubit.ratingCount[3] / cubit.doctorModel?.numReviews ),progressColor: Colors.yellow,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.star,color: Colors.amber,),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text('2',style: TextStyle(fontSize: 16),),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  LinearPercentIndicator(
                                    lineHeight: 3,
                                    width: MediaQuery.of(context).size.width - 130,
                                    percent: (cubit.ratingCount[2] / cubit.doctorModel?.numReviews ),progressColor: Colors.red,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: DocLoginCubit.get(context).doctorModel!.reviews!.length,
                      itemBuilder: (context, index) {
                        return RaitingBuilder(context,DocLoginCubit.get(context).doctorModel!.reviews![index]);
                      }
                      ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 80),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget RaitingBuilder(context,Reviews model)=>Container(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.symmetric(vertical: 5),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 2,
          )
        ]),
    child: SizedBox(
      width: MediaQuery.of(context).size.width / 1.5,
      child: Column(
        children: [
          ListTile(
            leading: const CircleAvatar(
              radius: 25,
              backgroundImage:
              AssetImage('assets/images/man.png'),
            ),
            title:Text(
              'Reviewer ${model.sId!.substring(22).toString()}',
              style:const TextStyle(
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text('${model.time}'),
            trailing: Row(
              mainAxisAlignment:
              MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                Text(
                  '${model.rating!.toStringAsFixed(1)}',
                  style: const TextStyle(
                      color: Colors.black54
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '${model.comment??'not found'}',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ),
  );
}
