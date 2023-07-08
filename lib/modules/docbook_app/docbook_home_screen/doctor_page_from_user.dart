import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:ramdan_proj/models/docbook_app/getdoctormodel.dart';
import 'package:ramdan_proj/modules/docbook_app/docbook_home_screen/make_appoint_screen.dart';
import 'package:ramdan_proj/modules/docbook_app/login/cubit/cubit.dart';
import 'package:ramdan_proj/modules/docbook_app/login/cubit/states.dart';
import 'package:ramdan_proj/shared/components/components.dart';
import 'package:ramdan_proj/shared/styles/colors.dart';

import '../../../shared/components/constants.dart';

class DoctorScreen extends StatefulWidget {
  DoctorScreen(this.id, {Key? key}) : super(key: key);
  String id;

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

var reviewController=TextEditingController();

IconData? _selectedIcon;
class _DoctorScreenState extends State<DoctorScreen> {
  late double _rating;
  final int _ratingBarMode=1;
  final double _initialRating=1.0;
  var formKey=GlobalKey<FormState>();
  var commentController=TextEditingController();
  var complaintsController=TextEditingController();
  final bool _isVertical=false;
  @override
  initState(){
    super.initState();
    DocLoginCubit.get(context).getDoctorData(widget.id);
    _rating = _initialRating;
  }
  @override
  Widget build(BuildContext context) {
    var model = DocLoginCubit.get(context).doctorModel;
    var cubit = DocLoginCubit.get(context);

    return BlocConsumer<DocLoginCubit,DocLoginStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          backgroundColor: defColor,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              size: 25,
                              color: Colors.white,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Add Complaints',
                                            style: TextStyle(
                                              color: Colors.red.shade900,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                DocLoginCubit.get(context).nameController.text,
                                                style: TextStyle(
                                                  color: defColor,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                color: defColor,
                                                size: 12,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                model!.userName??'Dr Hamda',
                                                style: TextStyle(
                                                  color: defColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                            controller: complaintsController,
                                            decoration: InputDecoration(
                                                hintText: 'Complaints details...',
                                                enabledBorder:  OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  borderSide: BorderSide(
                                                    color: defColor,
                                                    width: 1,
                                                  ),
                                                ),
                                                filled: true
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: InkWell(
                                                  onTap:(){
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                      BorderRadius.circular(
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
                                                  onTap:(){
                                                    DocLoginCubit.get(context).addComplaints(
                                                        details: complaintsController.text,
                                                        userId: userid,
                                                      doctorId: widget.id,
                                                    ).then((value) {
                                                      if(state is AddComplaintsSuccessState) {
                                                        DocLoginCubit.get(context).getDoctorData(model.sId!);
                                                      }
                                                      showToast(text: 'Your Complaint is sent', state: ToastStates.SUCCESS);
                                                      Navigator.pop(context);
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          10),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                            spreadRadius: 1,
                                                            blurRadius: 1,
                                                            color: Colors.grey,
                                                        ),
                                                      ],
                                                    ),
                                                    child: Center(
                                                      child:Text(
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
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.red.shade600),
                              width: 120,
                              height: 30,
                              child: const Center(
                                child: Text(
                                  'Add Complaints',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage('${model?.photo??const AssetImage('assets/images/doc2.png')}'),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              model!.userName??'Not Found',
                              style: const TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              model.specialty??'Not found',
                              style: const TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                /*Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                      color: Colors.blueGrey,
                                      shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Ionicons.videocam,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),*/
                                /*const SizedBox(
                                  width: 20,
                                ),*/
                                /*InkWell(
                                  onTap: () {
                                    navigateTo(context, const ChatScreen());
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                        color: Colors.blueGrey,
                                        shape: BoxShape.circle),
                                    child: const Icon(
                                      CupertinoIcons.chat_bubble_text_fill,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  ),
                                ),*/
                              ],
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
                Container(
                  height: MediaQuery.of(context).size.height / 0.95,
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 20, left: 15),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 2,
                                spreadRadius: 1,
                                color: Colors.black12,
                              )
                            ]),
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'About Doctor',
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
                              padding:const  EdgeInsets.all(2.0),
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  '${model.aboutMe??'has not been set yet'} ',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Services',
                                  style: TextStyle(
                                      color: defColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  '${model.price??'100'} \$',
                                  style:const  TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 2,
                                spreadRadius: 1,
                                color: Colors.black12,
                              )
                            ]),
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rate overall',
                              style: TextStyle(
                                color: defColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              width: 180,
                              decoration: BoxDecoration(
                                color: defColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: TextButton(
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
                                                'Doctor Review',
                                                style: TextStyle(
                                                  color: defColor,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              CircleAvatar(
                                                radius: 40,
                                                backgroundImage: NetworkImage('${model.photo??const AssetImage('assets/images/doc2.png')}'),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                model.userName??'not found',
                                                style: TextStyle(
                                                  color: defColor,
                                                ),
                                              ),
                                              /**/
                                              _ratingBar(_ratingBarMode),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              TextFormField(
                                                controller: commentController,
                                                decoration: InputDecoration(
                                                    hintText: 'Additional comments...',
                                                    enabledBorder:  OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(10.0),
                                                      borderSide: BorderSide(
                                                        color: defColor,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    filled: true
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap:(){
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        height: 30,
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                          BorderRadius.circular(
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
                                                      onTap:(){
                                                        DocLoginCubit.get(context).addReview(
                                                            name: 'Testing',
                                                            rating: _rating,
                                                            comment: commentController.text,
                                                            userId: userid,
                                                          id:widget.id,
                                                        ).then((value) {
                                                          DocLoginCubit.get(context).getDoctorData(model.sId!);
                                                          Navigator.pop(context);
                                                        });
                                                      },
                                                      child: Container(
                                                        height: 30,
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                          boxShadow: const [
                                                            BoxShadow(
                                                                spreadRadius: 1,
                                                                blurRadius: 1,
                                                                color: Colors.grey),
                                                          ],
                                                        ),
                                                        child: Center(
                                                          child:Text(
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:const [
                                    Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      ' Add review',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 2,
                                spreadRadius: 1,
                                color: Colors.black12,
                              )
                            ]),
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Patient Reviews',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: defColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  'from ${model.numReviews} visitors',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            if(DocLoginCubit.get(context).doctorModel!.numReviews!=0)
                            Padding(
                              padding:const EdgeInsets.all(2.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '${model.raiting.toStringAsFixed(1)??'0.0'}',
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
                                  Row(
                                    children: [
                                      const Icon(Icons.star,color: Colors.amber,),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Text('1',style: TextStyle(fontSize: 16),),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      LinearPercentIndicator(
                                        lineHeight: 3,
                                        width: MediaQuery.of(context).size.width - 130,
                                        percent: (cubit.ratingCount[1] / cubit.doctorModel?.numReviews ),progressColor: Colors.purple,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      ConditionalBuilder(
                        condition: DocLoginCubit.get(context).doctorModel!.numReviews!=0,
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: 150,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: DocLoginCubit.get(context).doctorModel!.reviews!.length,
                              itemBuilder: (context, index) {
                                return RaitingBuilder(DocLoginCubit.get(context).doctorModel!.reviews![index]);
                              },
                            ),
                          );
                        },
                        fallback: (BuildContext context) {
                          return Center(
                            child: Column(
                              children: const [
                                Image(
                                  image: AssetImage(
                                    'assets/images/items.png'
                                  ),
                                  width: 280,
                                  height: 280,
                                ),
                                Text(
                                  'There is no Reviews yet'
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          );
                        },

                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                        ),
                        child: InkWell(
                          onTap: () {
                            navigateTo(context, BookingPage(model.sId));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                              color: defColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                'Book Appointment',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
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
        );
      },
    );
  }
  Widget _ratingBar(int mode) {
    switch (mode) {
      case 1:
        return RatingBar.builder(
          initialRating: _initialRating,
          minRating: 1,
          direction: _isVertical ? Axis.vertical : Axis.horizontal,
          allowHalfRating: true,
          unratedColor: defColor,
          itemCount: 5,
          itemSize: 30.0,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            _selectedIcon ?? Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            setState(() {
              _rating = rating;
            });
          },
          updateOnDrag: true,
        );
      case 2:
        return RatingBar(
          initialRating: _initialRating,
          direction: _isVertical ? Axis.vertical : Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          ratingWidget: RatingWidget(
            full: const Icon(
              Icons.star,
              color: defaultColor,
            ),
            half: const Icon(
              Icons.star_half,
              color: defaultColor,
            ),
            empty: const Icon(
              Icons.star_border,
              color: defaultColor,
            ),
          ),
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          onRatingUpdate: (rating) {
            setState(() {
              _rating = rating;
            });
          },
          updateOnDrag: true,
        );
      case 3:
        return RatingBar.builder(
          initialRating: _initialRating,
          direction: _isVertical ? Axis.vertical : Axis.horizontal,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return const Icon(
                  Icons.sentiment_very_dissatisfied,
                  color: Colors.red,
                );
              case 1:
                return const Icon(
                  Icons.sentiment_dissatisfied,
                  color: Colors.redAccent,
                );
              case 2:
                return const Icon(
                  Icons.sentiment_neutral,
                  color: Colors.amber,
                );
              case 3:
                return const Icon(
                  Icons.sentiment_satisfied,
                  color: Colors.lightGreen,
                );
              case 4:
                return const Icon(
                  Icons.sentiment_very_satisfied,
                  color: Colors.green,
                );
              default:
                return Container();
            }
          },
          onRatingUpdate: (rating) {
            setState(() {
              _rating = rating;
            });
          },
          updateOnDrag: true,
        );
      default:
        return Container();
    }
  }
  Widget RaitingBuilder(Reviews model)=>Container(
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
            title:  const Text(
              'Reviewer',
              style: TextStyle(
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
                  '${model.rating}',
                  style:
                  const TextStyle(color: Colors.black54),
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
              style:const TextStyle(
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



