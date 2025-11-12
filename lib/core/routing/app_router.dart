import 'package:go_router/go_router.dart';
import 'package:workiom_task/core/routing/app_routes.dart';
import 'package:workiom_task/features/auth/presentation/pages/login_page.dart';
import 'package:workiom_task/features/auth/presentation/pages/email_login_page.dart';
import 'package:workiom_task/features/auth/presentation/pages/company_entry_page.dart';
import 'package:workiom_task/features/auth/presentation/pages/thank_you_page.dart';

//? GoRouter configuration for app navigation
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.login,
  routes: [
    //* Auth routes
    GoRoute(
      path: AppRoutes.login,
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    
    GoRoute(
      path: AppRoutes.emailLogin,
      name: 'emailLogin',
      builder: (context, state) => const EmailLoginPage(),
    ),
    
    GoRoute(
      path: AppRoutes.companyEntry,
      name: 'companyEntry',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        final email = extra?['email'] as String? ?? '';
        final password = extra?['password'] as String? ?? '';
        return CompanyEntryPage(email: email, password: password);
      },
    ),
    
    GoRoute(
      path: AppRoutes.thankYou,
      name: 'thankYou',
      builder: (context, state) => const ThankYouPage(),
    ),
    
    //TODO: Add more routes as needed
  ],
  
  //? Error handling
  errorBuilder: (context, state) => const LoginPage(),
);

