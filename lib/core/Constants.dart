

import 'package:task/presentation/components/Navigator_component.dart';

import '../presentation/screen/loginscreen.dart';
import 'Network/local/cache_helper.dart';

void signout(context)
{
  CachHelper.removeData(key: 'token').then((value) {
    NavigatorandFinish(context, LoginScreen(),);
  });
}
String? token=CachHelper.getData(key: 'token');
