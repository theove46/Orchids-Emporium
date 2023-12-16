// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:orchids_emporium/core/theme/palette.dart';

class ShowSnackBarMessage {
  static void showSuccessSnackBar({
    required String message,
    required BuildContext context,
    int seconds = 2,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: seconds),
        content: Center(
          child: Text(
            message,
            style: const TextStyle(color: Palette.secondary, fontSize: 16),
          ),
        ),
        backgroundColor: Palette.primary,
      ),
    );
  }

  static void showErrorSnackBar({
    required String message,
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: Center(
          child: Text(
            message,
            style: const TextStyle(color: Palette.secondary, fontSize: 16),
          ),
        ),
        backgroundColor: Palette.red,
      ),
    );
  }

  static void showLoadingSnackBar({
    required String message,
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Row(
          children: [
            Center(
              child: Text(
                message,
                style: const TextStyle(color: Palette.secondary, fontSize: 16),
              ),
            ),
          ],
        ),
        backgroundColor: Palette.primary,
      ),
    );
  }
}
