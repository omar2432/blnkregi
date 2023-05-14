import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';


class Idupload{

  static void uploadpics(String mobile,File id_front,File id_back) async{
    await Firebase.initializeApp();

final reff = FirebaseStorage.instance
            .ref()
            .child('user_id_image')
            .child(mobile+ '_front.jpg');

        await reff.putFile(id_front);

        final refb = FirebaseStorage.instance
            .ref()
            .child('user_id_image')
            .child(mobile+ '_back.jpg');

        await refb.putFile(id_back);

  }}