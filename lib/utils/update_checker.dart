import 'package_info_provider.dart';
import 'version_comparer.dart';

class UpdateChecker {
  UpdateChecker({
    this.packageInfoPrivider = const PackageInfoProvider(),
    this.versionComparer = const VersionComparer(),
  });

  final PackageInfoProvider packageInfoPrivider;
  final VersionComparer versionComparer;

  Future<UpdateStatus> checkVersion(String remoteVersion) async {
    final packageInfo = await packageInfoPrivider.getPackageInfo();
    final currentVersion = packageInfo.version;

    final available = versionComparer.isVersionNewer(
      currentVersion,
      remoteVersion,
    );
    if (available) return UpdateStatus.available;

    return UpdateStatus.none;
  }
}

enum UpdateStatus { none, available, required }
