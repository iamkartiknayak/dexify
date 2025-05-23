import 'package:flutter/material.dart';

class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.subTitle,
  });

  final IconData icon;
  final String title;
  final String subTitle;

  @override
  Widget build(final BuildContext context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          fill: 1,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          size: 80.0,
        ),
        const SizedBox(height: 24.0),
        Text(
          title,
          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8.0),
        Text(
          subTitle,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    ),
  );
}
