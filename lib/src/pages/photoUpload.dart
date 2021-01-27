import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';



class PhotoUpload extends StatefulWidget {

  @override
  _PhotoUploadState createState() => _PhotoUploadState();
}

class _PhotoUploadState extends State<PhotoUpload> {
  File sampleImage;
  String _myValue;
  String url;
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
        centerTitle: true,
      ),
      body: Center(
        child: sampleImage == null
            ? Text("Select and Image")
            : enableUpload(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: "Add Image",
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      sampleImage = tempImage;
    });
  }

  Widget enableUpload(){
    return SingleChildScrollView(
        child: Container (
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              Image.file(
                sampleImage,
                height: 300.0,
                width: 300.0,
              ),
              SizedBox(height: 15.0,),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Description"
                ),
                validator: (value){
                  return value.isEmpty ? "Description is required":null;
                },
                onSaved: (value){
                  return _myValue = value;
                },
              ),
              SizedBox(
                height: 15.0,
              ),
              RaisedButton(
                elevation: 10.0,
                child: Text("Add a New Post"),
                textColor: Colors.black,
                color: Colors.amber,
                onPressed: uploadStatusImage,
              )
            ],
          ),
        ),
      ),
    ) );
  }

  void uploadStatusImage() async{
    if(validateAndSave()){
      final  postImageRef= firebase_storage.FirebaseStorage.instance.ref().child('photoImages');
       var timeKey = DateTime.now();
       final uploadTask = postImageRef.child(timeKey.toString()+".jpg").putFile(sampleImage);
      //var imageUrl = await (await uploadTask.whenComplete(() => print));
    }
  }

  bool validateAndSave(){
    final form = formkey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }else{
      return false;
    }
  }


}

