import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramdan_proj/modules/docbook_app/docbook_home_screen/scan_screen.dart';
import 'package:ramdan_proj/modules/docbook_app/docbook_search_screen/search_screen.dart';
import 'package:ramdan_proj/modules/docbook_app/login/cubit/cubit.dart';
import 'package:ramdan_proj/modules/docbook_app/login/cubit/states.dart';
import 'package:ramdan_proj/shared/components/components.dart';
import 'package:ramdan_proj/shared/styles/colors.dart';
import '../../../models/docbook_app/doctorsonhome.dart';
import 'doctor_page_from_user.dart';

class DocBookHomeScreen extends StatelessWidget {
  DocBookHomeScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();
  /*List symptoms = [
    'Heart',
    'Respiratory',
    'Bones',
    'Brain',
    'Scan Centers',
    'Pediatrics',
  ];*/
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DocLoginCubit, DocLoginStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 350,
                    child: Stack(
                      children: [
                        Image(
                          image: const AssetImage('assets/images/home.png'),
                          color: Colors.grey.withOpacity(0.9),
                          colorBlendMode: BlendMode.modulate,
                          height: 260,
                          width: double.infinity,
                          fit: BoxFit.cover
                        ),
                        Container(
                          height: 200,
                          padding: const EdgeInsets.only(
                              top: 20,
                              left: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Find ',
                                    style: TextStyle(
                                      color: Colors.lightBlue.shade900,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    'your desired',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              const Text(
                                'doctors',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 90,
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                            ),
                            width: double.infinity,
                            child: defaultFormField(
                              controller: searchController,
                              onTap: () {
                                navigateTo(context, SearchScreen());
                              },
                              type: TextInputType.text,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'search is not working';
                                }
                                return null;
                              },
                              hint: 'Search',
                              prefix: Icons.search,
                            ),
                          ),
                        ),
                        Positioned(
                            top: 140,
                            right:(MediaQuery.of(context).size.width -303)/2 ,
                            left: (MediaQuery.of(context).size.width -303)/2,
                            child: Center(
                              child: Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      14,
                                  ),
                                ),
                                elevation: 8,
                                child: Container(
                                  color: Colors.white,
                                  padding: const EdgeInsets.all(
                                    18,
                                  ),
                                  width: 310,
                                  height: 190,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              child: Column(
                                                children: [
                                                  const Image(
                                                    image: AssetImage(
                                                      'assets/images/heart.png',
                                                    ),
                                                  ),
                                                  FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: Text(
                                                      'Heart',
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        color: Colors
                                                            .lightBlue.shade900,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              onTap: () {
                                                navigateTo(
                                                    context, SearchScreen());
                                              },
                                            ),
                                          ),
                                          const Spacer(),
                                          InkWell(
                                            child: Column(
                                              children: [
                                                const Image(
                                                    image: AssetImage(
                                                        'assets/images/lung.png'
                                                    ),
                                                ),
                                                FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Text(
                                                    'Respiratory',
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      color: Colors
                                                          .lightBlue.shade900,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            onTap: () {
                                              navigateTo(context, SearchScreen());
                                            },
                                          ),
                                          const Spacer(),
                                          Expanded(
                                            child: InkWell(
                                              child: Column(
                                                children: [
                                                  const Image(
                                                    image: AssetImage(
                                                      'assets/images/bones.png',
                                                    ),
                                                  ),
                                                  FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: Text(
                                                      'Bones',
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        color: Colors
                                                            .lightBlue.shade900,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              onTap: () {
                                                navigateTo(
                                                    context, SearchScreen());
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              child: Column(
                                                children: [
                                                  const Image(
                                                    image: AssetImage(
                                                      'assets/images/brain.png',
                                                    ),
                                                  ),
                                                  FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: Text(
                                                      'Brain',
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          color: Colors.lightBlue
                                                              .shade900),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              onTap: () {
                                                navigateTo(
                                                    context, SearchScreen());
                                              },
                                            ),
                                          ),
                                          const Spacer(),
                                          Expanded(
                                            child: InkWell(
                                              child: Column(
                                                children: [
                                                  const Image(
                                                    image: AssetImage(
                                                        'assets/images/scan.png'),
                                                  ),
                                                  FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: Text(
                                                      'Scan',
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          color: Colors.lightBlue.shade900,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              onTap: () {
                                                navigateTo(
                                                    context, const ScanScreen());
                                              },
                                            ),
                                          ),
                                          const Spacer(),
                                          Expanded(
                                            child: InkWell(
                                              child: Column(
                                                children: [
                                                  const Image(
                                                      image: AssetImage(
                                                          'assets/images/babies.png',
                                                      ),
                                                  ),
                                                  FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: Text(
                                                      'Pediatrics',
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          color: Colors.lightBlue
                                                              .shade900),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              onTap: () {
                                                navigateTo(
                                                    context, SearchScreen());
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      'Top Doctors',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: defColor,
                      ),
                    ),
                  ),
                  (state is AllDoctorsLoadingState ||
                          DocLoginCubit.get(context).allDoctors == null)
                      ? const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: LinearProgressIndicator(),
                        )
                      : ConditionalBuilder(
                    condition: DocLoginCubit.get(context)
                        .allDoctors
                        ?.data!
                        .length!=null,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 250,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => cardBuilder(
                              context,
                              DocLoginCubit.get(context)
                                  .allDoctors!
                                  .data![index]),
                          itemCount: DocLoginCubit.get(context)
                              .allDoctors
                              ?.data!
                              .length,
                        ),
                      );
                    },
                    fallback: (BuildContext context) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:const  [
                          Image(
                            image: AssetImage(
                              'assets/images/items.png'
                            ),
                          ),
                          Text(
                            'There is no doctors yet!',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      );
                    },
                      ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only( left: 1, right:1),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        alignment: AlignmentDirectional.topStart,
                        children: [
                          const Image(
                            image: AssetImage('assets/images/lastco.png'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25, left: 10),
                            child: Text(
                              'DOCBOOK',
                              style: TextStyle(
                                  color: defColor,
                                  fontSize: 20,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 210,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 50,
                                left: 12,
                              ),
                              child: Text(
                                'With over 1000 verified reviews, patients are able to search, compare and book the best doctor in just 1 minute',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget cardBuilder(context, DoctorModel model) => Padding(
        padding: const EdgeInsets.only(
          left: 10,
          top: 10,
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                DocLoginCubit.get(context)
                    .getDoctorData('${model.sId}')
                    .then((value) {
                  navigateTo(
                    context,
                    DoctorScreen('${model.sId}'),
                  );
                });
              },
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image(
                      image: NetworkImage(
                        '${model.photo ?? const AssetImage('assets/images/doc2.png')}',
                      ),
                      height: 240,
                      width: 180,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      width: 180,
                      height: 80,
                      decoration:
                          BoxDecoration(color: Colors.white.withOpacity(0.8)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 12, bottom: 12, right: 10, top: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model.userName ?? 'Not set yet',
                              style: TextStyle(
                                  color: defColor, fontSize: 14),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Expanded(
                              child: Text(
                                model.specialty ?? 'not set yet',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16,
                                  shadows: [Shadow(blurRadius: 2)],
                                ),
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16,
                                  shadows: [Shadow(blurRadius: 2)],
                                ),
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16,
                                  shadows: [Shadow(blurRadius: 2)],
                                ),
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16,
                                  shadows: [Shadow(blurRadius: 2)],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  '${model.raiting.toStringAsFixed(1) ?? 'not found'}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
