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
    VoidCallback? onSoftUpdate,
    VoidCallback? onHardUpdate,
    required UpdateLocale softLocale,
    required UpdateLocale hardLocale,
  }) async {
    final updateStatus = await _updateChecker.checkVersion(
      soft: soft,
      hard: hard,
    );

    switch (updateStatus) {
      case UpdateStatus.soft:
        _onSoftUpdate(softLocale);
        break;
      case UpdateStatus.hard:
        _onHardUpdate(hardLocale);
        break;
      case UpdateStatus.none:
        break;
    }
  }

  void _onHardUpdate(UpdateLocale locale) {
    if (context.mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(
          settings: const RouteSettings(name: '/hard-update'),
          builder: (context) {
            return const HardUpdateScreen();
          },
        ),
      );
    }
  }

  void _onSoftUpdate(UpdateLocale locale) {
    if (context.mounted) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return SoftUpdateBottomSheet(locale: locale);
        },
      );
    }
  }
}
