//
// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:balance_sheet/transactions/cubit/cubit.dart';
//
// void main() {
//   group('TransactionsCubit', () {
//     group('constructor', () {
//       test('can be instantiated', () {
//         expect(
//           TransactionsCubit(),
//           isNotNull,
//         );
//       });
//     });
//
//     test('initial state has default value for customProperty', () {
//       final transactionsCubit = TransactionsCubit();
//       expect(transactionsCubit.state.customProperty, equals('Default Value'));
//     });
//
//     blocTest<TransactionsCubit, TransactionsState>(
//       'yourCustomFunction emits nothing',
//       build: TransactionsCubit.new,
//       act: (cubit) => cubit.yourCustomFunction(),
//       expect: () => <TransactionsState>[],
//     );
//   });
// }
