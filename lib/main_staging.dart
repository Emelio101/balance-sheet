import 'package:balance_sheet/app/app.dart';
import 'package:balance_sheet/bootstrap.dart';

Future<void> main() async {
  await bootstrap(() => const App());
}
