import 'package:amar_taka/core/common/scaffold_with_bottom_nav.dart';
import 'package:amar_taka/features/recurring_transactions/presentation/recurring_transaction_page.dart';
import 'package:amar_taka/features/recurring_transactions/presentation/widgets/add_recurring_transaction_dialog.dart';
import 'package:amar_taka/features/transaction/presentation/pages/add_transaction.dart';
import 'package:amar_taka/features/transaction/presentation/pages/add_page.dart';
import 'package:amar_taka/features/auth/presentation/pages/login.dart';
import 'package:amar_taka/features/auth/presentation/pages/onbaording.dart';
import 'package:amar_taka/features/auth/presentation/pages/signup.dart';
import 'package:amar_taka/features/auth/presentation/pages/splash_screen.dart';
import 'package:amar_taka/features/home/presentation/pages/home.dart';
import 'package:amar_taka/features/budgets/presentation/pages/budgets_page.dart';
import 'package:amar_taka/features/profile/presentation/pages/profile_page.dart';
import 'package:amar_taka/features/search/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter createRouter(String initialRoute) {
    return GoRouter(
      initialLocation: initialRoute,
      routes: [
        GoRoute(path: '/', builder: (context, state) => SplashScreen()),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return ScaffoldWithBottomNavBar(
              body: navigationShell,
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: (index) {
                navigationShell.goBranch(
                  index,
                  initialLocation: index == navigationShell.currentIndex,
                );
              },
            );
          },
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/home',
                  name: "home",
                  builder: (context, state) => const MyHomePage(title: "Home"),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/recurring',
                  name: "recurring",
                  builder: (context, state) => RecurringTransactionsPage(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/add',
                  name: "add",
                  builder: (context, state) => const AddTransaction(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/budgets',
                  name: "budgets",
                  builder: (context, state) => const BudgetsPage(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/profile',
                  name: "profile",
                  builder: (context, state) => const ProfilePage(),
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: '/onboard',
          name: "onboard",
          builder: (context, state) => OnboardingScreen(),
        ),
        GoRoute(
          path: '/signin',
          name: "signin",
          builder: (context, state) => SignInScreen(),
        ),
        GoRoute(
          path: '/signup',
          name: "signup",
          builder: (context, state) => SignUpScreen(),
        ),
        GoRoute(
          path: '/add-transaction',
          name: "add-transaction",
          builder: (context, state) => AddTransactionData(),
        ),
                GoRoute(
          path: '/add-recurring',
          name: "add-recurring",
          builder: (context, state) => AddRecurringTransactionDialog(),
        ),
      ],
    );
  }
}
