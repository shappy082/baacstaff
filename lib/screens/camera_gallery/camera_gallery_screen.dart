import 'dart:io';

import 'package:baacstaff/utils/utility.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class CameraGalleryScreen extends StatefulWidget {
  CameraGalleryScreen({Key key}) : super(key: key);

  @override
  _CameraGalleryScreenState createState() => _CameraGalleryScreenState();
}

class _CameraGalleryScreenState extends State<CameraGalleryScreen> {
  // pop-up for choose image option
  Future<void> _showBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.image),
                title: Text('Gallery'),
                onTap: () {
                  _openGallery(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () {
                  _openCamera(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // var for reading file from device
  File _imageFile;
  final picker = ImagePicker();

  _openGallery(BuildContext context) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('image not selected');
      }
    });
    // close pop-up
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('image not taked');
      }
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera & Upload'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _imageFile == null
                  ? Text('Please select photo.')
                  : Image.file(
                      _imageFile,
                      width: 300,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
              _imageFile != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RaisedButton(
                          onPressed: () {
                            uploadImage();
                          },
                          child: Text('Upload'),
                          color: Colors.orangeAccent,
                        ),
                        RaisedButton(
                          onPressed: () {
                            clearImage();
                          },
                          child: Text('Clear'),
                          color: Colors.grey,
                        ),
                      ],
                    )
                  : SizedBox(
                      height: 1,
                    ),
              RaisedButton(
                onPressed: () {
                  _showBottomSheet(context);
                },
                child: Text(
                  'Choose picture',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                color: Colors.red,
              )
            ],
          ),
        ),
      ),
    );
  }

  void clearImage() {
    setState(() {
      _imageFile = null;
    });
  }

  Future uploadImage() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('Uploaded/${Path.basename(_imageFile.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(_imageFile);
    await uploadTask.onComplete;
    Utility.getInstance()
        .showAlertDialog(context, "Upload Status", "Upload Complete");
    clearImage();
  }
}
