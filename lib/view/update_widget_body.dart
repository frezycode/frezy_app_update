import 'package:flutter/material.dart';
import 'package:frezy_app_update/models/models.dart';

class UpdateWidgetBody extends StatelessWidget {
  const UpdateWidgetBody({
    super.key,
    required this.locale,
    this.isFullScreen = false,
    this.status = UpdateStatus.soft,
    this.onLaterTap,
    this.onUpdateTap,
  });

  final UpdateStatus status;
  final bool isFullScreen;
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
          if (isFullScreen) const SizedBox(),
          Column(
            children: [
              Image.asset(
                'packages/frezy_app_update/assets/download.png',
                width: 250,
                height: 250,
              ),
              Text(
                locale.title,
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 2),
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
                    backgroundColor: theme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    locale.updateButtonTitle,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              if (status == UpdateStatus.soft)
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
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
