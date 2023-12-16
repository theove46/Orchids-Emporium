import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orchids_emporium/core/theme/palette.dart';
import 'package:orchids_emporium/core/typography/fonts.dart';

class AppTypography {
  static TextStyle _getTextStyle(
    double fontSize,
    FontWeight fontWeight,
    Color color,
  ) {
    return GoogleFonts.ubuntu(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle regular8({Color? color}) {
    return _getTextStyle(
      FontSize.s8,
      FontWeightManager.regular,
      color ?? Palette.primary,
    );
  }

  static TextStyle regular10({Color? color}) {
    return _getTextStyle(
      FontSize.s10,
      FontWeightManager.regular,
      color ?? Palette.primary,
    );
  }

  static TextStyle light12({Color? color}) {
    return _getTextStyle(
      FontSize.s12.sp,
      FontWeightManager.light,
      color ?? Palette.primary,
    );
  }

  static TextStyle regular12({Color? color}) {
    return _getTextStyle(
      FontSize.s12.sp,
      FontWeightManager.regular,
      color ?? Palette.primary,
    );
  }

  static TextStyle semiBold12({Color? color}) {
    return _getTextStyle(
      FontSize.s12.sp,
      FontWeightManager.semiBold,
      color ?? Palette.primary,
    );
  }

  static TextStyle bold12({Color? color}) {
    return _getTextStyle(
      FontSize.s12.sp,
      FontWeightManager.bold,
      color ?? Palette.primary,
    );
  }

  static TextStyle light14({Color? color}) {
    return _getTextStyle(
      FontSize.s14.sp,
      FontWeightManager.light,
      color ?? Palette.primary,
    );
  }

  static TextStyle regular14({Color? color}) {
    return _getTextStyle(
      FontSize.s14.sp,
      FontWeightManager.regular,
      color ?? Palette.primary,
    );
  }

  static TextStyle semiBold14({Color? color}) {
    return _getTextStyle(
      FontSize.s14.sp,
      FontWeightManager.semiBold,
      color ?? Palette.primary,
    );
  }

  static TextStyle bold10({Color? color}) {
    return _getTextStyle(
      FontSize.s10.sp,
      FontWeightManager.bold,
      color ?? Palette.primary,
    );
  }

  static TextStyle bold14({Color? color}) {
    return _getTextStyle(
      FontSize.s14.sp,
      FontWeightManager.bold,
      color ?? Palette.primary,
    );
  }

  static TextStyle bold15({Color? color}) {
    return _getTextStyle(
      FontSize.s15.sp,
      FontWeightManager.bold,
      color ?? Palette.primary,
    );
  }

  static TextStyle regular16({Color? color}) {
    return _getTextStyle(
      FontSize.s16.sp,
      FontWeightManager.regular,
      color ?? Palette.primary,
    );
  }

  static TextStyle semiBold16({Color? color}) {
    return _getTextStyle(
      FontSize.s16.sp,
      FontWeightManager.semiBold,
      color ?? Palette.primary,
    );
  }

  static TextStyle bold16({Color? color}) {
    return _getTextStyle(
      FontSize.s16.sp,
      FontWeightManager.bold,
      color ?? Palette.primary,
    );
  }

  static TextStyle regular18({Color? color}) {
    return _getTextStyle(
      FontSize.s18.sp,
      FontWeightManager.regular,
      color ?? Palette.primary,
    );
  }

  static TextStyle semiBold18({Color? color}) {
    return _getTextStyle(
      FontSize.s18.sp,
      FontWeightManager.semiBold,
      color ?? Palette.primary,
    );
  }

  static TextStyle regular20({Color? color}) {
    return _getTextStyle(
      FontSize.s20.sp,
      FontWeightManager.regular,
      color ?? Palette.primary,
    );
  }

  static TextStyle semiBold20({Color? color}) {
    return _getTextStyle(
      FontSize.s20.sp,
      FontWeightManager.semiBold,
      color ?? Palette.primary,
    );
  }

  static TextStyle semiBold22({Color? color}) {
    return _getTextStyle(
      FontSize.s22.sp,
      FontWeightManager.semiBold,
      color ?? Palette.primary,
    );
  }

  static TextStyle bold18({Color? color}) {
    return _getTextStyle(
      FontSize.s18.sp,
      FontWeightManager.bold,
      color ?? Palette.primary,
    );
  }

  static TextStyle bold20({Color? color}) {
    return _getTextStyle(
      FontSize.s20.sp,
      FontWeightManager.bold,
      color ?? Palette.primary,
    );
  }

  static TextStyle bold22({Color? color}) {
    return _getTextStyle(
      FontSize.s22.sp,
      FontWeightManager.bold,
      color ?? Palette.primary,
    );
  }

  static TextStyle regular24({Color? color}) {
    return _getTextStyle(
      FontSize.s24.sp,
      FontWeightManager.regular,
      color ?? Palette.primary,
    );
  }

  static TextStyle semiBold24({Color? color}) {
    return _getTextStyle(
      FontSize.s24.sp,
      FontWeightManager.semiBold,
      color ?? Palette.primary,
    );
  }

  static TextStyle bold24({Color? color}) {
    return _getTextStyle(
      FontSize.s24.sp,
      FontWeightManager.bold,
      color ?? Palette.primary,
    );
  }

  static TextStyle bold30({Color? color}) {
    return _getTextStyle(
      FontSize.s30.sp,
      FontWeightManager.bold,
      color ?? Palette.primary,
    );
  }

  static TextStyle bold50({Color? color}) {
    return _getTextStyle(
      FontSize.s50.sp,
      FontWeightManager.bold,
      color ?? Palette.primary,
    );
  }

  static TextStyle bold36({Color? color}) {
    return _getTextStyle(
      FontSize.s36.sp,
      FontWeightManager.bold,
      color ?? Palette.primary,
    );
  }
}
