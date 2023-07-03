// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orchids_emporium/core/custom_textstyle.dart';
import 'package:orchids_emporium/core/palette.dart';
import 'package:orchids_emporium/provider/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ImagesTabScreen extends StatefulWidget {
  const ImagesTabScreen({super.key});

  @override
  State<ImagesTabScreen> createState() => _ImagesTabScreenState();
}

class _ImagesTabScreenState extends State<ImagesTabScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final ImagePicker picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  final List<File> _image = [];
  final List<String> _imageUrlList = [];

  chooseImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
    } else {
      setState(
        () {
          _image.add(File(pickedFile.path));
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            itemCount: _image.length + 1,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 3 / 3,
            ),
            itemBuilder: ((context, index) {
              return index == 0
                  ? IconButton(
                      onPressed: () {
                        chooseImage();
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Palette.greenColor,
                        size: 32,
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(
                            _image[index - 1],
                          ),
                        ),
                      ),
                    );
            }),
          ),
          const SizedBox(
            height: 30,
          ),
          if (_image.isNotEmpty)
            ElevatedButton(
              onPressed: () async {
                EasyLoading.show(status: 'Saving images');
                for (var img in _image) {
                  Reference ref = _storage
                      .ref()
                      .child('productImage')
                      .child(const Uuid().v4());
                  await ref.putFile(img).whenComplete(() async {
                    await ref.getDownloadURL().then((value) {
                      setState(() {
                        _imageUrlList.add(value);
                      });
                    });
                  });
                }
                setState(() {
                  _productProvider.getFromData(imageUrlList: _imageUrlList);
                  EasyLoading.dismiss();
                });
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Palette.greenColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              child: const CustomTextStyle(
                text: 'Upload',
                color: Palette.whiteColor,
              ),
            ),
        ],
      ),
    );
  }
}
