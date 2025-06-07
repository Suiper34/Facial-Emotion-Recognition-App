import 'package:flutter/material.dart';

class ProdigyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProdigyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      title: const Text(
        'Facial Emotion Recognition',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'Raleway',
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      flexibleSpace: Stack(
        children: [
          Positioned(
            top: -200,
            left: 0,
            right: 0,
            child: Container(
              height: 400,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF6C63FF),
                    Color(0xFF4C45E8),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -200,
            left: 0,
            right: 0,
            child: Container(
              height: 400,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color(0xFF6C63FF),
                    Color(0xFF4C45E8),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 200);
}
