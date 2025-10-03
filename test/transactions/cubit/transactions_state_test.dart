// // ignore_for_file: prefer_const_constructors
//
// import 'package:balance_sheet/transactions/cubit/cubit.dart';
// import 'package:flutter_test/flutter_test.dart';
//
// void main() {
//   group('TransactionsState', () {
//     test('supports value equality', () {
//       expect(
//         TransactionsState(),
//         equals(
//           const TransactionsState(),
//         ),
//       );
//     });
//
//     group('constructor', () {
//       test('can be instantiated', () {
//         expect(
//           const TransactionsState(),
//           isNotNull,
//         );
//       });
//     });
//
//     group('copyWith', () {
//       test(
//         'copies correctly '
//         'when no argument specified',
//         () {
//           const transactionsState = TransactionsState(
//             customProperty: 'My property',
//           );
//           expect(
//             transactionsState.copyWith(),
//             equals(transactionsState),
//           );
//         },
//       );
//
//       test(
//         'copies correctly '
//         'when all arguments specified',
//         () {
//           const transactionsState = TransactionsState(
//             customProperty: 'My property',
//           );
//           final otherTransactionsState = TransactionsState(
//             customProperty: 'My property 2',
//           );
//           expect(transactionsState, isNot(equals(otherTransactionsState)));
//
//           expect(
//             transactionsState.copyWith(
//               customProperty: otherTransactionsState.customProperty,
//             ),
//             equals(otherTransactionsState),
//           );
//         },
//       );
//     });
//   });
// }
