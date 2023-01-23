import 'dart:io';
import 'package:doctors_app/models/doctors_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:doctors_app/common/utils/utils.dart';
import 'package:doctors_app/features/authentication/controller/auth_controller.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  static const routeName = '/edit-profile-screen';
  const EditProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController specController = TextEditingController();
  File? image;
  Doctor doctor = Doctor(
    name: '',
    uid: '',
    profilePic:
        'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png',
    spec: '',
    enrolled: 0,
  );

  @override
  void initState() {
    super.initState();
  }

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  @override
  void dispose() {
    specController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void updateUserData() {
    if (nameController.text.isEmpty || specController.text.isEmpty) {
      return;
    }
    ref.read(authControllerProvider).updateUserDataEveryWhere(
        context,
        specController.text.trim(),
        doctor.profilePic,
        nameController.text.trim(),
        image);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: ref.read(authControllerProvider).getCurrentUserData(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                doctor = snapshot.data!;
                specController.text = doctor.spec;
                nameController.text = doctor.name;
              }
              return Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        image == null
                            ? CircleAvatar(
                                backgroundImage:
                                    NetworkImage(doctor.profilePic),
                                radius: 64,
                              )
                            : CircleAvatar(
                                backgroundImage: FileImage(
                                  image!,
                                ),
                                radius: 64,
                              ),
                        Positioned(
                          bottom: -10,
                          left: 80,
                          child: IconButton(
                            onPressed: selectImage,
                            icon: const Icon(
                              Icons.add_a_photo,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        controller: specController,
                        decoration: const InputDecoration(
                          hintText: 'spec',
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: size.width * 0.85,
                          padding: const EdgeInsets.all(20),
                          child: TextField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              hintText: 'Enter your name',
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: updateUserData,
                          icon: const Icon(
                            Icons.done,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
