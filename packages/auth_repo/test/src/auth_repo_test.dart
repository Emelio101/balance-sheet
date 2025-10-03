// Not required for test files
import 'package:auth_repo/auth_repo.dart';
import 'package:test/test.dart';

void main() {
  group('AuthRepo', () {
    test('can be instantiated', () {
      expect(AuthRepo(), isNotNull);
    });
  });
}
