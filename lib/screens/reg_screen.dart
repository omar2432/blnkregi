import 'package:edge_detection/edge_detection.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class RegScreen extends StatefulWidget {
  const RegScreen({super.key});

  @override
  State<RegScreen> createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  final List<String> Areas = ['Cairo', 'Giza', 'Alexandria'];
  String? selectedArea;

  File? id_front;
  File? id_back;

  Future<void> takePictureFront() async {
    String imagePath = join((await getApplicationSupportDirectory()).path,
        "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");
    bool success = await EdgeDetection.detectEdge(
      imagePath,
      canUseGallery: true,
      androidScanTitle: 'Scanning', // use custom localizations for android
      androidCropTitle: 'Crop',
      androidCropBlackWhiteTitle: 'Black White',
      androidCropReset: 'Reset',
    );


    setState(() {      
      id_front = File(imagePath);
    });
  }

  Future<void> takePictureBack() async {
    String imagePath = join((await getApplicationSupportDirectory()).path,
        "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");
    bool success = await EdgeDetection.detectEdge(
      imagePath,
      canUseGallery: true,
      androidScanTitle: 'Scanning', // use custom localizations for android
      androidCropTitle: 'Crop',
      androidCropBlackWhiteTitle: 'Black White',
      androidCropReset: 'Reset',
    );


    setState(() {      
      id_back = File(imagePath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BLNK Registration Form"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
            child: SingleChildScrollView(
          child: Column(children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: "First name"),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Last name"),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Address"),
              keyboardType: TextInputType.multiline,
              maxLines: 3,
            ),
            DropdownButtonFormField(
              decoration: InputDecoration(labelText: "Select an Area"),
              value: selectedArea,
              items: Areas.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedArea = newValue;
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Landline"),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Mobile"),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
            ),
            SizedBox(
              height: 15,
            ),
            Row(children: <Widget>[
              Container(
                width: 150,
                height: 100,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey)),
                alignment: Alignment.center,
                child: id_front != null
                    ? Image.file(
                        id_front!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )
                    : Text(
                        "Image of front ID",
                        textAlign: TextAlign.center,
                      ),
              ),
              SizedBox(
                width: 15,
              ),
              IconButton(
                  onPressed: takePictureFront,
                  icon: Icon(Icons.camera_alt_outlined)),
              //FloatingActionButton(onPressed: () {})
            ]),
            SizedBox(
              height: 15,
            ),
            Row(children: <Widget>[
              Container(
                width: 150,
                height: 100,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey)),
                alignment: Alignment.center,
                child: id_back != null
                    ? Image.file(
                        id_back!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )
                    : Text(
                        "Image of Back ID",
                        textAlign: TextAlign.center,
                      ),
              ),
              SizedBox(
                width: 15,
              ),
              IconButton(
                  onPressed: takePictureBack,
                  icon: Icon(Icons.camera_alt_outlined)),
            ]),
          ]),
        )),
      ),
    );
  }
}
