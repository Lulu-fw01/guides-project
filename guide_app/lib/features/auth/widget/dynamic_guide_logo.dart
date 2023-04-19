import 'package:flutter/widgets.dart';

import 'guide_logo.dart';

class DynamicGuideLogo extends StatefulWidget {
  const DynamicGuideLogo({super.key});

  @override
  State<StatefulWidget> createState() => DynamicGuideLogoState();
}

class DynamicGuideLogoState extends State<DynamicGuideLogo>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  /// Time of guide logo animation i milliseconds.
  static const _animationTime = 400;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: 1,
      duration: const Duration(milliseconds: _animationTime),
      reverseDuration: const Duration(milliseconds: _animationTime),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    if (keyboardVisible) {
      _controller.animateBack(0,
          duration: const Duration(milliseconds: _animationTime));
    } else {
      _controller.forward();
    }
    return SizeTransition(
      sizeFactor: _animation,
      axis: Axis.vertical,
      child: Center(
        child: Column(
          children: const [
            SizedBox(
              height: 8,
            ),
            GuideLogo(),
            SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
