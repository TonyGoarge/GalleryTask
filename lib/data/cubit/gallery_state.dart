
import 'dart:io';

import 'package:task/data/models/uploadimage.dart';

import '../models/images_model.dart';

abstract class GalleryStates{}
class GalleryInitialState extends GalleryStates{}
class GalleryUploadSuccessState extends GalleryStates{
  GalleryUploadSuccessState(File imageFile);
}
class GalleryUploadErrorState extends GalleryStates{
  GalleryUploadErrorState(String E);
}




class CameraUploadSuccessState extends GalleryStates{
  CameraUploadSuccessState(File imageFile);
}
class CameraUploadErrorState extends GalleryStates{
  CameraUploadErrorState(String E);
}



class ImageUploadLoadingState extends GalleryStates{}

class ImageUploadSuccessState extends GalleryStates{
  ImageUploadSuccessState(UploadImage imageFile);
}
class ImageUploadErrorState extends GalleryStates{
  ImageUploadErrorState(String E);
}



class GetImagesLoadingState extends GalleryStates{
  GetImagesLoadingState( );
}
class GetImagesSuccessfullyState extends GalleryStates{
  final  GetImageModel getimageModel;

  GetImagesSuccessfullyState(this.getimageModel);
}
class GetImagesErrorState extends GalleryStates{
  GetImagesErrorState();
}

