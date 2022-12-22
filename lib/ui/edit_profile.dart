import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nov_02/models/productModel.dart';
import 'package:nov_02/ui/profile.dart';
import 'package:nov_02/widgets/bottomnav.dart';
import 'package:nov_02/widgets/reusable_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class EditProfile extends StatefulWidget {
   EditProfile({Key? key,
    this.email,
     this.password,
   }) : super(key: key);
  String? email;
  String? password;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  final key = GlobalKey<FormState>();
  // var categoryC = TextEditingController();
  var nameC = TextEditingController();
  var phoneC = TextEditingController();
  // var emailC = TextEditingController();
  var roleC = TextEditingController();
  var address = TextEditingController();
  var uid = '';
  var uemail = '';
  // var cat = 'Men';
  File _imageFile = File('');
  String _path = '';
  editProfile(){
    bool validate = key.currentState!.validate();
    if(validate){
      if (_path == ''){
        Fluttertoast.showToast(
            msg: "Please Select the image first",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );
        // print('$nameC $categoryC $priceC, $materialC, $descipC, $descountC');
      }else{
        _uploadImage(_path, _imageFile);
        Fluttertoast.showToast(
            msg: "Saving Changes Please Wait.....",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }

    }
  }

  @override
  void initState() {
    super.initState();
    getUserId();

  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    ProfileModel profileModel;
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: key,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60.0),
                      child: Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: 82,
                            child: CircleAvatar(
                              backgroundColor: Colors.grey,
                              backgroundImage: _path != ''?
                              FileImage(_imageFile):
                              const AssetImage('assets/images/avataer.jpg') as ImageProvider,
                              radius: 80,
                            ),
                          ),
                          Positioned(
                              top: 110.0, left: 120,
                              child: InkWell(
                                onTap: () async{
                                  Get.defaultDialog(
                                      title: 'Select Picture from:',
                                      content: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            InkWell(
                                              onTap:(){
                                                Get.back();
                                                selectImageFromCamera();
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black,width: 1),
                                                    borderRadius:const BorderRadius.all(Radius.circular(10))
                                                ),
                                                height:50,
                                                child:const Center(
                                                  child: Text('Camera'),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10,),
                                            InkWell(
                                              onTap:(){
                                                Get.back();
                                                selectImageFromGallery();

                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black,width: 1),
                                                    borderRadius:const BorderRadius.all(Radius.circular(10))
                                                ),
                                                height:50,
                                                child:const Center(
                                                  child: Text('Gallery'),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      radius: 10.0);

                                },
                                child: const CircleAvatar(
                                  child: Icon(Icons.add,color: Colors.white,),
                                ),
                              )
                          )
                        ],
                      ),
                      // ClipRRect(
                      //   borderRadius: BorderRadius.circular(120),
                      //   child: Container(
                      //       width: double.infinity,
                      //       height: 200,
                      //       decoration: BoxDecoration(
                      //           color: Colors.black.withOpacity(0.9),
                      //           borderRadius: BorderRadius.circular(120)
                      //       ),
                      //       child: Container(
                      //         alignment: Alignment.center,
                      //         width: 50,
                      //         height: 70,
                      //         child: IconButton(
                      //           onPressed: (){},
                      //           icon: Icon(Icons.add_a_photo, color: Colors.white,),
                      //         ),
                      //       )
                      //   ),
                      // ),
                    ),
                    SizedBox(
                      height: 5,
                    ),

                    // NewTextField(labelText: "Product Name", controller: nameC, validator: (value) {if(value.isEmpty){
                    //   return "Must Not Be Empty";
                    // } return null;
                    //   },
                    // ),
                    TextFormField(
                      controller: nameC,
                      validator: (v){
                        if (v!.isEmpty){
                          return "Field Must Not be Empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Name",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.black), //<-- SEE HERE
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.black), //<-- SEE HERE
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.black), //<-- SEE HERE
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: phoneC,
                      validator: (v){
                        if (v!.isEmpty){
                          return "Field Must Not be Empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Phone",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: address,
                      validator: (v){
                        if (v!.isEmpty){
                          return "Field Must Not be Empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Address",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.black), //<-- SEE HERE
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.black), //<-- SEE HERE
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.black), //<-- SEE HERE
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ReusablePrimaryButton(buttonText: "Save Changes", onTap: (){
                      editProfile();
                      Fluttertoast.showToast(
                          msg: "Changes Saved Successfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 3,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                      Get.off(HomePage());

                    },)
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
  void selectImageFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
      _path = pickedFile.path.split('/').last;
    }
    setState(() {});
  }
  selectImageFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
      _path = pickedFile.path.split('/').last;
    }
  }
  void _uploadImage(String path, File imageFile) async{
    final ref = FirebaseStorage.instance.ref('profileImage')
        .child(path);
    await ref.putFile(imageFile);
    final uri = await ref.getDownloadURL();
    postProductToFireStore(uri);
  }

  void postProductToFireStore(String uri)async {
    // var uuid = const Uuid();
    // String id = uuid.v4();
    FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
    ProfileModel profileModel = ProfileModel();
    profileModel.profileId = uid;
    profileModel.name = nameC.text;
    // profileModel.role = roleC.;
    profileModel.phone = phoneC.text;
    profileModel.email = uemail;
    profileModel.address = address.text;
    profileModel.profileImage = uri;
    await firebaseFireStore
        .collection('users')
        .doc(uid)
        .set(profileModel.toMap()).catchError((onError){
      print(onError);
    });
  }

  void getUserId() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = prefs.getString('uid')!;
    uemail = prefs.getString('email')!;
    setState(() {});
  }

}

