import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../layout/shop_app/cubit/cubit.dart';
import '../styles/colors.dart';
import '../todo_cubit/cubit.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 0.0,
  required Function() function,
  required String text,
}) =>
    Container(
      width: width,
      height: 40.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
Widget defaultTextButton({
  required Function() function,
  required String text,
}) =>
    TextButton(
        onPressed: function,
        child: Text(text.toUpperCase()),
    );
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onSubmit,
  Function(String)? onChanged,
  Function()? onTap,
  required String? Function(String?)? validate,
  String? label,
  required IconData prefix,
  bool isPassword = false,
  IconData? suffix,
  Function()? suffixPressed,
  double borderWidth=1,
  Color borderColor = Colors.black,
  double borderRadius=10,
  bool filled=true,
  String? hint,
}) =>
    TextFormField(
      keyboardType: type,
      controller: controller,
      decoration: InputDecoration(
        filled: filled,
        contentPadding:EdgeInsets.all(5.0) ,
        fillColor: Colors.white,
        enabledBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
          borderSide: BorderSide(
            color: borderColor,
            width: borderWidth,
          )
        ),
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(
            prefix,
          ),
          suffixIcon: suffix != null
              ? IconButton(
                  icon: Icon(
                    suffix,
                  ),
                  onPressed: suffixPressed,
                )
              : null,
          border: const OutlineInputBorder(
          ),
      ),
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      onTap: onTap,
      validator: validate,
      obscureText: isPassword,
    );

Widget buildTaskItem(
  Map model,
  context, {
  doneShow = true,
  archivedShow = true,
}) =>
    Dismissible(
      key: Key(model['id'].toString()),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Please Confirm Delete'),
            content: const Text('Are you sure?'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(false);
                  },
                  child: const Text('Cancel')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(true);
                  },
                  child: const Text('Delete')),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(id: model['id']);
      },
      background: Container(
        color: Colors.red,
        padding: const EdgeInsetsDirectional.only(start: 300.0),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              child: Text(
                '${model['time']}',
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${model['date']}',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Visibility(
              visible: doneShow,
              child: IconButton(
                onPressed: () {
                  AppCubit.get(context).updateData(
                    status: 'done',
                    id: model['id'],
                  );
                },
                icon: const Icon(
                  Icons.check_box,
                  color: Colors.green,
                ),
              ),
            ),
            Visibility(
              visible: archivedShow,
              child: IconButton(
                onPressed: () {
                  AppCubit.get(context).updateData(
                    status: 'archive',
                    id: model['id'],
                  );
                },
                icon: const Icon(
                  Icons.archive,
                  color: Colors.black45,
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget buildBuilder({
  required List<Map> tasks,
  doneShow = true,
  archivedShow = true,
}) =>
    ConditionalBuilder(
      condition: tasks.isNotEmpty,
      builder: (BuildContext context) => ListView.separated(
        itemBuilder: (context, index) => buildTaskItem(
          tasks[index],
          context,
          doneShow: doneShow,
          archivedShow: archivedShow,
        ),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: tasks.length,
      ),
      fallback: (BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.menu,
              size: 100,
              color: Colors.grey,
            ),
            Text(
              'No Tasks yet, please add some tasks!',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ],
        ),
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );
Widget buildArticleItem(article, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 120.0,
            height: 120.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                10.0,
              ),
              image: DecorationImage(
                image: NetworkImage(
                  '${article["urlToImage"]}',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: SizedBox(
              height: 120.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${article['title']}',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Text(
                    '${article['publishedAt']}',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

Widget articleBuilder(list, context) => ConditionalBuilder(
      condition: list.isNotEmpty,
      builder: (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return buildArticleItem(list[index], context);
        },
        separatorBuilder: (BuildContext context, int index) {
          return myDivider();
        },
        itemCount: 10,
      ),
      fallback: (context) => const Center(child: CircularProgressIndicator()),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false,
    );

void showToast({
  required String text,
  required ToastStates state,


})=>Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStates{ SUCCESS,ERROR,WARNING }

Color chooseToastColor(ToastStates state){
  Color color;
  switch(state)
  {
    case ToastStates.SUCCESS:
      color=Colors.green;
      break;
    case ToastStates.ERROR:
      color=Colors.red;
      break;
    case ToastStates.WARNING:
      color=Colors.amber;
  }
  return color;
}

Widget buildListProduct(model,context,{bool isOldPrice=true})=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: SizedBox(
    height: 120,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage('${model.image}'),
              width: 120,
              height: 120,
            ),
            if(model.discount!=0 && isOldPrice)
              Container(
                color: Colors.red,
                padding: const EdgeInsets.symmetric(
                  horizontal: 5.0,
                ),
                child: const Text(
                  'DISCOUNT',
                  style: TextStyle(
                      fontSize: 8.0,
                      color: Colors.white
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14.0,
                  height: 1.3,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: defaultColor,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  if(model.discount != 0&&isOldPrice)
                    Text(
                      '${model.oldPrice.round()}',
                      style: const TextStyle(
                        height: 1.3,
                        fontSize: 10.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ) ,
                  const Spacer(),
                  IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: (){
                        ShopCubit.get(context).changeFavorites(model.id);
                      },
                      icon: CircleAvatar(
                        backgroundColor:
                        ShopCubit.get(context).favorites[model.id]!=null?defaultColor:Colors.grey ,
                        radius: 15.0,
                        child: const Icon(
                          Icons.favorite_border,
                          size: 12,
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);

