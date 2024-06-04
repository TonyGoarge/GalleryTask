import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task/core/Constants.dart';
import 'package:task/data/cubit/gallery_bloc.dart';
import 'package:task/data/cubit/loginbloc.dart';
import 'package:task/data/models/images_model.dart';
import 'package:task/data/models/images_model.dart';
import 'package:task/data/models/images_model.dart';
import 'package:task/data/models/login_model.dart';


import '../../data/cubit/gallery_state.dart';


import '../components/image_picker.dart';
import '../style.dart';

class homeScreen extends StatelessWidget {
  double screenHeight = 0;
  double screenWidth = 0;
  @override
  Widget build(BuildContext context) {
      var user = GalleryCubit.get(context).model ;
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (BuildContext context) =>GalleryCubit()..getImages(),

      child: BlocConsumer<GalleryCubit,GalleryStates>(
        listener: (context ,state) {
          if (state is ImageUploadErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.toString())),
            );
          } else if (state is ImageUploadSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Image uploaded successfully')),
            );
            // Trigger fetching images again if needed
            GalleryCubit.get(context).getImages();
          }
        },
        builder: (context , state){
          return Scaffold(

            body: Container(

              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [ color4, color5,],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomLeft,
                ),
              ),


              child: Padding(
                padding:  EdgeInsets.only(left: screenWidth/ 30.0,),

                child: Column(
                  children: [

                    Row(
                      children: [

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Welcome",
                                style: TextStyle(
                                  color: textcolor,
                                  fontSize: screenWidth / 10,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft, // Changed to topLeft to align properly
                              margin: const EdgeInsets.only(top: 5),
                              child: Text(
                                "Mina",
                                style: TextStyle(
                                  color: textcolor,
                                  fontSize: screenWidth / 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Spacer(), // Spacer to push the image to the right
                        ClipPath(
                          clipper: DirectionalWaveClipper(

                              horizontalPosition: HorizontalPosition.right),
                          child: Container(
                            color: profile,
                            width: screenWidth/3,
                            height: screenHeight/5,
                            alignment: Alignment.center, // Alignment to topRight to ensure image is on the right
                            child: CircleAvatar(
                              radius: screenWidth / 9, // Adjust size as needed
                              backgroundImage: AssetImage('assets/images/profile_image.png'), // Replace with your image asset
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: screenHeight/20.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white,
                              ),
                              child: TextButton(

                                onPressed: ()
                                {
                                  signout(context);
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.arrow_circle_left,color: Colors.pink,),
                                    Text("LOG OUT"),

                                  ],
                                ),

                              ),
                            ),
                          ),
                          const Spacer(),
                          Expanded(
                            child: Container(
                              height: screenHeight/20.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white,
                              ),
                              child: TextButton(onPressed: ()
                              {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Select Image '),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () async {
                                            // var image = await ImagePicker().pickImage(source: ImageSource.camera);
                                            var image = GalleryCubit.get(context).pickImageFromCamera();
                                            Navigator.of(context).pop(image);
                                          },
                                          child: Text('Camera'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            // var image = await ImagePicker().pickImage(source: ImageSource.gallery);
                                            var image = GalleryCubit.get(context).pickImageFromGallery();

                                            Navigator.of(context).pop(image);
                                          },
                                          child: Text('Gallery'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                                child: Row(
                                  children: [
                                    Icon(Icons.arrow_circle_up_outlined,color: Colors.amber),
                                    Text("UPLOAD"),

                                  ],
                                ),

                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
              //       Container(
              //   height: 200.0,
              //   width: 200.0,
              //   child: ListView.separated(
              //     physics: BouncingScrollPhysics(),
              //     itemCount: GetImageModel?.data?.images?.length ?? 0,
              //     separatorBuilder: (context, index) => Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: 20.0),
              //       child: Container(
              //         height: 1.0,
              //         color: Colors.grey[300],
              //       ),
              //     ),
              //     itemBuilder: (context, index) {
              //       final imageUrl = state.getimageModel.data?.images?[index];
              //       return imageUrl != null
              //           ? Image.network(imageUrl)
              //           : SizedBox(); // Display the image or an empty SizedBox if imageUrl is null
              //     },
              //   ),
              // );
                    ElevatedButton(onPressed: (){
                      Navigator.push(context,  MaterialPageRoute(
                        builder: (context)=>  UploadScreen(token: token.toString(),),
                      ));
                    }, child: Text("UploadScreen")
                    ),
                  ],
                ),

              ),
            ),

          );
        },
      ),
    );
  }
}

Widget buildImagesList(BuildContext context, List<String> images) {
  return GridView.builder(
    padding: const EdgeInsets.all(8.0),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 1.0,
      childAspectRatio: 1 / 1.75,
    ),
    itemCount: images.length,
    itemBuilder: (context, index) {
      return Image.network(
        images[index],
        fit: BoxFit.cover,
      );
    },
  );
}
