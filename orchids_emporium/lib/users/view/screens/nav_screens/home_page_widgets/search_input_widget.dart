import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orchids_emporium/core/palette.dart';

class SearchInputWidget extends StatelessWidget {
  const SearchInputWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14, right: 14, bottom: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: TextField(
          style: GoogleFonts.ubuntu(
            fontSize: 16,
            color: Palette.greenColor,
          ),
          decoration: InputDecoration(
            fillColor: Palette.greenwhiteColor,
            hintText: 'Search Plants',
            hintStyle: GoogleFonts.ubuntu(
              fontSize: 16,
              color: Palette.greenColor,
            ),
            filled: true,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            suffixIcon: const Icon(
              Icons.search_sharp,
              color: Palette.greenColor,
            ),
          ),
        ),
      ),
    );
  }
}
