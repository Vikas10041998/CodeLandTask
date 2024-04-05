
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'HomeScreen.dart';
import 'SplashScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Image Upload',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashScreen(),
    );
  }
}

class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  File? _image;
  double progress = 0;
  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);

      } else {
        print('No image selected.');
      }
    });
  }

  // Future uploadImage() async {
  //   if (_image == null) {
  //     Fluttertoast.showToast(msg: 'Please select an image first');
  //     return;
  //   }
  //   FirebaseStorage storage = FirebaseStorage.instance;
  //   Reference ref = storage.ref().child('images/${DateTime.now().toString()}');
  //   // UploadTask uploadTask = ref.putFile(_image!);
  //   // await uploadTask.whenComplete(() => Fluttertoast.showToast(msg: 'Image uploaded'));
  //   UploadTask uploadTask = ref.putFile(_image!);
  //   await uploadTask.whenComplete(() {
  //     Fluttertoast.showToast(msg: 'Image uploaded');
  //     // Update UI to reflect the uploaded image
  //     setState(() {
  //       _image = null;
  //     });
  //   });
  // }
  Future uploadImage() async {
    if (_image == null) {
      Fluttertoast.showToast(msg: 'Please select an image first');
      return;
    }

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child('images/${DateTime.now().toString()}');

    // Show the progress indicator
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dialog from being dismissed
      builder: (context) {
        // Set initial progress to 0%
        double progress = 0;
        return AlertDialog(
          title: Text('Uploading Image...'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LinearProgressIndicator(
                value: progress,
              ),
            ],
          ),
        );
      },
    );

    // Upload the image
    UploadTask uploadTask = ref.putFile(_image!);

    // Track upload progress
    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      double percentage = snapshot.bytesTransferred / snapshot.totalBytes;
      // Update progress indicator
      setState(() {
        progress = percentage;
      });
    });

    // Wait for the upload to complete
    await uploadTask;

    // Dismiss the progress indicator dialog
    Navigator.of(context).pop();

    // Show toast message indicating successful upload
    Fluttertoast.showToast(msg: 'Image uploaded');

    // Reset the image variable
    setState(() {
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Image Upload')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Text("Upload a image", style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(height: 15,),

            InkWell(
              onTap: (){
                pickImage();
              },
              child: Container(
                  height: MediaQuery.of(context).size.height/1.7,
                  width: MediaQuery.of(context).size.width/1.5,


                  child:
                  _image != null
                      ? Image.file(
                    _image!,
                    fit: BoxFit.fill, // Adjust the fit based on your requirement
                  )
                      :
                  Image.asset("assets/img_2.png")
              ),
            ),

            SizedBox(height: 20.0),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: uploadImage,

                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                      ),
                      primary: Colors.orange, // Change the color as needed
                    ),
                    child: Text('Upload'),

                  ),
                  SizedBox(width: MediaQuery.of(context).size.width/4,),
                  ElevatedButton(
                    onPressed: () {

                      Navigator.push(context, MaterialPageRoute(builder: (context) => ViewScreen(),));

                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                      ),
                      primary: Colors.grey, // Change the color as needed
                    ),
                    child: Text('View'),
                  ),
                ],),
            )
          ],
        ),
      ),
    );
  }
}
