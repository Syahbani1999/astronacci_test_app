// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:astronacci_test_app/domain/entities/user.dart';
import 'package:astronacci_test_app/tools.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/auth_bloc/auth_bloc.dart';
import '../widgets/button_widget.dart';
import '../widgets/form_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final imagePicker = ImagePicker();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  XFile? image;

  Future imagePick(
    ImageSource source,
  ) async {
    try {
      final _image = await imagePicker.pickImage(source: source, imageQuality: 40);
      if (_image == null) return;
      var imageTemp = _image;
      final dataImage = await _cropImage(imageTemp);
      image = dataImage;
      setState(() {});
    } on PlatformException catch (e) {
      printConsole('error pick image: $e');
    }
  }

  Future<XFile> _cropImage(XFile pickedImage) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedImage.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: false,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio4x3,
          ],
        ),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio4x3,
          ],
        ),
        WebUiSettings(
          context: context,
          presentStyle: WebPresentStyle.dialog,
          size: const CropperSize(
            width: 520,
            height: 520,
          ),
        ),
      ],
    );
    return XFile(croppedFile!.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .1),
              Text('Join Us to Unlock\nYour Growth',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Stack(
                  children: [
                    if (image == null)
                      CircleAvatar(
                        radius: 60,
                        child: Icon(
                          Icons.person,
                          size: 40,
                        ),
                      )
                    else if (image != null)
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: FileImage(File(image!.path)),
                      ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey.shade300,
                        radius: 21,
                        child: CircleAvatar(
                          radius: 20,
                          child: IconButton(
                            iconSize: 20,
                            icon: const Icon(Icons.add_a_photo_rounded),
                            onPressed: () {
                              showImageSource(context);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomFormField(
                      title: 'Email',
                      controller: emailController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomFormField(
                      title: 'Password',
                      obscureText: true,
                      controller: passwordController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomFormField(
                      title: 'Name',
                      controller: nameController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthSuccessRegister) {
                          Navigator.of(context).pop();
                          GlobalSnackBar.showSnackBar('Success', 'Success created account', Duration(seconds: 2));
                        }

                        if (state is AuthFailure) {
                          GlobalSnackBar.showSnackBar('Failed', state.message, Duration(seconds: 2));
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return CustomFilledButton.text(
                            text: 'REGISTER',
                            textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                            color: Colors.blue,
                            onPressed: () {
                              context.read<AuthBloc>().add(SignUpEvent(UserEntity(
                                  email: emailController.text,
                                  name: nameController.text,
                                  password: hashPassword(passwordController.text),
                                  image: image!.path)));
                            });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Already have account',
                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future<ImageSource?> showImageSource(BuildContext context) async {
    return showModalBottomSheet(
        context: context,
        builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt_rounded),
                  title: const Text('Camera'),
                  onTap: () {
                    imagePick(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.image),
                  title: const Text('Gallery'),
                  onTap: () {
                    imagePick(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }
}
