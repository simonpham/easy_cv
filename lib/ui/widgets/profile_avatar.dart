import 'package:easy_cv/models/dsc_user.dart';
import 'package:easy_cv/ui/widgets/image_view.dart';
import 'package:easy_cv/utils/extensions.dart';
import 'package:flutter/material.dart';

const _borderWidth = 8.0;

class ProfileAvatar extends StatelessWidget {
  final DscUser user;
  final double size;
  final bool hasStories;
  final Function onTap;
  final bool showRing;
  final bool heroAnimation;

  const ProfileAvatar({
    Key key,
    this.user,
    this.size,
    this.hasStories = false,
    this.onTap,
    this.showRing = true,
    this.heroAnimation = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final avatarSize = size ?? 48.0;
    if (showRing == true) {
      return Container(
        padding: const EdgeInsets.all(_borderWidth * 0.5),
        foregroundDecoration: _getBackgroundRing(context, avatarSize, 2),
        child: Container(
          foregroundDecoration: _getInnerRing(context, avatarSize),
          decoration: _getBackgroundRing(context, avatarSize),
          child: _buildImage(context, avatarSize),
        ),
      );
    }
    return _buildImage(context, avatarSize);
  }

  Widget _buildImage(BuildContext context, double avatarSize) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(avatarSize * 0.5),
      child: SizedBox(
        height: avatarSize,
        width: avatarSize,
        child: Container(
          color: Colors.white,
          child: ImageView(
            user?.profilePicUrl ?? "https://i.imgur.com/oZccicr.jpg",
            fit: BoxFit.cover,
            heroAnimation: heroAnimation,
          ),
        ),
      ),
    );
  }

  BoxDecoration _getBackgroundRing(BuildContext context, double avatarSize,
      [int borderScale = 1]) {
    return BoxDecoration(
      border: Border.all(
        width: _borderWidth / borderScale,
        color: context.theme.scaffoldBackgroundColor,
      ),
      borderRadius: BorderRadius.circular(
        _borderWidth * borderScale + avatarSize * 0.5,
      ),
    );
  }

  BoxDecoration _getInnerRing(BuildContext context, double avatarSize) {
    return BoxDecoration(
      border: Border.all(
        width: _borderWidth * 0.5,
        color: hasStories.ifTrue(Colors.pinkAccent, Colors.grey[300]),
      ),
      borderRadius: BorderRadius.circular(
        _borderWidth * 2 + avatarSize * 0.5,
      ),
    );
  }
}
