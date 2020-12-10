//import 'package:GreenKey/services/uploader.dart';
//import 'package:flutter/material.dart';
//import 'dart:io';
//import 'package:flutter/widgets.dart';
//import 'package:image_cropper/image_cropper.dart';
//import 'package:image_picker/image_picker.dart';
//
//class ImageCapture extends StatefulWidget {
//  @override
//  _ImageCaptureState createState() => _ImageCaptureState();
//}
//
//class _ImageCaptureState extends State<ImageCapture> {
//  File _imageFile;
//
//  //Select an image via gallery or camera
//  Future<void> _pickImage(ImageSource source) async {
//    File selected = await ImagePicker.pickImage(source: source);
//
//     setState(() {
//       _imageFile = selected;
//     });
//  }
//
//  //cropper plugin
//  Future<void> _cropImage() async {
//      File cropped = await ImageCropper.cropImage(
//          sourcePath: _imageFile.path,
//          //ratioX: 1.0,
//          //ratioY: 1.0,
//          //maxWidth: 512,
//          //maxHeight: 512,
//          toolbarColor: Colors.green,
//          toolbarWidgetColor: Colors.white,
//          toolbarTitle: 'Crop It',
//      );
//
//      setState(() {
//        _imageFile = cropped ?? _imageFile;
//      });
//  }
//
//  //Remove image
//  void _clear() {
//    setState(() {
//      _imageFile = null;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      bottomNavigationBar: BottomAppBar(
//        child: Row(
//          children: <Widget>[
//            IconButton(
//                icon: Icon(Icons.photo_camera),
//                onPressed: () => _pickImage(ImageSource.camera),
//            ),
//            IconButton(
//              icon: Icon(Icons.photo_library),
//              onPressed: () => _pickImage(ImageSource.gallery),
//            ),
//          ],
//        ),
//      ),
//      body: ListView(
//        children: <Widget>[
//            if (_imageFile != null) ...[
//
//              Image.file(_imageFile),
//
//              Row(
//                children: <Widget>[
//                  FlatButton(onPressed: _cropImage, child: Icon(Icons.crop),),
//                  FlatButton(onPressed: _clear, child: Icon(Icons.refresh),),
//                ],
//              ),
//              Uploader(file: _imageFile),
//
//            ]
//        ],
//      ),
//    );
//  }
//}
