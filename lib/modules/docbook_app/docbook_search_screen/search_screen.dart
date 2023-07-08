import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramdan_proj/models/docbook_app/searchmodel.dart';
import 'package:ramdan_proj/modules/docbook_app/docbook_home_screen/doctor_page_from_user.dart';
import 'package:ramdan_proj/modules/docbook_app/docbook_search_screen/cubit/cubit.dart';
import 'package:ramdan_proj/modules/docbook_app/docbook_search_screen/cubit/states.dart';
import 'package:ramdan_proj/modules/docbook_app/login/cubit/states.dart';
import 'package:ramdan_proj/shared/components/components.dart';
import 'package:ramdan_proj/shared/styles/colors.dart';

import '../login/cubit/cubit.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> specialization = <String>[
    'Cardiology (Heart)',
    'Neurology (Brain & Nerves)',
    'Pediatrics and New born',
    'Orthopedics (Bones)',
    'Chest and Respiratory',
    'Scan Centers',
  ];

  String? specializationValue;

  final searchController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: defColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                'Doctors',
                style: TextStyle(
                  color: defColor,
                ),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      DropdownButtonHideUnderline(
                        child: DropdownButtonFormField(
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: defColor,
                            size: 30,
                          ),
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                          hint: Text(
                            'Specialization',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          items: specialization
                              .map(
                                (item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          value: specializationValue,
                          onChanged: (value) {
                            setState(() {
                              specializationValue = value as String;
                              //searchController.text=specializationValue!;
                              //SearchCubit.get(context).search(value!);
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: defaultFormField(
                                controller: searchController,
                                type: TextInputType.text,
                                validate: (value){
                                  if(value!.isEmpty){
                                    return 'enter text to search';
                                  }
                                  return null;
                                },
                                label: 'Search Name',
                                prefix: Icons.search,
                                onSubmit: (String text){
                                  //SearchCubit.get(context).search(text);
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: (){
                                if(searchController.text.isEmpty){
                                  SearchCubit.get(context).search(specializationValue!);
                                }else{
                                  SearchCubit.get(context).searchWithName(specializationValue, searchController.text);
                                }
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: defColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child:const Center(
                                  child:  Text(
                                    'Search',
                                    style: TextStyle(
                                      color: Colors.white
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (state is! SearchLoadingState&&state is! SearchNameLoadingState)
                        ConditionalBuilder(
                          condition: state is SearchSuccessState|| state is SearchNameSuccessState,
                          builder: (context) => SearchCubit.get(context)
                                      .model
                                      ?.message !=
                                  'sorry this doctors not found'
                              ? Expanded(
                                  child: ListView.separated(
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) =>
                                        buildSearchItem(
                                      context,
                                      SearchCubit.get(context)
                                          .model!
                                          .doctors![index],
                                    ),
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                      height: 20,
                                    ),
                                    itemCount: SearchCubit.get(context)
                                        .model!
                                        .doctors!
                                        .length,
                                  ),
                                )
                              : SizedBox(
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    const Image(
                                      image: AssetImage(
                                        'assets/images/items.png',
                                      ),

                                    ),
                                    Text(
                                        'sorry, There is no doctors in this department yet!',
                                        style:
                                            TextStyle(color: defColor, fontSize: 14),
                                      ),
                                  ],
                                ),
                              ),
                          fallback: (context) => const Center(
                            child: Text('Choose and Search Now!'),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}



Widget buildSearchItem(context, DoctorsModel? model) => BlocConsumer<DocLoginCubit,DocLoginStates>(
  listener: (context,state){},
  builder: (context,state){
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 3,
              blurRadius: 7,
            )
          ],
      ),
      padding: const EdgeInsets.all(20),
      height: 130,
      width: double.infinity,
      child: InkWell(
        onTap: () async{
          DocLoginCubit.get(context).getDoctorData('${model.sId}');
          navigateTo(context,DoctorScreen('${model.sId}'));
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(
                  '${model?.photo ?? const AssetImage('assets/images/doc2.png')}'),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model!.userName ?? 'Not Found',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: defColor,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Text(
                      model.specialty ?? 'not found',
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 14,
                        color: Colors.amber,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      const Icon(
                        Icons.star,
                        size: 14,
                        color: Colors.amber,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      const Icon(
                        Icons.star,
                        size: 14,
                        color: Colors.amber,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      const Icon(
                        Icons.star,
                        size: 14,
                        color: Colors.amber,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        model.raiting.toStringAsFixed(1).toString(),
                        style:
                        const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const Spacer(),
                      Container(
                        width: 80,
                        height: 30,
                        decoration: BoxDecoration(
                          color: defColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'Prize : 200\$',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
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
