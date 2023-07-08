import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:ramdan_proj/layout/docbook_app/cubit/cubit.dart';
import 'package:ramdan_proj/layout/docbook_app/cubit/states.dart';
import 'package:ramdan_proj/modules/docbook_app/docbook_home_screen/payment_screen.dart';
import 'package:ramdan_proj/modules/docbook_app/login/cubit/states.dart';
import 'package:ramdan_proj/shared/components/constants.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';
import '../login/cubit/cubit.dart';

class BookingPage extends StatefulWidget {
   BookingPage(this.sId, {Key? key}) : super(key: key);
   String? sId;
  @override
  State<BookingPage> createState() => _BookingPageState();
}
class _BookingPageState extends State<BookingPage> {
  CalendarFormat _format=CalendarFormat.month;
  DateTime _focusDay=DateTime.now();
  DateTime _currentDay=DateTime.now();
  String? chosenTime;
  int? _currentIndex;
  bool _isWeekend=false;
  bool _dateSelected=false;
  bool _timeSelected=false;

  List<String> timeList = ["12:00","01:00","02:00","03:00","04:00","05:00","06:00","07:00"];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DocLoginCubit,DocLoginStates>(
      listener: (context,state){},
      builder: (context,state){
        var model = DocLoginCubit.get(context).doctorModel;
        return BlocConsumer<DocBookCubit,DocBookStates>(
          listener: (context,state){},
          builder: (context,state){
            return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(
                    'Appointment',style: TextStyle(
                    color: defColor,
                  ),
                  ),
                  leading: IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: defColor,
                    ),
                  ),
                ),
                body: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: defColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: _tableCalendar(),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                          ),
                          Text(
                            ' Choose times',
                            style: TextStyle(
                              color: defColor,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _isWeekend ? const SliverToBoxAdapter() : SliverGrid(
                      delegate: SliverChildBuilderDelegate((context, index){
                        return   InkWell(
                          splashColor: Colors.transparent,
                          onTap: (){
                            setState(() {
                              _currentIndex=index;
                              _timeSelected=true;
                              chosenTime=(_currentIndex!+9).toString();
                            });
                          },
                          child:Container(
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: _currentIndex == index? Colors.white:Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(15),
                              color: _currentIndex==index?defColor:null,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              timeList[index],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _currentIndex==index?Colors.white:null,
                              ),
                            ),
                          ) ,
                        );
                      },
                        childCount: timeList.length,
                      ),
                      gridDelegate: const  SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 1.5,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical:20,
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary:defColor,
                          ),
                          onPressed: _timeSelected && _dateSelected? (){
                            initializeDateFormatting();
                            DocBookCubit.get(context).iCreateReservation(
                              time: DateFormat("yyy-MM-dd","en").format(DateTime.tryParse(_focusDay.toString())!),
                              start: chosenTime!.toString(),
                              idPatient: userid.toString(),
                              idDoctor: widget.sId!.toString(),
                              cardNumber:45678932145631,
                              expiration: '07/7',
                              securityCode: '127',
                              type: 'online',
                            ).then((value) {
                              DocLoginCubit.get(context).getUserAppointment(userid);
                              //navigateTo(context,const ConfirmBooking());
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Image(
                                            image: AssetImage(
                                                'assets/images/confirm.png'
                                            ),
                                          ),
                                          Text(
                                            'Confirmation',
                                            style: TextStyle(
                                                color: defColor,
                                                fontSize: 20
                                            ),
                                          ),
                                          Text(
                                            'Your appointment with ${model?.userName} is confirmed',
                                            style: const TextStyle(
                                                color: Colors.grey
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Column(
                                              children: [
                                                Container(
                                                  padding:const EdgeInsets.all(16),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(),
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      const Text(
                                                        'Date',
                                                      ),
                                                      const Spacer(),
                                                      Text(
                                                        '${DateFormat("yyy-MM-dd","en").format(DateTime.tryParse(_focusDay.toString())!)}',
                                                        style: TextStyle(
                                                            color: defColor
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  padding:const EdgeInsets.all(16),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(),
                                                      borderRadius: BorderRadius.circular(10)
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      const Text(
                                                        'Time',
                                                      ),
                                                      const Spacer(),
                                                      Text(
                                                        '$chosenTime',
                                                        style: TextStyle(
                                                            color: defColor
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  padding:const EdgeInsets.all(16),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(),
                                                      borderRadius: BorderRadius.circular(10)
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      const Text(
                                                        'Service',
                                                      ),
                                                      const Spacer(),
                                                      Text(
                                                        '${model?.price??'200'}\$',
                                                        style: TextStyle(
                                                            color: defColor
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: InkWell(
                                                    onTap:(){
                                                      showToast(text: 'your appointment is done', state: ToastStates.SUCCESS);
                                                      navigateTo(context, const PaymentScreen());
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            blurRadius: 1,
                                                            spreadRadius: 1,
                                                          )
                                                        ],
                                                        color: defColor,
                                                        borderRadius: BorderRadius.circular(10),
                                                      ),
                                                      child: const Center(
                                                        child: Text(
                                                          'Payment',
                                                          style: TextStyle(
                                                              color: Colors.white
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            });
                          } : null ,
                          child: const Text('Make Appointment'),
                        ),
                      ),
                    )
                  ],

                )
            );
          },
        );
      },
    );
  }

  Widget _tableCalendar(){
    return TableCalendar(
      focusedDay: _focusDay,
      firstDay: DateTime.now(),
      lastDay: DateTime(2023,12,31),
      calendarFormat: _format,
      currentDay: _currentDay,
      rowHeight: 46,
      availableCalendarFormats: const{
        CalendarFormat.month:'Month',
      },
      calendarStyle: const CalendarStyle(
        defaultTextStyle: TextStyle(
          color: Colors.white,
        ),
        todayDecoration: BoxDecoration(
          color: Colors.blueGrey,
          shape: BoxShape.circle,
        ),
      ),
      headerStyle: const HeaderStyle(
        leftChevronIcon: Icon(
          Icons.arrow_left,color: Colors.white,
        ),
        rightChevronIcon: Icon(
          Icons.arrow_right,color: Colors.white,
        ),
        titleCentered: true,
        titleTextStyle: TextStyle(
            color: Colors.white
        ),
      ),
      daysOfWeekStyle:const DaysOfWeekStyle(
        weekdayStyle: TextStyle(
            color: Colors.white
        ),
      ),
      onFormatChanged: (format){
        setState(() {
          _format=format;
        });
      },
      onDaySelected:((selectedDay,focusedDay){
        setState(() {
          _currentDay=selectedDay;
          _focusDay=focusedDay;
          _dateSelected=true;
          if(selectedDay.weekday==5||selectedDay.weekday==6){
            _isWeekend=true;
            _timeSelected=false;
            _currentIndex=null;
          }else{
            _isWeekend=false;
          }
        });
      }),
    );
  }
}


