import 'dart:io';
import 'dart:typed_data';

import 'package:basiclogin/const/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class RelationScreen extends StatefulWidget {
  const RelationScreen({super.key});

  @override
  State<RelationScreen> createState() => _RelationScreenState();
}

class _RelationScreenState extends State<RelationScreen> {
  Uint8List? imageData;
  Uint8List? imageData2;
  Uint8List? imageData3;

  var imagePath;
  var imagePath2;
  var imagePath3;

  String profileImageLink = "";
  String profileImageLink2 = "";
  String profileImageLink3 = "";
  @override
  void initState() {
    super.initState();
    loadAsset('assets/images/vector-1.png');
  }

  void loadAsset(String name) async {
    var data = await rootBundle.load(name);
    setState(
      () {
        imageData = data.buffer.asUint8List();
      },
    );
  }

  Future getImage(ImageSource source, int index) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;

    final imageTemporary = File(image.path);
    setState(
      () {
        if (index == 1) {
          imagePath = image.path;
          imageData = imageTemporary.readAsBytesSync();
        } else if (index == 2) {
          imagePath2 = image.path;
          imageData2 = imageTemporary.readAsBytesSync();
        } else if (index == 3) {
          imagePath3 = image.path;
          imageData3 = imageTemporary.readAsBytesSync();
        }
      },
    );
  }

  uploadImage1() async {
    final user = FirebaseAuth.instance.currentUser;
    if (imagePath != null) {
      var filename = basename(imagePath!);
      var destination = "images/${user!.uid}/$filename";
      Reference ref = FirebaseStorage.instance.ref().child(destination);
      await ref.putFile(File(imagePath!));
      profileImageLink = await ref.getDownloadURL();
    }
    if (imagePath2 != null) {
      var filename2 = basename(imagePath2!);
      var destination2 = "images/${user!.uid}/$filename2";
      Reference ref2 = FirebaseStorage.instance.ref().child(destination2);
      await ref2.putFile(File(imagePath2!));
      profileImageLink2 = await ref2.getDownloadURL();
    }
    if (imagePath3 != null) {
      var filename3 = basename(imagePath3!);
      var destination3 = "images/${user!.uid}/$filename3";
      Reference ref3 = FirebaseStorage.instance.ref().child(destination3);
      await ref3.putFile(File(imagePath3!));
      profileImageLink3 = await ref3.getDownloadURL();
    }
  }

  updateProfile() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var store = firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    await store.set({
      'momPhoto': profileImageLink,
      'dadphoto': profileImageLink2,
      'siblingPhoto': profileImageLink3,
    }, SetOptions(merge: true));
    // await store.set({'dadphoto': profileImageLink2}, SetOptions(merge: true));
    // await store
    //     .set({'siblingPhoto': profileImageLink3}, SetOptions(merge: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relation'),
        backgroundColor: custom_green,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black)),
                child: imageData != null
                    ? SizedBox(
                        height: 200,
                        width: 200,
                        child: Image.memory(imageData!),
                      )
                    : SizedBox(
                        height: 200,
                        width: 200,
                        child: Image.asset('assets/images/vector-1.png'),
                      ),
              ),
              ElevatedButton(
                  onPressed: () {
                    getImage(ImageSource.gallery, 1);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: custom_green,
                  ),
                  child: const Text('Add Mom Image')),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black)),
                child: imageData2 != null
                    ? SizedBox(
                        height: 200,
                        width: 200,
                        child: Image.memory(imageData2!),
                      )
                    : SizedBox(
                        height: 200,
                        width: 200,
                        child: Image.asset('assets/images/vector-1.png'),
                      ),
              ),
              ElevatedButton(
                  onPressed: () {
                    getImage(ImageSource.gallery, 2);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: custom_green,
                  ),
                  child: const Text('Add Dad Image')),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black)),
                child: imageData3 != null
                    ? SizedBox(
                        height: 200,
                        width: 200,
                        child: Image.memory(imageData3!),
                      )
                    : SizedBox(
                        height: 200,
                        width: 200,
                        child: Image.asset('assets/images/vector-1.png'),
                      ),
              ),
              ElevatedButton(
                  onPressed: () {
                    getImage(ImageSource.gallery, 3);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: custom_green,
                  ),
                  child: const Text('Add Sibling Image')),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  uploadImage1();
                  updateProfile();
                },
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
