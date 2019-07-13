import 'dart:convert';
import 'dart:io';
import 'dart:async';

Future<String> tobase64(File image)async{
  // convert image to base64
  List<int> imageBytes = await image.readAsBytes();
  String base64Image = base64Encode(imageBytes);

  // for debugging
//  print(base64Image);

  return base64Image;
}