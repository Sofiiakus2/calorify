import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IconSelecting extends StatefulWidget {
  const IconSelecting({super.key, required this.onIconChoose});

  final Function(String) onIconChoose;

  @override
  State<IconSelecting> createState() => _IconSelectingState();
}

class _IconSelectingState extends State<IconSelecting> {
  List<String> iconPaths = [];
  String? selectedIcon;

  @override
  void initState() {
    super.initState();
    loadIcons();
  }

  Future<void> loadIcons() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = Map<String, dynamic>.from(
      json.decode(manifestContent),
    );

    final icons = manifestMap.keys
        .where((String key) => key.startsWith('assets/icons/food/'))
        .toList();

    setState(() {
      iconPaths = icons;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 400,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        //padding: const EdgeInsets.all(8.0),
        itemCount: iconPaths.length,
        itemBuilder: (context, index) {
          final iconPath = iconPaths[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIcon = iconPath;
              });

              String iconName = selectedIcon!.split('/').last.split('.').first;

              widget.onIconChoose(iconName);
            },
            child: Container(
                padding: EdgeInsets.all(
                    selectedIcon == iconPath
                      ? 0.0
                        : 6.0,
                ),
                child: Image.asset(iconPath)),
          );
        },
      ),
    );
  }
}
