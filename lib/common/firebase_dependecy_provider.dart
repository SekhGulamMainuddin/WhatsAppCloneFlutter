import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuth = Provider((ref) => FirebaseAuth.instance);
final firebaseFirestore = Provider((ref) => FirebaseFirestore.instance);
final firebaseStorage = Provider((ref) => FirebaseStorage.instance.ref());
