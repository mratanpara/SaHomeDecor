import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../components/custom_app_bar.dart';
import '../../../../components/custom_button.dart';
import '../../../../components/custom_rect_button.dart';
import "../../../../constants/customExtension.dart";
import '../../../../constants/params_constants.dart';
import '../../../../providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../components/custom_card_text_field.dart';
import '../../../../utils/methods/validation_methods.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late FocusNode _nameFocus;
  final _currentUser = FirebaseAuth.instance.currentUser;
  final _fireStoreInstance = FirebaseFirestore.instance;
  bool isUpdate = false;
  final _formKey = GlobalKey<FormState>();
  File? file;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _nameFocus = FocusNode();

    _nameController.text = widget.name;
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _nameFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _appBar(context),
      body: _body(size),
    );
  }

  CustomAppBar _appBar(BuildContext context) => CustomAppBar(
        title: 'Edit Profile',
        actionIcon: null,
        leadingIcon: CupertinoIcons.back,
        onActionIconPressed: null,
        onLeadingIconPressed: () => Navigator.pop(context),
      );

  Center _body(Size size) => Center(
        child: Consumer<UserDataProvider>(
          builder: (context, userData, child) => Column(
            children: [
              _userProfilePicture(size, userData),
              _nameTextField(),
              _saveButton(userData, context),
            ],
          ).padAll(),
        ),
      );

  Stack _userProfilePicture(Size size, UserDataProvider userData) => Stack(
        children: [
          file == null
              ? CircleAvatar(
                  radius: size.height * 0.1,
                  backgroundImage: NetworkImage(userData.userPhotoUrl),
                )
              : CircleAvatar(
                  radius: size.height * 0.1,
                  backgroundImage: FileImage(file!),
                ),
          _addProfilePicture()
        ],
      );

  Positioned _addProfilePicture() => Positioned(
        bottom: 8,
        right: 8,
        child: CustomRectButton(
            width: 42,
            height: 42,
            icon: Icons.add_a_photo_outlined,
            onPressed: () => chooseImage(),
            color: Colors.white,
            iconColor: Colors.black),
      );

  Padding _nameTextField() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Form(
          key: _formKey,
          child: CustomCardTextField(
            type: TextInputType.text,
            label: 'Enter Name',
            hintText: 'Ex: John Deo',
            controller: _nameController,
            focusNode: _nameFocus,
            validator: validateFullName,
            onPressed: (t) {
              _nameFocus.unfocus();
            },
          ),
        ),
      );

  CustomButton _saveButton(UserDataProvider userData, BuildContext context) =>
      CustomButton(
        label: 'Save',
        onPressed: () async {
          await updateProfile(userData);
          var docSnapshot = await FirebaseFirestore.instance
              .collection('users')
              .doc(_currentUser!.uid)
              .get();

          userData.updateCurrentUser(docSnapshot);
          Navigator.pop(context);
        },
      );

  updateProfile(UserDataProvider userData) async {
    String url = "";
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          isUpdate = true;
        });
        if (file != null) {
          url = await uploadImage();
        }
        await _fireStoreInstance
            .collection('users')
            .doc(_currentUser?.uid)
            .update({
          paramDisplayName: _nameController.text,
          paramPhotoURL: url.isNotEmpty ? url : userData.userPhotoUrl
        });

        setState(() {
          isUpdate = false;
        });
      } catch (e) {
        setState(() {
          isUpdate = false;
        });
      }
    }
  }

  Future<String> uploadImage() async {
    TaskSnapshot taskSnapshot = await FirebaseStorage.instance
        .ref()
        .child("profilePicture")
        .child(_currentUser!.uid + "_" + basename(file!.path))
        .putFile(file!);

    return taskSnapshot.ref.getDownloadURL();
  }

  chooseImage() async {
    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    file = File(xFile!.path);
    setState(() {});
  }
}
