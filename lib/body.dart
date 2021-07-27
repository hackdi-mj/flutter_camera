import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mycamera/camera_screen.dart';

class Body extends StatelessWidget {
  final String imagePath;

  const Body({Key? key, required this.imagePath}) : super(key: key);

  @override
  Route _allPage() {
    // routing page
    return PageRouteBuilder(
      transitionDuration: Duration(seconds: 1),
      pageBuilder: (context, animation, secondaryAnimation) => CameraScreen(), //navigation
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // transition
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          Navigator.of(context).push(_allPage());
        },
        child: Icon(
          Icons.camera,
          color: Colors.white,
          size: 35,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          "Camera Implementation".toUpperCase(),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  child: Container(
                      width: 400,
                      height: 600,
                      decoration: imagePath == ""
                          ? BoxDecoration()
                          : BoxDecoration(image: DecorationImage(image: FileImage(File(imagePath)), fit: BoxFit.cover)),
                      child: imagePath == ""
                          ? Center(
                              child: Icon(
                                Icons.image,
                                color: Colors.blueAccent,
                                size: 50,
                              ),
                            )
                          : Container()),
                ),
              ],
            ),
          ),
          // Container(
          //   padding: EdgeInsets.only(top: 50),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Container(
          //         width: 200,
          //         height: 50,
          //         child: ElevatedButton(
          //           style: ElevatedButton.styleFrom(
          //             primary: Colors.blueAccent,
          //             elevation: 0,
          //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          //           ),
          //           onPressed: () {},
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Icon(
          //                 Icons.perm_media,
          //                 color: Colors.white,
          //               ),
          //               SizedBox(
          //                 width: 10,
          //               ),
          //               Text(
          //                 "Galeri".toUpperCase(),
          //                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 2),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Container(
          //   padding: EdgeInsets.only(top: 50),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Container(
          //         width: 200,
          //         height: 50,
          //         child: ElevatedButton(
          //             style: ElevatedButton.styleFrom(
          //               primary: Colors.blueAccent,
          //               elevation: 0,
          //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          //             ),
          //             onPressed: () {},
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 Icon(
          //                   Icons.delete,
          //                   color: Colors.white,
          //                 ),
          //                 SizedBox(
          //                   width: 10,
          //                 ),
          //                 Text(
          //                   "remove".toUpperCase(),
          //                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 2),
          //                 ),
          //               ],
          //             )),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
