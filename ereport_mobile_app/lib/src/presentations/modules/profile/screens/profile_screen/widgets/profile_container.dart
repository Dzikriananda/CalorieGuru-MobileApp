import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:flutter/material.dart';

class ProfileContainer extends StatelessWidget {
  final Color backgroundContainerColor;
  final Color progressColor;
  final double progress;

  const ProfileContainer({
    Key? key,
    this.backgroundContainerColor = primaryContainer,
    this.progressColor = backgroundColor,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.17,
      child: Stack(
        children: [
          Container(
            color: backgroundContainerColor,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: (MediaQuery.of(context).size.height * 0.17) * progress,
              color: progressColor,
            ),
          ),
          Center(
            child: ClipOval(
              child: SizedBox.fromSize(
                size: const Size.fromRadius(60), // Image radius
                child: Image.network('https://www.w3schools.com/howto/img_avatar.png', fit: BoxFit.cover),
              ),
            ),
          )
        ],
      ),
    );
  }
}