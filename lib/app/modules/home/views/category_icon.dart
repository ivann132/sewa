import 'package:flutter/material.dart';

class CategoryIcon extends StatelessWidget {
  final String name;
  final IconData icon;
  final VoidCallback? onTap;

  const CategoryIcon({required this.name, required this.icon, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey[200],
            child: Icon(icon, color: Colors.black),
          ),
          const SizedBox(height: 5),
          Text(name, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
