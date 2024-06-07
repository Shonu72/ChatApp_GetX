import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUser {
  final String uid;
  final String email;
  final String? displayName;

  FirebaseUser({required this.uid, required this.email, this.displayName});

  factory FirebaseUser.fromFirebaseUser(User user) => FirebaseUser(
        uid: user.uid,
        email: user.email!,
        displayName: user.displayName,
      );
}
