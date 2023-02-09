import 'package:flutter/material.dart';

class GuideCard extends StatelessWidget {
  const GuideCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [Text('author')],
              ),
              Text('Guide name'),
              Row(
                children: [Text('10.02.2023')],
              )
            ],
          ),
          Row(
            children: [//Icon(Icons.bookmark)
              IconButton(onPressed: () {}, icon: Icon(Icons.bookmark)),
              IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz),)
            ],
          )
        ],
      ),
    );
  }
}
