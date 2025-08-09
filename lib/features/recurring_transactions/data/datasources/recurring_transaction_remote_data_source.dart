import 'package:amar_taka/features/recurring_transactions/data/models/recurring_transaction_model.dart';


abstract class RecurringTransactionRemoteDataSource {
  Future<void> createRecurringTransaction(RecurringTransactionModel transaction);
  Future<List<RecurringTransactionModel>> getAllRecurringTransactions();
  Future<RecurringTransactionModel> getRecurringTransactionDetails(int id);
  Future<void> updateRecurringTransaction(RecurringTransactionModel transaction);
  Future<void> deleteRecurringTransaction(int id);
  Future<List<RecurringTransactionModel>> getUpcomingTransactions();
  Future<List<RecurringTransactionModel>> getOverdueTransactions();
}