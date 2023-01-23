// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_app/features/chat/screens/patients_list_screen.dart';
import 'package:doctors_app/models/doctors_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:doctors_app/common/repository/common_firebase_storage.dart';
import 'package:doctors_app/common/utils/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:doctors_app/features/authentication/screens/user_information_screen.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(FirebaseAuth.instance, FirebaseFirestore.instance),
);

class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore firestore;

  AuthRepository(this._auth, this.firestore);

  Future<Doctor?> getCurrentUserData() async {
    Doctor? userData;
    var data =
        await firestore.collection('doctors').doc(_auth.currentUser?.uid).get();
    if (!data.exists || data.data() == null) {
      return null;
    }
    userData = Doctor.fromMap(data.data()!);
    return userData;
  }

  Stream<Doctor> getUserDoctorData() {
    final uid = _auth.currentUser!.uid;
    return firestore.collection('doctors').doc(uid).snapshots().asyncMap(
      (event) {
        return Doctor.fromMap(event.data()!);
      },
    );
  }

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.of(context)
          .pushReplacementNamed(UserInformationScreen.routeName);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, error: e.message!);
    }
  }

  Future<void> loginWithEmail(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (_auth.currentUser!.emailVerified) {
        showSnackBar(context: context, error: 'email verification failed');
      }
      Navigator.of(context).pushNamedAndRemoveUntil(
          PatientsListScreen.routeName, (route) => false);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, error: e.message!);
    }
  }

  void signOut() {
    _auth.signOut();
  }

  void updateUserDataEveryWhere({
    required String spec,
    required String name,
    required File? profilePic,
    required String photoUrl,
    required ProviderRef ref,
    required BuildContext context,
  }) async {
    try {
      String uid = _auth.currentUser!.uid;
      String photoUrl =
          'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png';

      if (profilePic != null) {
        photoUrl = await ref
            .read(commonFirebaseRepositoryProvider)
            .saveFileToFirebase('doctors/profilePic/$uid', profilePic);
      }

      var map = {
        'name': name,
        'profilePic': photoUrl,
        'spec': spec,
      };

      await firestore
          .collection('doctors')
          .doc(uid)
          .set(map, SetOptions(merge: true));

      List<String> patientId = [];
      await firestore.collection('doctors/$uid/patients').get().then((value) {
        for (var document in value.docs) {
          patientId.add(document.id);
        }
      });

      for (var id in patientId) {
        await firestore
            .collection('patients/$id/regDoctors')
            .doc(uid)
            .set(map, SetOptions(merge: true));
      }
    } catch (e) {
      showSnackBar(context: context, error: e.toString());
    }
  }

  void saveUserDataToFirebase({
    required String spec,
    required String name,
    required File? profilePic,
    required ProviderRef ref,
    required BuildContext context,
  }) async {
    try {
      String uid = _auth.currentUser!.uid;
      String photoUrl =
          'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png';

      if (profilePic != null) {
        photoUrl = await ref
            .read(commonFirebaseRepositoryProvider)
            .saveFileToFirebase('doctors/profilePic/$uid', profilePic);
      }

      var user = Doctor(
        name: name,
        uid: uid,
        profilePic: photoUrl,
        spec: spec,
        enrolled: 0,
      );

      await firestore.collection('doctors').doc(uid).set(user.toMap());
    } catch (e) {
      showSnackBar(context: context, error: e.toString());
    }
  }
}
