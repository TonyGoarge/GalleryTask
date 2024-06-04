import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/data/cubit/loginbloc.dart';
import 'package:task/data/cubit/loginstates.dart';
import 'package:task/presentation/screen/homescreen.dart';
import 'package:task/presentation/screen/loginscreen.dart';

import 'core/Constants.dart';
import 'core/Network/bloc_observer.dart';
import 'core/Network/local/cache_helper.dart';
import 'core/Network/remote/dio.helper.dart';
import 'data/cubit/gallery_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CachHelper.init();
  Widget widget;

  token=CachHelper.getData(key:'token');
print('tokennnnnnnnnnnnn$token');


    if(token !=null)
    {
      widget=homeScreen();
    }
    else
    {
      widget=LoginScreen();
      // widget=StoreLoginScreen();
    }


  runApp( MyApp(
    StartWidget: widget,

  ));
}

class MyApp extends StatelessWidget {
  final Widget StartWidget;

  const MyApp({super.key, required this.StartWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context)=>GalleryCubit()..getImages(),
        ),
        BlocProvider( // Provide the LoginCubit
          create: (context) => LoginCubit(),
        ),
      ],
        child: BlocConsumer<LoginCubit,LoginStates>(
          listener: (context , state){},
          builder: (context , state){
            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(

                primarySwatch: Colors.blue,
              ),
              home:  StartWidget,
            );
          },
        ),

    );
  }
}


