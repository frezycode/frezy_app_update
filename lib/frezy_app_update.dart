import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frezy_app_update/models/models.dart';
import 'package:frezy_app_update/utils/update_checker.dart';
import 'package:frezy_app_update/view/hard_update_screen.dart';
import 'package:frezy_app_update/view/soft_update_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

export 'models/models.dart';

class FrezyAppUpdate {
  const FrezyAppUpdate._(this.context);

  final BuildContext context;
  final UpdateChecker _updateChecker = const UpdateChecker();

  static const _playMarketUrl =
      'https://play.google.com/store/apps/details?id=';
  static const _appstoreUrl = 'https://apps.apple.com/app/id';

  factory FrezyAppUpdate.of(BuildContext context) {
    return FrezyAppUpdate._(context);
  }

  Future<void> checkForUpdate({
    required String soft,
    required String hard,
    required AppIds appIds,
    Function(UpdateStatus status)? onShow,
    Function(UpdateStatus status)? onCancel,
    Function(UpdateStatus status)? onUpdate,
    required UpdateLocale softLocale,
    required UpdateLocale hardLocale,
  }) async {
    final status = await _updateChecker.checkVersion(
      soft: soft,
      hard: hard,
    );

    switch (status) {
      case UpdateStatus.soft:
        _onSoftUpdate(
          locale: softLocale,
          onShow: () => onShow?.call(status),
          onCancel: () => _onCancelTap(onCancel, status),
          onUpdateTap: () => _onUpdateTap(onUpdate, status, appIds),
        );
        break;
      case UpdateStatus.hard:
        _onHardUpdate(
          locale: softLocale,
          onUpdateStart: () => onShow?.call(status),
          onUpdateTap: () => _onUpdateTap(onUpdate, status, appIds),
        );
        break;
      case UpdateStatus.none:
        break;
    }
  }

  Future<void> _onCancelTap(
    Function(UpdateStatus status)? onCancel,
    UpdateStatus status,
  ) async {
    onCancel?.call(status);
    Navigator.of(context).pop();
  }

  Future<void> _onUpdateTap(
    Function(UpdateStatus status)? onUpdateTap,
    UpdateStatus updateStatus,
    AppIds appIds,
  ) async {
    onUpdateTap?.call(updateStatus);
    final uri = _getUpdateUrl(appIds);
    final isValidUrl = await canLaunchUrl(uri);
    if (isValidUrl) {
      await launchUrl(uri);
    }
  }

  Uri _getUpdateUrl(AppIds appIds) {
    final isApple = [TargetPlatform.iOS, TargetPlatform.macOS]
        .contains(defaultTargetPlatform);
    if (isApple) {
      final uri = Uri.parse(_appstoreUrl + appIds.appStoreId);
      return uri;
    }
    final uri = Uri.parse(_playMarketUrl + appIds.androidPackageName);
    return uri;
  }

  void _onHardUpdate({
    required UpdateLocale locale,
    VoidCallback? onUpdateStart,
    VoidCallback? onUpdateTap,
  }) {
    if (context.mounted) {
      onUpdateStart?.call();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return HardUpdateScreen(
              locale: locale,
              onUpdateTap: onUpdateTap,
            );
          },
        ),
      );
    }
  }

  void _onSoftUpdate({
    required UpdateLocale locale,
    VoidCallback? onShow,
    VoidCallback? onCancel,
    VoidCallback? onUpdateTap,
  }) {
    if (context.mounted) {
      onShow?.call();
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return SoftUpdateBottomSheet(
            locale: locale,
            onLaterTap: onCancel,
            onUpdateTap: onUpdateTap,
          );
        },
      );
    }
  }
}
