
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task/core/Constants.dart';
import 'package:task/data/models/images_model.dart';

import '../../core/Network/end_points.dart';
import '../../core/Network/remote/dio.helper.dart';
import '../models/login_model.dart';
import '../models/uploadimage.dart';
import 'gallery_state.dart';

class GalleryCubit extends Cubit<GalleryStates>
{
  GalleryCubit():super(GalleryInitialState());

  static GalleryCubit get(context)=>BlocProvider.of(context);
   GetImageModel? getimageModel;

User?model;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImageFromGallery() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        uploadImage(imageFile,token);
        emit(GalleryUploadSuccessState(imageFile));
      } else {
        emit(GalleryUploadErrorState('No image selected.'));
      }
    } catch (e) {
      emit(GalleryUploadErrorState(e.toString()));
    }
  }

  Future<void> pickImageFromCamera() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        uploadImage(imageFile,token);
        emit(CameraUploadSuccessState(imageFile));
      } else {
        emit(CameraUploadErrorState('No image selected.'));
      }
    } catch (e) {
      emit(CameraUploadErrorState(e.toString()));
    }
  }


  Future<void> uploadImage(File? imageFile,token ) async {
    try {
      if (imageFile == null) {
        emit(ImageUploadErrorState('No image selected.'));
        return;
      }

      String fileName = imageFile.path.split('/').last;

      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(imageFile.path, filename: fileName),
      });



      emit(ImageUploadLoadingState());

      final response = await DioHelper.postDataa(
        url: UPLOAD,
        token: token,
        data: formData,
      );

      if (response.statusCode == 200) {
        // Parse the response data
        final jsonData = jsonDecode(response.data);
        final uploadImage = UploadImage.fromJson(jsonData);
          Future.delayed(Duration(seconds: 20));
        emit(ImageUploadSuccessState(uploadImage));
      } else {
        emit(ImageUploadErrorState('Failed to upload image. Server error.'));
      }
    } catch (e) {
      print(e.toString());
      emit(ImageUploadErrorState('Failed to upload image. $e'));
    }

    //   if (response.statusCode == 200) {
    //     final data = UploadImage.fromJson(response.data);
    //     emit(ImageUploadSuccessState(data));
    //   } else {
    //     emit(ImageUploadErrorState('Failed to upload image. Server error.'));
    //   }
    // } catch (e)
    // {
    //   print(e.toString());
    //   print(token.toString());
    //   emit(ImageUploadErrorState(e.toString()));
    // }
  }








  void getImages()  {

      emit(GetImagesLoadingState());

        DioHelper.getData(
            url: GALLERY,
            token: token,
      ).then((value)
        {
          getimageModel=GetImageModel.fromJson(value.data) ;
        print(value.data);
          emit(GetImagesSuccessfullyState(getimageModel!));


  }).catchError((error) {
          print('Error: ${error.toString()}');
          if (error is DioError) {
            print('Dio error: ${error.response?.data}');
          }
          emit(GetImagesErrorState());
        });

  // void getImages() {
  //   emit(GetImagesLoadingState());
  //
  //   DioHelper.getData(
  //     url: GALLERY,
  //     token: token,
  //   ).then((value) {
  //     imageModel = ImageModel.fromJson(value.data);
  //     print(value.data);
  //     emit(GetImagesSuccessfullyState(imageModel!));
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(GetImagesErrorState());
  //   });
  // }




      // Check if the response is successful
    //   if (response.statusCode == 200) {
    //     // Parse the response data into a list of images
    //     images= (response.data as List<dynamic>)
    //         .map((item) => ImageModel.fromJson(item))
    //         .toList();
    //       print("imagesssssssssssssssssssssssssssss$images");
    //     emit(GetImagesSuccessfullyState(images));
    //   } else {
    //     // If the response is not successful, emit an error state
    //     emit(GetImagesErrorState('Failed to fetch images. Server error.'));
    //   }
    // } catch (e) {
    //   // If an exception occurs, emit an error state
    //   emit(GetImagesErrorState(e.toString()));
    // }
  }



  }