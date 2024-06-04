import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/data/cubit/loginstates.dart';
import 'package:task/data/models/login_model.dart';

import '../../core/Network/end_points.dart';
import '../../core/Network/remote/dio.helper.dart';




class LoginCubit extends Cubit<LoginStates>
{
  LoginCubit():super(LoginInitialState());

  static LoginCubit get(context)=>BlocProvider.of(context);
  late LoginModel loginModel;
  void userLogin
      ({
    required String email,
    required String password,
  })
  {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: LOGIN,                       //End point
      data:
      {
        'email':email,
        'password':password,
      },
    ).then((value)
    {
      print (value.data);
      loginModel=LoginModel.fromJson(value.data);


      print (value.data['massage']);
      print (value.data['token']);
      emit(LoginSuccessState(loginModel));
    }).catchError((error)
    {
      print(error.toString());
      emit(LoginErrorState(error.toString()));

    });
  }


  IconData suffix= Icons.visibility_outlined;
  bool isPassword=false;
  void ChangePasswordVisibility()
  {
    isPassword=!isPassword;
    suffix=isPassword? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangePasswordvisibilityState());
  }




}

