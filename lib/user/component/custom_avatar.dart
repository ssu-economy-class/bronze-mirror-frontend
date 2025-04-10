import 'package:flutter/material.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';

class CustomAvatar extends StatelessWidget {
  final double r;
  final String? imgUrl;

  const CustomAvatar({required this.r, required this.imgUrl, super.key});

  @override
  Widget build(BuildContext context) {
    if (imgUrl == null) {
      return Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(radius: r, backgroundColor: Color(0XFFE3E5E8)),
          Icon(Icons.person, color: Color(0XFFAEB4B7), size: r*4/3),
        ],
      );
    }
    return CircleAvatar(radius: r, backgroundImage: NetworkImage(imgUrl!));
  }
}

class CustomAvatarLoading extends StatelessWidget {
  final double r;

  const CustomAvatarLoading({required this.r, super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonAvatar(
      style: SkeletonAvatarStyle(
        shape: BoxShape.circle,
        width: r * 2,
        height: r * 2,
      ),
    );
  }
}
