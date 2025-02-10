import 'package:flutter/material.dart';
import 'package:frezy_app_update/models/models.dart';
import 'package:frezy_app_update/utils/update_checker.dart';
import 'package:frezy_app_update/view/hard_update_screen.dart';
import 'package:frezy_app_update/view/soft_update_bottom_sheet.dart';

class FrezyAppUpdate {
  const FrezyAppUpdate._(this.context);

  final BuildContext context;
  final UpdateChecker _updateChecker = const UpdateChecker();

  factory FrezyAppUpdate.of(BuildContext context) {
    return FrezyAppUpdate._(context);
  }

  Future<void> checkForUpdate({
    required String soft,
    required String hard,
    Function(UpdateStatus status)? onUpdateStart,
    Function(UpdateStatus status)? onLaterTap,
    Function(UpdateStatus status)? onUpdateTap,
    required UpdateLocale softLocale,
    required UpdateLocale hardLocale,
  }) async {
    final updateStatus = await _updateChecker.checkVersion(
      soft: soft,
      hard: hard,
    );

    switch (updateStatus) {
      case UpdateStatus.soft:
        _onSoftUpdate(
          locale: softLocale,
          onUpdateStart: () => onUpdateStart?.call(updateStatus),
          onLaterTap: () => onLaterTap?.call(updateStatus),
          onUpdateTap: () => onUpdateTap?.call(updateStatus),
        );
        break;
      case UpdateStatus.hard:
        _onHardUpdate(
          locale: softLocale,
          onUpdateStart: () => onUpdateStart?.call(updateStatus),
          onLaterTap: () => onLaterTap?.call(updateStatus),
          onUpdateTap: () => onUpdateTap?.call(updateStatus),
        );
        break;
      case UpdateStatus.none:
        break;
    }
  }

  void _onHardUpdate({
    required UpdateLocale locale,
    VoidCallback? onUpdateStart,
    VoidCallback? onLaterTap,
    VoidCallback? onUpdateTap,
  }) {
    onUpdateStart?.call();
    if (context.mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(
          settings: const RouteSettings(name: '/hard-update'),
          builder: (context) {
            return HardUpdateScreen(
              locale: locale,
              onLaterTap: onLaterTap,
              onUpdateTap: onUpdateTap,
            );
          },
        ),
      );
    }
  }

  void _onSoftUpdate({
    required UpdateLocale locale,
    VoidCallback? onUpdateStart,
    VoidCallback? onLaterTap,
    VoidCallback? onUpdateTap,
  }) {
    onUpdateStart?.call();
    if (context.mounted) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return SoftUpdateBottomSheet(
            locale: locale,
            onLaterTap: onLaterTap,
            onUpdateTap: onUpdateTap,
          );
        },
      );
    }
  }
}
