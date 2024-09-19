// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:astronacci_test_app/domain/entities/user.dart';
import 'package:astronacci_test_app/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../tools.dart';
import '../bloc/auth_bloc/auth_bloc.dart';
import '../widgets/button_widget.dart';
import '../widgets/form_widget.dart';

class EditProfilePage extends StatefulWidget {
  final UserEntity user;
  const EditProfilePage({super.key, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
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
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController.text = widget.user.email ?? '';
    nameController.text = widget.user.name ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.grey.shade700),
      ),
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is UserUpdated) {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            GlobalSnackBar.showSnackBar('Success', 'Success Update User', Duration(seconds: 2));
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .1),
                Center(
                  child: Stack(
                    children: [
                      if (image == null && widget.user.image == null)
                        CircleAvatar(
                          radius: 60,
                          child: Icon(
                            Icons.person,
                            size: 40,
                          ),
                        )
                      else if (image != null || widget.user.image == null)
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: FileImage(File(image!.path)),
                        )
                      else if (widget.user.image!.contains('https'))
                        CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(widget.user.image!),
                          radius: 60,
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
                            GlobalSnackBar.showSnackBar(
                                'Success', 'Success created account', Duration(seconds: 2));
                          }

                          if (state is AuthFailure) {
                            GlobalSnackBar.showSnackBar(
                                'Failed', state.message, Duration(seconds: 2));
                          }
                        },
                        builder: (context, state) {
                          if (state is AuthLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          return CustomFilledButton.text(
                              text: 'UPDATE',
                              textStyle: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                              color: Colors.blue,
                              onPressed: () {
                                final FirebaseAuth auth = FirebaseAuth.instance;
                                final User user = auth.currentUser!;
                                context.read<UserBloc>().add(UserUpdateEvent(
                                      UserEntity(
                                        id: user.uid,
                                        email: emailController.text,
                                        name: nameController.text,
                                        image: image == null ? widget.user.image! : image!.path,
                                      ),
                                    ));
                              });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
