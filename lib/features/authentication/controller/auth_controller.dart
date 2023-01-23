import 'dart:io';

import 'package:doctors_app/models/doctors_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:doctors_app/features/authentication/repository/auth_repository.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return Authcontroller(authRepository, ref);
});

final userDataProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.getCurrentUserData();
});

class Authcontroller {
  final AuthRepository authRepository;
  final ProviderRef ref;
  Authcontroller(this.authRepository, this.ref);

  Stream<Doctor> getUserDoctorData() {
    return authRepository.getUserDoctorData();
  }

  Future<Doctor?> getCurrentUserData() {
    return authRepository.getCurrentUserData();
  }

  void signUpWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) {
    authRepository.signUpWithEmail(
        email: email, password: password, context: context);
  }

  void loginWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) {
    authRepository.loginWithEmail(
        context: context, email: email, password: password);
  }

  void signOut() {
    authRepository.signOut();
  }

  void saveUserDataToFirebase(
      BuildContext context, String spec, String name, File? profilePic) {
    authRepository.saveUserDataToFirebase(
        name: name,
        spec: spec,
        profilePic: profilePic,
        ref: ref,
        context: context);
  }

  void updateUserDataEveryWhere(BuildContext context, String spec,
      String photoUrl, String name, File? profilePic) {
    authRepository.updateUserDataEveryWhere(
        name: name,
        spec: spec,
        photoUrl: photoUrl,
        profilePic: profilePic,
        ref: ref,
        context: context);
  }
}
