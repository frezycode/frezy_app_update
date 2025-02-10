import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoProvider {
  const PackageInfoProvider();

  Future<PackageInfo> getPackageInfo() async {
    return PackageInfo.fromPlatform();
  }
}
