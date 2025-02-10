import 'package_info_provider.dart';
import 'version_comparer.dart';

class UpdateChecker {
  const UpdateChecker({
    this.packageInfoPrivider = const PackageInfoProvider(),
    this.versionComparer = const VersionComparer(),
  });

  final PackageInfoProvider packageInfoPrivider;
  final VersionComparer versionComparer;

  Future<UpdateStatus> checkVersion({
    required String soft,
    required String hard,
  }) async {
    final packageInfo = await packageInfoPrivider.getPackageInfo();
    final currentVersion = packageInfo.version;

    final hardAvailable = versionComparer.isVersionNewer(
      currentVersion,
      hard,
    );
    if (hardAvailable) return UpdateStatus.hard;

    final softAvailable = versionComparer.isVersionNewer(
      currentVersion,
      soft,
    );
    if (softAvailable) return UpdateStatus.soft;

    return UpdateStatus.none;
  }
}

enum UpdateStatus { none, soft, hard }
