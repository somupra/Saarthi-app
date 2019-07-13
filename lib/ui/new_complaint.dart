import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import '../common/functions/fileComplaint.dart';

class NewComplaint extends StatefulWidget {
  @override
  _NewComplaintState createState() => _NewComplaintState();
}

class _NewComplaintState extends State<NewComplaint> {

  TextEditingController _descriptionController = new TextEditingController();

  // Instantiating a File object and getting it from future
  File ref_image;

  Future getImageFromCam() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera, maxHeight: 400, maxWidth: 400);
    print("Image Captured");
    setState(() {
      ref_image = image;
    });
  }

  final _complaintFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("New complaint"),
      ),
      body: Form(
        key: _complaintFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5.0),
              child: Center(
                child: ref_image == null ?
                Text("Press the camera button to capture image")
                : Image.file(ref_image),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(helperText: "Enter description, required"),
              controller: _descriptionController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter a description';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_complaintFormKey.currentState.validate() && ref_image != null ) {
                      CreateComplaint(context, ref_image, _descriptionController.text);
                  }
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.teal,
            onPressed: getImageFromCam,
            child: Icon(
              Icons.camera_alt,
              size: 20.0,
        ),
        ),
    );
  }
}



