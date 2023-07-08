import '../../layout/docbook_app/cubit/cubit.dart';
import '../../modules/docbook_app/login/login_screen.dart';
import '../network/local/cashe_helper.dart';
import 'components.dart';

void signOut(context) {
  DocBookCubit.get(context).curIndex = 0;
  CasheHelper.removeData(key: 'token');
      CasheHelper.removeData(key: 'doctor');
      CasheHelper.removeData(key: 'userid');
      doctor = null;
      navigateAndFinish(
        context,
        DocLoginScreen(),
      );
     }


void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

dynamic token = '';
dynamic userid = '';
dynamic role = '';

bool? doctor;
bool isDoctor(context,String role1) {
  if (role1 == 'user') {
    doctor = false;
  } else if (role1 == 'doctor') {
    doctor = true;
  }
  return doctor!;
}
