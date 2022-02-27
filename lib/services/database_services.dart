import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final categories = FirebaseFirestore.instance.collection('categories');
}
