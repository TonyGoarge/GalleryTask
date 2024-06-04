import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/presentation/style.dart';

import '../../core/Constants.dart';
import '../../core/Network/local/cache_helper.dart';
import '../../data/cubit/loginbloc.dart';
import '../../data/cubit/loginstates.dart';
import '../components/Navigator_component.dart';
import '../components/ShowToast.dart';
import '../components/button_widget.dart';
import '../components/login_components.dart';
import '../components/textformfield_widget.dart';
import 'homescreen.dart';

class LoginScreen extends StatelessWidget {
  double screenHeight = 0;
  double screenWidth = 0;

  final formkey = GlobalKey<FormState>();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (BuildContext context) =>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        // listener: (context , state){
        //   if (state is LoginSuccessState) {
        //     if (state.loginModel.token!.isNotEmpty) {
        //       print('Login successful: ${state.loginModel.token}');
        //
        //       // Save token using CacheHelper
        //       CachHelper.saveData(
        //         key: 'token',
        //         value: state.loginModel.token,
        //       ).then((value) {
        //         token = state.loginModel.token;  // Save the new token
        //         NavigatorandFinish(context, homeScreen());
        //       });
        //     } else {
        //       print('Login failed: Token is empty');
        //       ShowToast(
        //         text: 'Login failed: Token is empty',
        //         state: ToastStates.ERROR,
        //       );
        //     }
        //   }
        // },
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.token != null && state.loginModel.token!.isNotEmpty) {
              print('Login successful: ${state.loginModel.token}');

              // Save token using CacheHelper
              CachHelper.saveData(
                key: 'token',
                value: state.loginModel.token,
              ).then((value) {
                token = state.loginModel.token; // Save the new token
                NavigatorandFinish(context, homeScreen());
                ShowToast(
                  text: 'Login Success: Token is caught',
                  state: ToastStates.SUCCESS,
                );
              });
            } else {
              print('Login failed: Token is empty');
              ShowToast(
                text: 'Login failed: Token is empty',
                state: ToastStates.ERROR,
              );
            }
          } else if (state is LoginErrorState) {
            ShowToast(
              text: state.error,
              state: ToastStates.ERROR,
            );
          }
        },
        builder: (context , state){
          return Scaffold(
              body: Form(
                key: formkey,
                child: Stack(
                    children:
                    [
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [color1, color2, color3,],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomLeft,
                          ),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top:screenHeight/ 20.0, left:screenWidth/ 10.0),
                        child: Container(
                          height: screenHeight*0.16,
                          width: screenWidth*0.4,
                          child: Image.asset(
                            alignment: Alignment.topLeft,
                            "assets/images/cameraa.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),

                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:  [
                                Center(child: Text("My", style: TextStyle(
                                  fontWeight: FontWeight.bold,  fontSize: screenWidth / 9,color: textcolor,))),

                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:  [
                                Center(child: Text("Gellary", style: TextStyle(
                                  fontWeight: FontWeight.bold,  fontSize: screenWidth / 9,color: textcolor,))),

                              ],
                            ),
                            SizedBox(height: screenHeight*0.02,),
                            Padding(

                              padding:  EdgeInsets.symmetric(horizontal: screenHeight / 20.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2), // Move color here
                                  borderRadius: BorderRadius.circular(15.0),
                                ),

                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [

                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: screenWidth / 20.0),
                                        child: Center(child: Text("LOG IN",
                                          style: TextStyle(
                                              fontSize: screenWidth /12 , fontWeight: FontWeight.bold,color: Color(0xFF4A4B4B)),
                                        )),
                                      ),
                                      defaultformfield(

                                        type: TextInputType.emailAddress,
                                        label: "User Name",
                                        onChanged: (value){},
                                        onSubmit: (value) {
                                          if (formkey.currentState!.validate()) {
                                            LoginCubit.get(context).userLogin(
                                              email: emailcontroller.text,
                                              password: passwordcontroller.text,
                                            );
                                          }
                                        },
                                        validate: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please Enter Your Email';
                                          }
                                          return null;
                                        },
                                        controller: emailcontroller,
                                        hintStyle: TextStyle(color: Colors.grey[500]),
                                      ),
                                      SizedBox(height: screenHeight*0.03,),
                                      defaultformfield(
                                        // prefix: Icons.lock_outline,
                                        suffix:LoginCubit.get(context).suffix,
                                        type: TextInputType.visiblePassword,
                                        label: "Password",
                                        controller: passwordcontroller,
                                        obscureText: LoginCubit.get(context).isPassword,
                                        suffixPressed: ()
                                        {
                                          LoginCubit.get(context).ChangePasswordVisibility();
                                        },
                                        onSubmit: (value) {
                                          if (formkey.currentState!.validate()) {
                                            LoginCubit.get(context).userLogin(
                                                email: emailcontroller.text,
                                                password: passwordcontroller.text);
                                          }
                                        },
                                        validate: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Password is too short';
                                          }
                                          return null;
                                        },
                                        hintStyle: TextStyle(color: Colors.grey[500]),
                                      ),
                                      SizedBox(height: screenHeight*0.03,),
                                      ConditionalBuilder(
                                          condition:state is! LoginLoadingState ,
                                          builder:(context)=>defaultbotton(
                                            text: 'submit',
                                            radius: 8.0,
                                            toUpperCase:true,
                                            function:(){
                                              if (formkey.currentState!.validate()){
                                                LoginCubit.get(context).userLogin(
                                                  email: emailcontroller.text,
                                                  password: passwordcontroller.text,
                                                );
                                              }
                                            },) ,
                                          fallback: (context)=>Center(child: CircularProgressIndicator(),)),


                                      SizedBox(height: screenHeight*0.03,),

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),


                    ]
                ),
              )
          );
        },
      ),
    );
  }
}
