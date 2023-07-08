// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ramdan_proj/modules/docbook_app/login/login_screen.dart';
import 'package:ramdan_proj/shared/components/components.dart';
import 'package:ramdan_proj/shared/network/local/cashe_helper.dart';
import 'package:ramdan_proj/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingDocModel {
  final String image;
  final String title;
  final String body;

  BoardingDocModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingDocScreen extends StatefulWidget {
  const OnBoardingDocScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingDocScreen> createState() => _OnBoardingDocScreenState();
}

class _OnBoardingDocScreenState extends State<OnBoardingDocScreen> {
  var boardController = PageController();

  List<BoardingDocModel> boarding = [
    BoardingDocModel(
      image: 'assets/images/doc1.png',
      title: 'Choose The Doctor',
      body: 'Highly Qualified Specialists in different fields of medicine, ready to help you at any time',
    ),
    BoardingDocModel(
      image: 'assets/images/second.png',
      title: 'BOOK APPOINTMENT',
      body: 'After you choose the doctor that suits you, \nyou can book your appointment online',
    ),
    BoardingDocModel(
      image: 'assets/images/call.png',
      title: 'MAKE VIDEO CALL',
      body: 'Get Ready. Your Own Doctor will start Video call you at booked Time Slot.',
    ),
  ];
  bool isLast = false;
  void submit() {
    CasheHelper.saveData(
        key: 'onBoarding',
        value: true,
    ).then((value) {
      if (value) {
        navigateAndFinish(
          context,
          DocLoginScreen(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: submit,
            child: Text('Skip',style: TextStyle(color: defColor),),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    isLast = false;
                  }
                },
                controller: boardController,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildBoardingDocItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            SmoothPageIndicator(
              effect: const ExpandingDotsEffect(
                dotColor: Colors.grey,
                dotHeight: 10.0,
                expansionFactor: 3,
                dotWidth: 10.0,
                spacing: 5.0,
                activeDotColor: defaultColor,
              ),
              controller: boardController,
              count: boarding.length,
            ),
            const SizedBox(
              height: 60,
            ),
            defaultButton(
              function: () {
                if (isLast) {
                  submit();
                } else {
                  boardController.nextPage(
                      duration: const Duration(
                        milliseconds: 800,
                      ),
                      curve: Curves.linear);
                }
              },
              text: 'Next',
              background: defColor
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingDocItem(BoardingDocModel model) => Column(
        children: [
          Expanded(
            child: Image(
              image: AssetImage(model.image),
            ),
          ),
          Text(
            model.title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            model.body,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
        ],
      );
}
