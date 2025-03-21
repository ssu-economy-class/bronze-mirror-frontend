import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

Future<String> uploadImageToFirebase(XFile image) async {
  final fileName = 'uploads/${DateTime.now().millisecondsSinceEpoch}_${image.name}';
  final ref = FirebaseStorage.instance.ref().child(fileName);
  print(ref);

  final uploadTask = await ref.putFile(File(image.path));
  final downloadUrl = await ref.getDownloadURL();
  print('사진 가져오기 성공 ${downloadUrl}');

  return downloadUrl;
}
