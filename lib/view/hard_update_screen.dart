import 'package:flutter/material.dart';
import 'package:frezy_app_update/models/models.dart';
import 'package:frezy_app_update/view/update_widget_body.dart';

class HardUpdateScreen extends StatelessWidget {
  const HardUpdateScreen({
    super.key,
    required this.locale,
    this.onLaterTap,
    required this.onUpdateTap,
  });

  final UpdateLocale locale;
  final VoidCallback? onLaterTap;
  final VoidCallback? onUpdateTap;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: UpdateWidgetBody(
          locale: locale,
          isFullScreen: true,
          status: UpdateStatus.hard,
          onLaterTap: onLaterTap,
          onUpdateTap: onUpdateTap,
        ),
      ),
    );
  }
}
