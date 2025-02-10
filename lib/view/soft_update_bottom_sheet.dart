import 'package:flutter/material.dart';
import 'package:frezy_app_update/models/models.dart';

class SoftUpdateBottomSheet extends StatelessWidget {
  const SoftUpdateBottomSheet({
    super.key,
    required this.locale,
  });

  final UpdateLocale locale;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            locale.title,
            style: theme.textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            locale.description,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(),
            child: Text(
              locale.updateButtonTitle,
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () {},
            child: Text(
              locale.remindButtonTitle,
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
