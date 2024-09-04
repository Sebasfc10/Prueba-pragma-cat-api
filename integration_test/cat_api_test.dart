import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'cat_api_verify_tap_tst.dart' as verify;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  verify.main();

}