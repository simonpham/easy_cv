import 'package:flutter/material.dart';

class Tappable extends StatefulWidget {
  final Widget child;

  final GestureTapCallback onTap;
  final GestureTapCallback onDoubleTap;
  final GestureLongPressCallback onLongPress;
  final GestureTapDownCallback onTapDown;
  final GestureTapCancelCallback onTapCancel;
  final ValueChanged<bool> onHighlightChanged;
  final ValueChanged<bool> onHover;

  const Tappable({
    Key key,
    this.child,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.onTapDown,
    this.onTapCancel,
    this.onHighlightChanged,
    this.onHover,
  }) : super(key: key);

  @override
  _TappableState createState() => _TappableState();
}

class _TappableState extends State<Tappable> with TickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 75),
    );
    animation = Tween(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, _) {
          return Transform.scale(
            scale: animation.value,
            child: Container(
              color: Colors.transparent,
              child: widget.child,
            ),
          );
        },
      ),
      onTap: () async {
        if (widget.onTap != null) {
          widget.onTap();
        }
        await animationController.forward();
        animationController.reverse();
      },
      onDoubleTap: widget.onDoubleTap,
      onLongPress: widget.onLongPress,
      onTapDown: (TapDownDetails details) {
        animationController.forward();
        if (widget.onTapDown != null) {
          widget.onTapDown(details);
        }
      },
      onTapUp: (TapUpDetails details) {
        animationController.reverse();
      },
      onTapCancel: () {
        animationController.reverse();
        if (widget.onTapCancel != null) {
          widget.onTapCancel();
        }
      },
    );
  }
}
