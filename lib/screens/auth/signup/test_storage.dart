import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class TestStorage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Firebase Storage'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _uploadFile,
          child: Text('Upload Test File'),
        ),
      ),
    );
  }

  Future<void> _uploadFile() async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child('test.txt');
      await storageRef.putString('This is a test file');
      final downloadUrl = await storageRef.getDownloadURL();
      print('Test file uploaded successfully: $downloadUrl');
    } catch (e) {
      print('Error during file upload: $e');
    }
  }
}
