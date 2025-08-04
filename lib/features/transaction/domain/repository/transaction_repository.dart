abstract class TransactionRepository {
  Future<void> addTransaction(Map<String, dynamic> transactionData);
  
  Future<List<Map<String, dynamic>>> getTransactions();
  
  Future<void> updateTransaction(String transactionId, Map<String, dynamic> updatedData);
  
  Future<void> deleteTransaction(String transactionId);

  
}