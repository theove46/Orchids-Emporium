// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orchids_emporium/core/theme/palette.dart';
import 'package:orchids_emporium/core/typography/style.dart';
import 'package:orchids_emporium/provider/product_provider.dart';
import 'package:provider/provider.dart';

class AttributeTabScreen extends StatefulWidget {
  const AttributeTabScreen({super.key});

  @override
  State<AttributeTabScreen> createState() => _AttributeTabScreenState();
}

class _AttributeTabScreenState extends State<AttributeTabScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final TextEditingController _sizeController = TextEditingController();
  bool _entered = false;
  final List<String> _sizeList = [];
  bool _isSave = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          validator: ((value) {
            if (value!.isEmpty) {
              return 'Enter brand name';
            } else {
              return null;
            }
          }),
          keyboardType: TextInputType.number,
          cursorColor: Palette.greenColor,
          onChanged: (value) {
            _productProvider.getFromData(brandName: value);
          },
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Palette.greenColor),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Palette.greenColor),
            ),
            fillColor: Palette.whiteColor,
            filled: true,
            hintText: 'Brand name',
            hintStyle: GoogleFonts.ubuntu(
              fontSize: 16,
              color: Palette.greyColor,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: SizedBox(
                width: 200,
                child: TextFormField(
                  controller: _sizeController,
                  cursorColor: Palette.greenColor,
                  onChanged: (value) {
                    setState(() {
                      _entered = true;
                    });
                  },
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Palette.greenColor),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Palette.greenColor),
                    ),
                    fillColor: Palette.whiteColor,
                    filled: true,
                    hintText: 'Size',
                    hintStyle: GoogleFonts.ubuntu(
                      fontSize: 16,
                      color: Palette.greyColor,
                    ),
                  ),
                ),
              ),
            ),
            _entered == true
                ? ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _sizeList.add(_sizeController.text);
                        _sizeController.clear();
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
                    child: Text(
                      'Add',
                      style: AppTypography.regular16(
                        color: Palette.whiteColor,
                      ),
                    ),
                  )
                : const Text(' '),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        if (_sizeList.isNotEmpty)
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _sizeList.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.all(2),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _sizeList.removeAt(index);
                        _productProvider.getFromData(sizeList: _sizeList);
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Palette.greenColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          _sizeList[index],
                          style: AppTypography.bold20(
                            color: Palette.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        const SizedBox(
          height: 10,
        ),
        if (_sizeList.isNotEmpty)
          ElevatedButton(
            onPressed: () {
              _productProvider.getFromData(sizeList: _sizeList);
              setState(() {
                _isSave = true;
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
            child: _isSave
                ? Text(
                    'Saved',
                    style: AppTypography.regular16(
                      color: Palette.whiteColor,
                    ),
                  )
                : Text(
                    'Save',
                    style: AppTypography.regular16(
                      color: Palette.whiteColor,
                    ),
                  ),
          ),
      ],
    );
  }
}
