import 'package:amar_taka/core/usecases/usecase.dart';
import 'package:amar_taka/features/recurring_transactions/domain/entities/recurring_transaction.dart';
import 'package:amar_taka/features/recurring_transactions/domain/usecases/create_recurring_transaction.dart';
import 'package:amar_taka/features/recurring_transactions/domain/usecases/delete_recurring_transaction.dart';
import 'package:amar_taka/features/recurring_transactions/domain/usecases/get_all_recurring_transactions.dart';
import 'package:amar_taka/features/recurring_transactions/domain/usecases/get_overdue_transactions.dart';
import 'package:amar_taka/features/recurring_transactions/domain/usecases/get_recurring_transaction_details.dart';
import 'package:amar_taka/features/recurring_transactions/domain/usecases/get_upcoming_transactions.dart';
import 'package:amar_taka/features/recurring_transactions/domain/usecases/update_recurring_transaction.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'recurring_transaction_event.dart';
part 'recurring_transaction_state.dart';

class RecurringTransactionBloc
    extends Bloc<RecurringTransactionEvent, RecurringTransactionState> {
  final CreateRecurringTransaction createRecurringTransaction;
  final GetAllRecurringTransactions getAllRecurringTransactions;
  final GetRecurringTransactionDetails getRecurringTransactionDetails;
  final UpdateRecurringTransaction updateRecurringTransaction;
  final DeleteRecurringTransaction deleteRecurringTransaction;
  final GetUpcomingTransactions getUpcomingTransactions;
  final GetOverdueTransactions getOverdueTransactions;

  RecurringTransactionBloc({
    required this.createRecurringTransaction,
    required this.getAllRecurringTransactions,
    required this.getRecurringTransactionDetails,
    required this.updateRecurringTransaction,
    required this.deleteRecurringTransaction,
    required this.getUpcomingTransactions,
    required this.getOverdueTransactions,
  }) : super(RecurringTransactionInitial()) {
    on<CreateRecurringTransactionEvent>(_onCreateRecurringTransaction);
    on<GetAllRecurringTransactionsEvent>(_onGetAllRecurringTransactions);
    on<GetRecurringTransactionByIdEvent>(_onGetRecurringTransactionDetails);
    on<UpdateRecurringTransactionEvent>(_onUpdateRecurringTransaction);
    on<DeleteRecurringTransactionEvent>(_onDeleteRecurringTransaction);
    on<GetUpcomingTransactionsEvent>(_onGetUpcomingTransactions);
    on<GetOverdueTransactionsEvent>(_onGetOverdueTransactions);
  }

  void _onCreateRecurringTransaction(
    CreateRecurringTransactionEvent event,
    Emitter<RecurringTransactionState> emit,
  ) async {
    emit(RecurringTransactionLoading());
    final failureOrSuccess = await createRecurringTransaction(
      event.transaction,
    );
    failureOrSuccess.fold(
      (failure) => emit(
        RecurringTransactionError('Failed to create recurring transaction'),
      ),
      (_) => emit(RecurringTransactionSuccess()),
    );
  }

  void _onGetAllRecurringTransactions(
    GetAllRecurringTransactionsEvent event,
    Emitter<RecurringTransactionState> emit,
  ) async {
    emit(RecurringTransactionLoading());
    final failureOrTransactions = await getAllRecurringTransactions(NoParams());
    failureOrTransactions.fold(
      (failure) => emit(
        RecurringTransactionError('Failed to fetch recurring transactions'),
      ),
      (transactions) => emit(RecurringTransactionLoaded(transactions)),
    );
  }

  void _onGetRecurringTransactionDetails(
    GetRecurringTransactionByIdEvent event,
    Emitter<RecurringTransactionState> emit,
  ) async {
    emit(RecurringTransactionLoading());
    final failureOrTransaction = await getRecurringTransactionDetails(event.id);
    failureOrTransaction.fold(
      (failure) => emit(
        RecurringTransactionError(
          'Failed to fetch recurring transaction details',
        ),
      ),
      (transaction) => emit(RecurringTransactionDetailsLoaded(transaction)),
    );
  }

  void _onUpdateRecurringTransaction(
    UpdateRecurringTransactionEvent event,
    Emitter<RecurringTransactionState> emit,
  ) async {
    emit(RecurringTransactionLoading());
    final failureOrSuccess = await updateRecurringTransaction(
      event.transaction,
    );
    failureOrSuccess.fold(
      (failure) => emit(
        RecurringTransactionError('Failed to update recurring transaction'),
      ),
      (_) => emit(RecurringTransactionSuccess()),
    );
  }

  void _onDeleteRecurringTransaction(
    DeleteRecurringTransactionEvent event,
    Emitter<RecurringTransactionState> emit,
  ) async {
    emit(RecurringTransactionLoading());
    final failureOrSuccess = await deleteRecurringTransaction(event.id);
    failureOrSuccess.fold(
      (failure) => emit(
        RecurringTransactionError('Failed to delete recurring transaction'),
      ),
      (_) => emit(RecurringTransactionSuccess()),
    );
  }

  void _onGetUpcomingTransactions(
    GetUpcomingTransactionsEvent event,
    Emitter<RecurringTransactionState> emit,
  ) async {
    emit(RecurringTransactionLoading());
    final failureOrTransactions = await getUpcomingTransactions(NoParams());
    failureOrTransactions.fold(
      (failure) => emit(
        RecurringTransactionError('Failed to fetch upcoming transactions'),
      ),
      (transactions) => emit(RecurringTransactionLoaded(transactions)),
    );
  }

  void _onGetOverdueTransactions(
    GetOverdueTransactionsEvent event,
    Emitter<RecurringTransactionState> emit,
  ) async {
    emit(RecurringTransactionLoading());
    final failureOrTransactions = await getOverdueTransactions(NoParams());
    failureOrTransactions.fold(
      (failure) => emit(
        RecurringTransactionError('Failed to fetch overdue transactions'),
      ),
      (transactions) => emit(RecurringTransactionLoaded(transactions)),
    );
  }
}
