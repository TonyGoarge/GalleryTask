// // import 'dart:io';
// // import 'package:http/http.dart' as http;
// // import 'package:flutter/material.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'dart:convert';
// //
// // import 'package:task/core/Network/end_points.dart';
// //
// // import '../../core/Constants.dart';
// //
// // class HomeScreen extends StatefulWidget {
// //   @override
// //   _HomeScreenState createState() => _HomeScreenState();
// // }
// //
// // class _HomeScreenState extends State<HomeScreen> {
// //    File? _image;
// //   String message = '';
// //
// //   //replace the url by your url
// //   String url =
// //       "https://flutter.prominaagency.com/api/upload"; // your rest api url 'http://your_ip_adress/project_path'
// //   bool loading = false;
// //   pickImage() async {
// //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
// //
// //     setState(() => _image = File(image!.path) );
// //   }
// //
// //   upload(File file) async {
// //     if (file == null) return;
// //
// //     setState(() {
// //       loading = true;
// //     });
// //     Map<String, String> headers = {
// //       "Accept": "application/json",
// //       "Authorization": "Bearer $token", // Add the token to the headers
// //     };
// //     var uri = Uri.parse(url);
// //     var length = await file.length();
// //     print(length);
// //     http.MultipartRequest request = new http.MultipartRequest('POST', uri)
// //       ..headers.addAll(headers)
// //       ..files.add(
// //         // replace file with your field name exampe: image
// //         http.MultipartFile('file', file.openRead(), length,
// //             filename: 'test.png'),
// //       );
// //     var respons = await http.Response.fromStream(await request.send());
// //     print(respons.statusCode);
// //     setState(() {
// //       loading = false;
// //     });
// //     if (respons.statusCode == 200) {
// //       setState(() {
// //         message = ' image upload with success';
// //       });
// //       return;
// //     } else
// //       setState(() {
// //         message = ' image not upload';
// //       });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Column(
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         children: <Widget>[
// //           loading
// //               ? Padding(
// //             padding: EdgeInsets.only(top: 52),
// //             child: Center(child: CircularProgressIndicator()),
// //           )
// //               : _image != null
// //               ? Image.file(
// //             _image!,
// //             height: MediaQuery.of(context).size.height * 0.4,
// //             width: double.infinity,
// //             fit: BoxFit.cover,
// //           )
// //               : Image.network(
// //               'https://www.generationsforpeace.org/wp-content/uploads/2018/03/empty.jpg'),
// //           Text(message),
// //           Row(
// //             children: <Widget>[
// //               Expanded(
// //                 child: ElevatedButton(
// //                   onPressed: () => pickImage(),
// //                   child: Text('Pick Image'),
// //                 ),
// //               ),
// //               Expanded(
// //                 child: ElevatedButton(
// //                   onPressed: () => upload(_image!),
// //                   child: Text('upload image'),
// //                 ),
// //               ),
// //             ],
// //           )
// //         ],
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class UploadScreen extends StatelessWidget {
//   final String token;
//
//   UploadScreen({required this.token});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => GalleryCubit()..getImages(token),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Gallery'),
//         ),
//         body: BlocBuilder<GalleryCubit, GalleryStates>(
//           builder: (context, state) {
//             if (state is GetImagesLoadingState) {
//               return Center(child: CircularProgressIndicator());
//             } else if (state is GetImagesSuccessfullyState) {
//               return Container(
//                 height: 200.0,
//                 width: 200.0,
//                 child: ListView.separated(
//                   physics: BouncingScrollPhysics(),
//                   itemCount: state.getImageModel.data?.images?.length ?? 0,
//                   separatorBuilder: (context, index) => Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                     child: Container(
//                       height: 1.0,
//                       color: Colors.grey[300],
//                     ),
//                   ),
//                   itemBuilder: (context, index) {
//                     final imageUrl = state.getImageModel.data?.images?[index];
//                     return imageUrl != null
//                         ? Image.network(imageUrl)
//                         : SizedBox(); // Display the image or an empty SizedBox if imageUrl is null
//                   },
//                 ),
//               );
//             } else if (state is GetImagesErrorState) {
//               return Center(child: Text('Failed to load images.'));
//             } else {
//               return Center(child: Text('Unknown state.'));
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../core/Constants.dart';
import '../../data/cubit/gallery_bloc.dart';
import '../../data/cubit/gallery_state.dart';

class UploadScreen extends StatefulWidget {
  final String token;

  UploadScreen({required this.token});

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  File? _image;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GalleryCubit()..getImages(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Gallery'),
        ),
        body: BlocConsumer<GalleryCubit, GalleryStates>(
          listener: (context, state) {
            if (state is ImageUploadErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("state.error")),
              );
            } else if (state is ImageUploadSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Image uploaded successfully')),
              );
              GalleryCubit.get(context).getImages();
              print(token);
            }
          },
          builder: (context, state) {
            if (state is GetImagesLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is GetImagesSuccessfullyState) {
              return Column(
                children: [
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: Text('Pick Image'),
                  ),
                  if (_image != null)
                    ElevatedButton(
                      onPressed: () {
                        GalleryCubit.get(context).uploadImage(_image, widget.token);
                      },
                      child: Text('Upload Image'),
                    ),
                  Expanded(
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemCount: state.getimageModel.data?.images?.length ?? 0,
                      separatorBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                          height: 1.0,
                          color: Colors.grey[300],
                        ),
                      ),
                      itemBuilder: (context, index) {
                        final imageUrl = state.getimageModel.data?.images?[index];
                        return imageUrl != null
                            ? Image.network(imageUrl)
                            : SizedBox();
                      },
                    ),
                  ),
                ],
              );
            } else if (state is GetImagesErrorState) {
              return Center(child: Text('Failed to load images.'));
            } else {
              return Center(child: Text('Unknown state.'));
            }
          },
        ),
      ),
    );
  }
}

