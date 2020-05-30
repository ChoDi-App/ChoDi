import 'dart:ui';

import 'package:chodiapp/constants/constants.dart';
import 'package:chodiapp/models/user.dart';
import 'package:chodiapp/screens/authenticate/multi_step_sign_up_page.dart';
import 'package:chodiapp/screens/home/avatar.dart';
import 'package:chodiapp/services/firebase_storage_service.dart';
import 'package:chodiapp/services/firestore.dart';
import 'package:chodiapp/services/image_picker_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:bordered_text/bordered_text.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final _formKey = GlobalKey<FormState>();
  List<String> resourcesOptions = [
    "time",
    "money",
    "resources",
  ];
  List<String> interestsOptions = [
    "human-rights",
    "policy",
    "environment",
    "animals"
  ];
  Map<String, Color> donationsColorsMap = {
    "time": Color.fromRGBO(0, 26, 255, .63),
    "money": Color.fromRGBO(255, 255, 0, 1.0),
    "resources": Color.fromRGBO(74, 201, 19, 1.0),
  };
  Map<String, Color> interestsColorsMap = {
    "human-rights": Color.fromRGBO(0, 26, 255, .63),
    "policy": Color.fromRGBO(255, 255, 0, 1.0),
    "environment": Color.fromRGBO(74, 201, 19, 1.0),
    "animals": Color.fromRGBO(242, 122, 84, 1.0)
  };

  List<String> listOfAgeRange = [
    "Under 18",
    "18-24",
    "25-34",
    "35-44",
    "45-54",
    "55-64",
    "65 or older"
  ];
  UserData updatedUserData = UserData();

  Future<void> _chooseAvatar(BuildContext context) async {
    try {
      // 1. Get image from picker
      final imagePicker =
      Provider.of<ImagePickerService>(context, listen: false);
      final file = await imagePicker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        // 2. Upload to storage
        final storage =
        Provider.of<FirebaseStorageService>(context, listen: false);
        final downloadUrl = await storage.uploadAvatar(file: file);
        // 3. Save url to Firestore
        final userData = Provider.of<UserData>(context,listen: false);
        //UserData newUserData = UserData(avatarDownloadUrl: downloadUrl);
        await FirestoreService(uid: userData.userId).setAvatarReference(downloadUrl);
        // 4. (optional) delete local file as no longer needed
        await file.delete();
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    UserData userData = Provider.of<UserData>(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(deviceHeight / 3),
          child: AppBar(
            elevation: 10,
            flexibleSpace: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  children: [
                    Expanded(
                      child: Opacity(
                        opacity: .5,
                        child: Image(
                          fit: BoxFit.cover,
                          image: AssetImage("images/profileBackground.png"),
                        ),
                      ),
                    ),
                  ],
                ),
                SafeArea(
                  child: Column(
                    children: [
                      RichText(
                          text: new TextSpan(
                              style: new TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800, letterSpacing: 1.0),
                              children: <TextSpan>[
                                new TextSpan(text: "C", style: new TextStyle(color: Colors.yellow)),
                                new TextSpan(text: "H", style: new TextStyle(color: Colors.orange)),
                                new TextSpan(text: "O", style: new TextStyle(color: Colors.red)),
                                new TextSpan(text: "D", style: new TextStyle(color: Colors.blue)),
                                new TextSpan(text: "I", style: new TextStyle(color: Colors.green)),
                              ]
                          )
                      ),
                      SizedBox(height: 30,),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Avatar(
                            photoUrl: userData?.avatarDownloadUrl,
                            radius: 60,
                            borderColor: Colors.black54,
                            borderWidth: 2.0,
                            onPressed: () {},
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.redAccent,
                            child: IconButton(
                              icon: Icon(Icons.camera_enhance, color: Colors.white, size: 20,),
                              onPressed: () => _chooseAvatar(context),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 8,),
                      BorderedText(
                        strokeWidth: 2.0,
                        strokeColor: Colors.white,
                        child: Text(
                          userData.name,
                          style: GoogleFonts.ubuntu(
                              fontSize: 22, fontWeight: FontWeight.w500, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.white10,
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Personal Information",
                    style: GoogleFonts.ubuntu(
                        fontSize: 22, fontWeight: FontWeight.w100, color: Colors.black),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    "Name",
                    style: GoogleFonts.ubuntu(
                        fontSize: 17, fontWeight: FontWeight.w100, color: Colors.black),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: userData.name),
                    onChanged: (val) {
                      setState(() {
                        updatedUserData.name = val;
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    "Phone Number",
                    style: GoogleFonts.ubuntu(
                        fontSize: 17, fontWeight: FontWeight.w100, color: Colors.black),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: userData.phoneNumber),
                    onChanged: (val) {
                      setState(() {
                        updatedUserData.name = val;
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    "Zip Code",
                    style: GoogleFonts.ubuntu(
                        fontSize: 17, fontWeight: FontWeight.w100, color: Colors.black),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: userData.zipCode),
                    onChanged: (val) {
                      setState(() {
                        updatedUserData.name = val;
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    "Age Range",
                    style: GoogleFonts.ubuntu(
                        fontSize: 17, fontWeight: FontWeight.w100, color: Colors.black),
                  ),
                  DropdownButton(
                    hint: Text("Please Choose Age Range"),
                    value: userData.ageRange,
                    onChanged: (newValue) {
                      setState(() {
                        updatedUserData.ageRange = newValue;
                      });
                    },
                    items: listOfAgeRange.map((ageRange) {
                      return DropdownMenuItem(
                        child: new Text(ageRange),
                        value: ageRange,
                      );
                    }).toList(),
                  ),
                  Divider(
                    thickness: 1.0,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    "Change Resources",
                    style: GoogleFonts.ubuntu(
                        fontSize: 17, fontWeight: FontWeight.w100, color: Colors.black),
                  ),
                  SizedBox(height: 20.0),
                  GridView.count(
                    physics: ScrollPhysics(),
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    childAspectRatio: 1.0,
                    padding: EdgeInsets.only(right: 30, left: 30),
                    mainAxisSpacing: 8,
                    children: resourcesOptions.map((imageName) {
                      return GestureDetector(
                        onTap: () {
                          if (userData.userResources.contains(
                              imageName)) {
                            setState(() {
                              userData.userResources.remove(
                                  imageName);
                            });
                          }
                          else if (!userData.userResources.contains(
                              imageName)) {
                            setState(() {
                              userData.userResources.add(imageName);
                            });
                          }
                          print(userData.userResources);
                        },
                        child: GridViewItem(imageName,
                            userData.userResources.contains(
                                imageName),
                            donationsColorsMap[imageName]),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20.0),
                  Divider(
                    thickness: 1.0,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    "Change Interests",
                    style: GoogleFonts.ubuntu(
                        fontSize: 17, fontWeight: FontWeight.w100, color: Colors.black),
                  ),
                  SizedBox(height: 20.0),
                  GridView.count(
                    physics: ScrollPhysics(),
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    childAspectRatio: 1.0,
                    padding: EdgeInsets.only(right: 30, left: 30),
                    mainAxisSpacing: 8,
                    children: interestsOptions.map((imageName) {
                      return GestureDetector(
                        onTap: () {
                          if (userData.userInterest.contains(
                              imageName)) {
                            setState(() {
                              userData.userInterest.remove(imageName);
                            });
                          }
                          else if (!userData.userInterest.contains(
                              imageName)) {
                            setState(() {
                              userData.userInterest.add(imageName);
                            });
                          }
                        },
                        child: GridViewItem(imageName,
                            userData.userInterest.contains(imageName),
                            interestsColorsMap[imageName]),
                      );
                    }).toList(),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
