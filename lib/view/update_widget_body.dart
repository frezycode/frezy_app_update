import 'package:flutter/material.dart';
import 'package:frezy_app_update/models/models.dart';

class UpdateWidgetBody extends StatelessWidget {
  const UpdateWidgetBody({
    super.key,
    required this.locale,
    this.onLaterTap,
    this.onUpdateTap,
  });

  final UpdateLocale locale;
  final VoidCallback? onLaterTap;
  final VoidCallback? onUpdateTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
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
            ],
          ),
          const SizedBox(height: 24),
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: onUpdateTap,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    locale.updateButtonTitle,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: TextButton(
                  onPressed: onLaterTap,
                  child: Text(
                    locale.remindButtonTitle,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
