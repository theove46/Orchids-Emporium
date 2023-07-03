import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:orchids_emporium_web_admin/core/custom_textstyle.dart';
import 'package:orchids_emporium_web_admin/core/palette.dart';
import 'package:orchids_emporium_web_admin/views/screens/side_bar_screens/widgets/banner_widget.dart';

class UploadBanner extends StatefulWidget {
  static const String routeName = '\BannerScreen';

  @override
  State<UploadBanner> createState() => _UploadBannerState();
}

class _UploadBannerState extends State<UploadBanner> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  dynamic _image;
  String? fileName;

  pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        _image = result.files.first.bytes;
        fileName = result.files.first.name;
      });
    }
  }

  _uploadBannerToStorage(dynamic imgage) async {
    Reference ref = _storage.ref().child('Banners').child(fileName!);
    UploadTask uploadTask = ref.putData(imgage);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  uploadToFireStore() async {
    EasyLoading.show(status: 'uploading...');
    if (_image != null) {
      String imageUrl = await _uploadBannerToStorage(_image);
      await _firestore.collection('banners').doc(fileName).set({
        'image': imageUrl,
      }).whenComplete(() {
        EasyLoading.dismiss();
        setState(() {
          _image = null;
          fileName = null;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: CustomTextStyle(
                text: 'Upload Banner',
                size: 36,
                fontWeight: FontWeight.bold,
                color: Palette.greenColor,
              ),
            ),
            Divider(
              color: Palette.greenColor,
            ),
            GestureDetector(
              onTap: () {
                pickImage();
              },
              child: Container(
                height: 140,
                width: 240,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Palette.whiteColor,
                  border: Border.all(
                    color: Palette.greenColor,
                    width: 2,
                  ),
                ),
                child: _image != null
                    ? Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.memory(
                            _image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Center(
                        child: CustomTextStyle(
                          text: 'upload a new banner image',
                          size: 14,
                          color: Palette.greenColor,
                        ),
                      ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              width: 240,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Palette.whiteColor,
                border: Border.all(
                  color: Palette.whiteColor,
                  width: 2,
                ),
              ),
              child: fileName != null
                  ? CustomTextStyle(
                      text: '${fileName}',
                      size: 10,
                      color: Palette.greenColor,
                    )
                  : Center(
                      child: CustomTextStyle(
                        text: '',
                        size: 10,
                        color: Palette.greenColor,
                      ),
                    ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_image != null) {
                  uploadToFireStore();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Palette.greenColor,
              ),
              child: CustomTextStyle(
                text: 'Save Banner',
                size: 14,
                color: Palette.whiteColor,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: Palette.greenColor,
            ),
            Container(
              child: CustomTextStyle(
                text: 'Banners',
                size: 36,
                fontWeight: FontWeight.bold,
                color: Palette.greenColor,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            BannerWidget(),
          ],
        ),
      ),
    );
  }
}
