import 'package:flutter/material.dart';
import 'package:orchids_emporium/core/theme/palette.dart';
import 'package:orchids_emporium/core/typography/style.dart';
import 'package:orchids_emporium/users/view/screens/users_nav_screens/profile_screen_user.dart';

class WelcomeTextWidget extends StatelessWidget {
  const WelcomeTextWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Bringing Nature to',
                style: AppTypography.bold24(),
              ),
              IconButton(
                icon: const Icon(
                  Icons.person,
                  color: Palette.greenColor,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return UserProfileScreen();
                      },
                    ),
                  );
                },
              )
            ],
          ),
          Text(
            'Your Doorstep',
            style: AppTypography.bold36(),
          ),
        ],
      ),
    );
  }
}
