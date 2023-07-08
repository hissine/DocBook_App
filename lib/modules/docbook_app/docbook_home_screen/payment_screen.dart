import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ramdan_proj/layout/docbook_app/docbook_layout.dart';
import 'package:ramdan_proj/shared/components/components.dart';
import 'package:ramdan_proj/shared/styles/colors.dart';
class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen>
    with TickerProviderStateMixin {
  var cardNumberController = TextEditingController();
  var expiryDateController = TextEditingController();
  var cardHolderNameController = TextEditingController();
  var cvvCodeController = TextEditingController();
  var cvvFocus = FocusNode();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String cardNumber = '';
  String cardHolderName = 'Holder Name';
  String? expiryDate;
  String? cVV;

  String formatedCardNumber = '**** **** **** ****';
  String formatedExpiryDate = 'MM/YY';
  String formatedCVV = '****';

  var value = 0;

  _PaymentScreenState() {
    cardNumberController = TextEditingController();
    cardNumberController.addListener(() {
      setState(() {
        cardNumber = cardNumberController.text;
      });
    });

    cardHolderNameController = TextEditingController();
    cardHolderNameController.addListener(() {
      setState(() {
        cardHolderName = cardHolderNameController.text;
      });
    });

    expiryDateController = TextEditingController();
    expiryDateController.addListener(() {
      setState(() {
        expiryDate = expiryDateController.text;
      });
    });

    cvvCodeController = TextEditingController();
    cvvCodeController.addListener(() {
      setState(() {
        cVV = cvvCodeController.text;
      });
    });
    cvvFocus.addListener(() {
      cvvFocus.hasFocus
          ? animationController!.forward()
          : animationController!.reverse();
      setState(() {});
    });
  }

  AnimationController? animationController;
  Animation<double>? flipAnimation;
  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    animationController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350));
    flipAnimation =
    Tween<double>(begin: 0, end: 1).animate(animationController!)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Payment',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18, top: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    'Card information',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ],
              ),
            ),
            creditCard(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: cardNumberController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            contentPadding:EdgeInsets.all(5.0) ,
                            fillColor: Colors.white,
                            hintText: 'CardNumber',
                          ),
                          maxLength: 16,
                          onChanged: (value){
                            formatedCardNumber=cardNumber.padRight(16,'*');
                            formatedCardNumber=
                                formatedCardNumber.replaceAllMapped(
                                    RegExp(r".{4}"),
                                        (match) => "${match.group(0)}");
                                return null;
                          },
                          validator: (String? value){
                            if(value!.isEmpty){
                              return 'please enter card number';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: cardHolderNameController,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            contentPadding:EdgeInsets.all(5.0) ,
                            fillColor: Colors.white,
                            hintText: 'Name On Card',
                          ),
                          maxLength: 20,
                          validator: (String? value){
                            if(value!.isEmpty){
                              return 'please enter name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(children: [
                          Expanded(
                            flex: 2,
                            child:
                            TextFormField(
                              controller: expiryDateController,
                              keyboardType: TextInputType.datetime,
                              decoration: const InputDecoration(
                                contentPadding:EdgeInsets.all(5.0) ,
                                fillColor: Colors.white,
                                hintText: 'ExpiryDate',
                              ),
                              maxLength: 4,
                              validator: (String? value){
                                if(value!.isEmpty){
                                  return 'please enter expiry date';
                                }
                                return null;
                              },
                              onChanged: (value){
                                formatedExpiryDate=
                                    expiryDate!.padRight(2,'YYY');
                                formatedExpiryDate=
                                    formatedExpiryDate.replaceFirstMapped(
                                      RegExp(r".{2}"),
                                        (match)=>"${match.group(0)}/");
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              controller: cvvCodeController,
                              keyboardType: TextInputType.number,
                              maxLength: 4,
                              focusNode: cvvFocus,
                              decoration: const InputDecoration(
                                contentPadding:EdgeInsets.all(5.0) ,
                                fillColor: Colors.white,
                                hintText: 'CVV',
                              ),
                              onChanged: (value){
                                formatedCVV=cVV!.padRight(4,'*');
                              },
                              validator: (String? value){
                                if(value!.isEmpty){
                                  return 'please Enter CVV';
                                }
                                return null;
                              },
                            ),
                          )
                        ]),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultButton(
                          background: defColor,
                            function: () {
                              if (formKey.currentState!.validate()) {
                                navigateTo(context, const DocBookLayout());
                              }
                            },
                            text: 'Save',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget creditCard() {
    return Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY((flipAnimation!.value < 0.5)
              ? pi * flipAnimation!.value
              : (pi * (1 + flipAnimation!.value))),
        origin: Offset(MediaQuery.of(context).size.width / 2, 0),
        child: flipAnimation!.value < 0.5 ? front() : back());
  }

  Widget front() {
    return SizedBox(
      width: 500,
      height: 260,
      child: Card(
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 8,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: const DecorationImage(
                  image: AssetImage('assets/images/card_bg.png'), fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                        alignment: Alignment.topRight,
                        child: Image.asset('assets/images/mastercard.png')),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(formatedCardNumber,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.robotoMono(
                              fontSize: 24,
                              color: Colors.white,
                              letterSpacing: 2,
                              shadows: const [
                                Shadow(
                                    color: Colors.black12, offset: Offset(2, 1))
                              ],
                              fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Card Holder',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Text(cardHolderName,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Expiry',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Text(formatedExpiryDate,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))
                          ],
                        )
                      ],
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Image(
                      image: AssetImage('assets/images/chip.png'),
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget back() {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(pi * value),
      origin: Offset(MediaQuery.of(context).size.width / 2, 0),
      child: SizedBox(
        width: 500,
        height: 260,
        child: Card(
            margin: const EdgeInsets.all(16),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 8,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: const DecorationImage(
                      image: AssetImage('assets/images/card_bg.png'),
                      fit: BoxFit.cover),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  Container(
                    height: 60,
                    color: Colors.black87,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 30,
                              width: 200,
                              alignment: Alignment.centerLeft,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Text(
                              formatedCVV,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 12,
                          color: Colors.black45,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 12,
                          width: 150,
                          color: Colors.black45,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 12,
                          width: 150,
                          color: Colors.black45,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}