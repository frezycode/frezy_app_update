import 'package:flutter_test/flutter_test.dart';

import 'package:frezy_app_update/utils/version_comparer.dart';

void main() {
  group('VersionComparer', () {
    test('Same version', () {
      final versionComparer = VersionComparer();
      expect(
        versionComparer.isVersionNewer('1.0.0', '1.0.0'),
        false,
      );
    });

    test('Newer version available', () {
      final versionComparer = VersionComparer();
      expect(
        versionComparer.isVersionNewer('1.0.0', '1.1.0'),
        true,
      );
    });

    test('Older version', () {
      final versionComparer = VersionComparer();
      expect(
        versionComparer.isVersionNewer('1.1.0', '1.0.0'),
        false,
      );
    });

    test('Major version update', () {
      final versionComparer = VersionComparer();
      expect(
        versionComparer.isVersionNewer('1.0.0', '2.0.0'),
        true,
      );
    });

    test('Minor version update', () {
      final versionComparer = VersionComparer();
      expect(
        versionComparer.isVersionNewer('1.1.0', '1.2.0'),
        true,
      );
    });

    test('Patch version update', () {
      final versionComparer = VersionComparer();
      expect(
        versionComparer.isVersionNewer('1.1.1', '1.1.2'),
        true,
      );
    });

    // Additional test cases
    test('Pre-release version', () {
      final versionComparer = VersionComparer();
      expect(
        versionComparer.isVersionNewer('1.0.0-alpha', '1.0.0-beta'),
        true,
      );
    });

    test('Build metadata ignored', () {
      final versionComparer = VersionComparer();
      expect(
        versionComparer.isVersionNewer('1.0.0+001', '1.0.0+002'),
        false,
      );
    });

    test('Different length versions', () {
      final versionComparer = VersionComparer();
      expect(
        versionComparer.isVersionNewer('1.0', '1.0.0'),
        false,
      );
    });

    test('Leading zeros in version', () {
      final versionComparer = VersionComparer();
      expect(
        versionComparer.isVersionNewer('01.0.0', '1.0.0'),
        false,
      );
    });
  });
}
