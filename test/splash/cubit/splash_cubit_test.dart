// // ignore_for_file: prefer_const_constructors
//
// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:balance_sheet/splash/cubit/cubit.dart';
//
// void main() {
//   group('SplashCubit', () {
//     group('constructor', () {
//       test('can be instantiated', () {
//         expect(
//           SplashCubit(),
//           isNotNull,
//         );
//       });
//     });
//
//     test('initial state has default value for customProperty', () {
//       final splashCubit = SplashCubit();
//       expect(splashCubit.state.customProperty, equals('Default Value'));
//     });
//
//     blocTest<SplashCubit, SplashState>(
//       'yourCustomFunction emits nothing',
//       build: SplashCubit.new,
//       act: (cubit) => cubit.yourCustomFunction(),
//       expect: () => <SplashState>[],
//     );
//   });
// }
