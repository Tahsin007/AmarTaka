import 'package:amar_taka/core/network/network_info.dart';
import 'package:amar_taka/features/auth/data/datasources/remote_datasources.dart';
import 'package:amar_taka/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:amar_taka/features/auth/domain/repositories/auth_repository.dart';
import 'package:amar_taka/features/auth/domain/usecases/login.dart';
import 'package:amar_taka/features/auth/domain/usecases/logout.dart';
import 'package:amar_taka/features/auth/domain/usecases/signup.dart';
import 'package:amar_taka/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:amar_taka/features/budgets/data/datasources/budget_remote_data_source.dart';
import 'package:amar_taka/features/budgets/data/repositories/budget_repository_impl.dart';
import 'package:amar_taka/features/budgets/domain/repositories/budget_repository.dart';
import 'package:amar_taka/features/budgets/domain/usecases/add_budget.dart';
import 'package:amar_taka/features/budgets/domain/usecases/get_all_budgets.dart';
import 'package:amar_taka/features/budgets/domain/usecases/update_budget.dart';
import 'package:amar_taka/features/budgets/presentation/bloc/budget_bloc.dart';
import 'package:amar_taka/features/category/data/category_repository_impl.dart';
import 'package:amar_taka/features/category/data/datasources/category_remote_datasources.dart';
import 'package:amar_taka/features/category/domain/repository/category_repository.dart';
import 'package:amar_taka/features/category/domain/usecases/add_category.dart';
import 'package:amar_taka/features/category/domain/usecases/delete_category.dart';
import 'package:amar_taka/features/category/domain/usecases/get_categories.dart';
import 'package:amar_taka/features/category/presentation/bloc/categories_bloc.dart';
import 'package:amar_taka/features/recurring_transactions/data/datasources/recurring_transaction_remote_data_source.dart';
import 'package:amar_taka/features/recurring_transactions/data/datasources/recurring_transaction_remote_data_source_impl.dart';
import 'package:amar_taka/features/recurring_transactions/data/repositories/recurring_transaction_repository_impl.dart';
import 'package:amar_taka/features/recurring_transactions/domain/repositories/recurring_transaction_repository.dart';
import 'package:amar_taka/features/recurring_transactions/domain/usecases/create_recurring_transaction.dart';
import 'package:amar_taka/features/recurring_transactions/domain/usecases/delete_recurring_transaction.dart';
import 'package:amar_taka/features/recurring_transactions/domain/usecases/get_all_recurring_transactions.dart';
import 'package:amar_taka/features/recurring_transactions/domain/usecases/get_overdue_transactions.dart';
import 'package:amar_taka/features/recurring_transactions/domain/usecases/get_recurring_transaction_details.dart';
import 'package:amar_taka/features/recurring_transactions/domain/usecases/get_upcoming_transactions.dart';
import 'package:amar_taka/features/recurring_transactions/domain/usecases/update_recurring_transaction.dart';
import 'package:amar_taka/features/recurring_transactions/presentation/bloc/recurring_transaction_bloc.dart';
import 'package:amar_taka/features/transaction/data/datasources/transaction_remote_datasources.dart';
import 'package:amar_taka/features/transaction/data/transaction_repo_impl.dart';
import 'package:amar_taka/features/transaction/domain/repository/transaction_repository.dart';
import 'package:amar_taka/features/transaction/domain/usecases/add_transaction.dart';
import 'package:amar_taka/features/transaction/domain/usecases/get_transaction.dart';
import 'package:amar_taka/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerLazySingleton<http.Client>(() => http.Client());
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  _initAuth();
  _initCategory();
  _initTransaction();
  _initBudget();
  _initRecurringTransaction();
}

