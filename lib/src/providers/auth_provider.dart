import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/src/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // final FirebaseStorage _storage = FirebaseStorage.instance;

  User? get firebaseUser => _auth.currentUser;

  bool isLoading = false;
  String? error;

  Future<void> login(String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();

      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (_auth.currentUser != null) {
        var user = await _db
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .get();
        logger.d(user.data());
        if (user.exists) {
          var familyId = user.data()!['familyId'];
          logger.d('Family ID :$familyId');
          try {
            var family = await _db.collection('family').doc(familyId).get();
            logger.d(family.data());
          } on Exception catch (e) {
            logger.e(e);
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      error = e.message;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logOut() async {
    try {
      isLoading = true;
      notifyListeners();

      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      error = e.message;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signup({
    required String email,
    required String password,
    required String displayName,
    required String role,
    // File? imageFile, // ✅ logo
    String? familyId,
    String? invitedBy,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      // 1️⃣ Create Auth User
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = credential.user!.uid;

      // String? photoURL;

      // 2️⃣ Upload image (if selected)
      // if (imageFile != null) {
      //   final ref = _storage.ref().child('user_profiles/$uid.jpg');

      // await ref.putFile(imageFile);
      // photoURL = await ref.getDownloadURL();

      // Update Firebase Auth profile
      // await credential.user!.updatePhotoURL(photoURL);
      // }

      // Update display name
      await credential.user!.updateDisplayName(displayName);

      // 3️⃣ Create AppUser model
      final appUser = UserModel(
        id: uid,
        email: email,
        displayName: displayName,
        // photoURL: photoURL,
        role: role,
        familyId: familyId,
        createdAt: DateTime.now(),
        invitedBy: invitedBy,
      );

      // 4️⃣ Save to Firestore
      await _db.collection('users').doc(uid).set(appUser.toMap());

      await _db.collection('family').doc(familyId).update({
        'Members': FieldValue.arrayUnion([uid]),
      });
    } on FirebaseAuthException catch (e) {
      error = e.message;
    } catch (e) {
      error = "Upload failed";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
