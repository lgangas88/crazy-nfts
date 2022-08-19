import 'dart:ui';

import 'package:crazy_nfts/ui/components/mirrow_style.dart';
import 'package:flutter/material.dart';

final List<IconData> iconList = [
  Icons.explore,
  Icons.bar_chart_outlined,
  Icons.notifications,
  Icons.favorite,
  Icons.person,
];

class CustomBottomNavigationBar extends StatelessWidget {
  final Function(int index) onItemPressed;
  int selectedIndex;

  CustomBottomNavigationBar({
    super.key,
    required this.onItemPressed,
    this.selectedIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10000),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10000),
        child: MirrorStyle(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final buttonWidth =
                    (constraints.maxWidth / iconList.length) - 8;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (final entry in iconList.asMap().entries.toList())
                      CircleAvatar(
                        radius: buttonWidth / 2,
                        backgroundColor: entry.key == selectedIndex
                            ? Colors.white
                            : Colors.transparent,
                        child: IconButton(
                          icon: Icon(
                            entry.value,
                            color: Colors.black,
                          ),
                          onPressed: () => onItemPressed(entry.key),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
