import 'package:edge_detection/edge_detection.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../models/user.dart';
import '../models/sheets.dart';

class RegScreen extends StatefulWidget {
  const RegScreen({super.key});

  @override
  State<RegScreen> createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  var _editedUser = User(
    firstName: '',
    lastName: '',
    address: '',
    area: '',
    landline: '',
    mobile: '',
    idFront: '',
    idBack: '',
  );

  final List<String> Areas = ['Cairo', 'Giza', 'Alexandria'];
  String? selectedArea;

  final _form = GlobalKey<FormState>();

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

  void _saveForm() {
    bool isvalid=_form.currentState!.validate();
    if(id_front!=null&&id_back!=null){
    if(isvalid){
    _form.currentState!.save();
    _editedUser.idFront=id_front!.path;
    _editedUser.idBack=id_back!.path;   

    // Send the users data to the Google sheet
     Sheets.initSheets(_editedUser);
     
    
    }
    }else{
      ScaffoldMessenger.of(this.context).showSnackBar(const SnackBar(
      content: Text("You must take a picture of both the front and the back of the ID"),
    ));
    }

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BLNK Registration Form"),
        actions: <Widget>[
          IconButton(onPressed: _saveForm, icon: Icon(Icons.save)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
            key: _form,
            child: SingleChildScrollView(
              child: Column(children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: "First name"),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if(value!.isEmpty){
                      return "First name cannot be empty";
                    }else if(value.length<3){
                      return "First name cannot be less than 3 characters";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedUser.firstName = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Last name"),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if(value!.isEmpty){
                      return "Last name cannot be empty";
                    }else if(value.length<3){
                      return "Last name cannot be less than 3 characters";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedUser.lastName = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Address"),
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  validator: (value) {
                    if(value!.isEmpty){
                      return "Address cannot be empty";
                    }else if(value.length<10){
                      return "Address is too short";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedUser.address = value;
                  },
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
                  validator:(value) {
                    if(value==null){
                      return "Area cannot be empty";
                    }
                    if(value.isEmpty){
                      return "Area cannot be empty";
                    }
                    return null;
                  } ,
                  onSaved: (value) {
                    _editedUser.area = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Landline"),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if(value!.isEmpty){
                      return "Landline cannot be empty";
                    }else if(value.length<10){                      
                      return "Landline is too short";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedUser.landline = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Mobile"),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if(value!.isEmpty){
                      return "Mobile number cannot be empty";
                    }else if(value.length<11){                      
                      return "Mobile number is too short";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedUser.mobile = value;
                  },
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
