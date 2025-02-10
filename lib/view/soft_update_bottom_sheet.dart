import 'package:flutter/material.dart';
import 'package:frezy_app_update/models/models.dart';
import 'package:frezy_app_update/view/update_widget_body.dart';

class SoftUpdateBottomSheet extends StatelessWidget {
  const SoftUpdateBottomSheet({
    super.key,
    required this.locale,
    required this.onLaterTap,
    required this.onUpdateTap,
  });

  final UpdateLocale locale;
  final VoidCallback? onLaterTap;
  final VoidCallback? onUpdateTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: UpdateWidgetBody(
        locale: locale,
        onLaterTap: onLaterTap,
        onUpdateTap: onUpdateTap,
      ),
    );
  }
}
