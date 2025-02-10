import 'package:version/version.dart';

class VersionComparer {
  const VersionComparer();

  bool isVersionNewer(
    String currentVersion,
    String remoteVersion,
  ) {
    final current = Version.parse(currentVersion);
    final remote = Version.parse(remoteVersion);
    return current < remote;
  }
}
