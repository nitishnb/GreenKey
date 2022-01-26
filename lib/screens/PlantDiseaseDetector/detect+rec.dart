import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:image/image.dart' as img;
import 'dart:math';

import 'remedies.dart';

class Tensorflow1 extends StatefulWidget {
  @override
  _Tensorflow1State createState() => _Tensorflow1State();
}

class _Tensorflow1State extends State<Tensorflow1> {
  List _outputs;
  File _image;
  bool _loading = false;
  int i;
  final picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/plant_disease.tflite",
      labels: "assets/labels.txt",
      numThreads: 1,
    );
  }
  Uint8List imageToByteListFloat32(
      img.Image image, int inputSize, double mean, double std) {
    var convertedBytes = Float32List(1 * inputSize * inputSize * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = (img.getRed(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getGreen(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getBlue(pixel) - mean) / std;
      }
    }
    return convertedBytes.buffer.asUint8List();
  }

  Uint8List imageToByteListUint8(img.Image image, int inputSize) {
    var convertedBytes = Uint8List(1 * inputSize * inputSize * 3);
    var buffer = Uint8List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = img.getRed(pixel);
        buffer[pixelIndex++] = img.getGreen(pixel);
        buffer[pixelIndex++] = img.getBlue(pixel);
      }
    }
    return convertedBytes.buffer.asUint8List();
  }

  Temp(File i){
    File file = new File(i.path);
    Uint8List bytes = file.readAsBytesSync();
    ByteData byteData = ByteData.view(bytes.buffer);
    return byteData;
  }


  classifyImage(File image) async {
    print("bbbbbbbbbbbbbbbbbbbbbbbb");
    print(image.path);
    var imageBytes = Temp(image);//(await rootBundle.load(image.path)).buffer;
    print(image.path);
    img.Image oriImage = img.decodeJpg(imageBytes.buffer.asUint8List());
    print(image.path);
    img.Image resizedImage = img.copyResize(oriImage, height: 224, width: 224);
    print(image.path);
    var output = await Tflite.runModelOnBinary(binary: imageToByteListFloat32(resizedImage, 224, 127.5, 127.5),numResults: 6,threshold: 0.04);

    //var output = await Tflite.runModelOnImage(path: image.path,numResults: 2,threshold: 0.5,imageMean: 127.5,imageStd: 127.5);
    setState(() {
      print(output);
      _loading = false;
      _outputs = output;
      i=0;
    });
  }
  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
  pickImage() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        _image = File(image.path);
        print("Image selected,");
      } else {
        print('No image selected.');
      }
    });
    classifyImage(_image);
  }

  pickImage_cam() async {
    var image = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (image != null) {
        _image = File(image.path);
        print("Image selected,");
      } else {
        print('No image selected.');
      }
    });
    classifyImage(_image);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Plant Disease Detector",
          style: TextStyle(color: Colors.white, fontSize: 26),
        ),
        backgroundColor: Colors.lightGreen,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _loading ? Container(
              height: 200,
              width: 200,
            ):
            Container(
              margin: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _image == null ? Container(child: Text("We'll Detect !\n\n\n",style: TextStyle(color: Colors.lightGreen,fontSize: 32,fontWeight: FontWeight.bold), ))
                      : Image.file(_image,width: 350,height: 350,),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*.01,
                  ),
                  _image == null ? Container() : _outputs != null ?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      for(var item in _outputs ) TextButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                        ),
                        onPressed: (){},
                        child: Text("${++i}. ${item['label']} : ${(item['confidence']*100).toInt()}%",
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*.03,
                      ),
                      FloatingActionButton.extended(
                        onPressed: () {Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Remedy(disease:_outputs),
                            ));},
                        icon: Icon(Icons.announcement_rounded),
                        label: Text("Get Remedies"),
                        backgroundColor: Colors.red,
                      ),
                    ],)
                      : Container()
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FloatingActionButton(
                  tooltip: 'Pick Image',
                  onPressed: pickImage,
                  child: Icon(Icons.add_photo_alternate_outlined,
                    size: 20,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.lightGreen,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.height * 0.08,
                ),
                FloatingActionButton(
                  tooltip: 'Pick Image',
                  onPressed: pickImage_cam,
                  child: Icon(Icons.add_a_photo,
                    size: 20,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.lightGreen,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}