void _initAuth() {
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(login: sl(), signup: sl(), logout: sl()),
  );

  sl.registerLazySingleton<Login>(() => Login(sl()));
  sl.registerLazySingleton<Signup>(() => Signup(sl()));
  sl.registerLazySingleton<Logout>(() => Logout(sl()));

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  sl.registerLazySingleton<AuthRemoteDataSources>(
    () => AuthRemoteDataSourceImpl(client: sl(), sharedPreferences: sl()),
  );
}

void _initCategory() {
  sl.registerFactory<CategoriesBloc>(
    () => CategoriesBloc(
      getCategoriesUseCase: sl(),
      addCategoryUseCase: sl(),
      deleteCategoryUseCase: sl(),
    ),
  );

  sl.registerLazySingleton<GetCategoriesUseCase>(
    () => GetCategoriesUseCase(sl()),
  );
  sl.registerLazySingleton<AddCategoryUseCase>(() => AddCategoryUseCase(sl()));
  sl.registerLazySingleton<DeleteCategoryUseCase>(
    () => DeleteCategoryUseCase(sl()),
  );

  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<CategoryRemoteDatasources>(
    () => CategoryRemoteDatasourcesImpl(sl(), sl()),
  );
}

void _initTransaction() {
  sl.registerFactory<TransactionBloc>(() => TransactionBloc(sl(), sl()));

  sl.registerLazySingleton<GetTransactionUseCase>(
    () => GetTransactionUseCase(sl()),
  );
  sl.registerLazySingleton<AddTransactionUseCase>(
    () => AddTransactionUseCase(sl()),
  );

  sl.registerLazySingleton<TransactionRepository>(
    () => TransactionRepoImpl(sl()),
  );

  sl.registerLazySingleton<TransactionRemoteDatasources>(
    () => TransactionRemoteDatasourcesImpl(sl(), sl()),
  );
}

void _initBudget() {
  sl.registerFactory<BudgetBloc>(
    () => BudgetBloc(getAllBudgets: sl(), addBudget: sl(),updateBudget: sl()),
  );

  sl.registerLazySingleton<GetAllBudgets>(() => GetAllBudgets(sl()));
  sl.registerLazySingleton<AddBudget>(() => AddBudget(sl()));
  sl.registerLazySingleton<UpdateBudget>(() => UpdateBudget(sl()));


  sl.registerLazySingleton<BudgetRepository>(
    () => BudgetRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<BudgetRemoteDataSource>(
    () => BudgetRemoteDataSourceImpl(client: sl(), authRemoteDataSources: sl()),
  );
}

void _initRecurringTransaction() {
  sl.registerFactory<RecurringTransactionBloc>(
    () => RecurringTransactionBloc(
      createRecurringTransaction: sl(),
      getAllRecurringTransactions: sl(),
      getRecurringTransactionDetails: sl(),
      updateRecurringTransaction: sl(),
      deleteRecurringTransaction: sl(),
      getUpcomingTransactions: sl(),
      getOverdueTransactions: sl(),
    ),
  );

  sl.registerLazySingleton<CreateRecurringTransaction>(
      () => CreateRecurringTransaction(sl()));
  sl.registerLazySingleton<GetAllRecurringTransactions>(
      () => GetAllRecurringTransactions(sl()));
  sl.registerLazySingleton<GetRecurringTransactionDetails>(
      () => GetRecurringTransactionDetails(sl()));
  sl.registerLazySingleton<UpdateRecurringTransaction>(
      () => UpdateRecurringTransaction(sl()));
  sl.registerLazySingleton<DeleteRecurringTransaction>(
      () => DeleteRecurringTransaction(sl()));
  sl.registerLazySingleton<GetUpcomingTransactions>(
      () => GetUpcomingTransactions(sl()));
  sl.registerLazySingleton<GetOverdueTransactions>(
      () => GetOverdueTransactions(sl()));

  sl.registerLazySingleton<RecurringTransactionRepository>(
    () => RecurringTransactionRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<RecurringTransactionRemoteDataSource>(
    () => RecurringTransactionRemoteDataSourceImpl(
      client: sl(),auth: sl()
    ),
  );
}

