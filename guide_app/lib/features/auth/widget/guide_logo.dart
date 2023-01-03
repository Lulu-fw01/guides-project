import 'package:flutter/widgets.dart';

class GuideLogo extends StatelessWidget {
  const GuideLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: const [
        Text(
            style: TextStyle(
                fontSize: 48,
                height: 0.7,
                fontFamily: 'roboto',
                fontWeight: FontWeight.bold),
            'Guide'),
        Text(
            style: TextStyle(
                fontSize: 16,
                height: 0.7,
                fontFamily: 'roboto',
                fontWeight: FontWeight.bold),
            'project')
      ],
    );
  }
}
