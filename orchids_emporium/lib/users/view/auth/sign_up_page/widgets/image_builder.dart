part of '../pages/user_sign_up_page.dart';

class ImageBuilder extends StatefulWidget {
  final Uint8List? image;
  final Function(Uint8List?) onImageChanged;

  const ImageBuilder({
    super.key,
    required this.image,
    required this.onImageChanged,
  });

  @override
  State<ImageBuilder> createState() => _ImageBuilderState();
}

class _ImageBuilderState extends State<ImageBuilder> {
  final UserAuthController _userAuthController = UserAuthController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.image != null
            ? CircleAvatar(
                radius: 50,
                backgroundColor: Palette.greenColor,
                backgroundImage: MemoryImage(widget.image!),
              )
            : const CircleAvatar(
                radius: 50,
                backgroundColor: Palette.greenColor,
                backgroundImage: AssetImage(
                  'assets/images/profile_icon.png',
                ),
              ),
        Positioned(
          right: -10,
          top: -10,
          child: IconButton(
            onPressed: () {
              selectGalleryImage();
            },
            icon: const Icon(
              CupertinoIcons.add_circled,
              color: Palette.whiteColor,
            ),
          ),
        )
      ],
    );
  }

  selectGalleryImage() async {
    Uint8List img = await _userAuthController.pickProfileImage(
      ImageSource.gallery,
    );

    widget.onImageChanged(img);
  }

  selectCameraImage() async {
    Uint8List img = await _userAuthController.pickProfileImage(
      ImageSource.camera,
    );

    widget.onImageChanged(img);
  }
}
