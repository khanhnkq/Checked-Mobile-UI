import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/otp_verify_screen.dart';
import '../features/auth/presentation/screens/register_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/profile/presentation/screens/complete_profile_screen.dart';
import '../features/profile/presentation/screens/settings_screen.dart';
import '../features/profile/presentation/screens/profile_screen.dart';
import '../features/expense/presentation/screens/expense_screen.dart';
import '../features/friend_invite/presentation/screens/friend_invite_screen.dart';
import '../features/friendship/presentation/screens/friendship_screen.dart';
import '../features/home/presentation/screens/history_grid_screen.dart';
import '../features/home/presentation/screens/image_preview_screen.dart';
import 'auth_gate.dart';

final GoRouter appRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) => const AuthGate(),
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) =>
          const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (BuildContext context, GoRouterState state) =>
          const RegisterScreen(),
    ),
    GoRoute(
      path: '/otp',
      builder: (BuildContext context, GoRouterState state) {
        final email = state.uri.queryParameters['email'] ?? '';
        return OtpVerifyScreen(email: email);
      },
    ),
    GoRoute(
      path: '/complete-profile',
      builder: (BuildContext context, GoRouterState state) =>
          const CompleteProfileScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) =>
          const HomeScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (BuildContext context, GoRouterState state) =>
          const ProfileScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (BuildContext context, GoRouterState state) =>
          const SettingsScreen(),
    ),
    GoRoute(
      path: '/expense',
      builder: (BuildContext context, GoRouterState state) =>
          const ExpenseScreen(),
    ),
    GoRoute(
      path: '/friend-invite',
      builder: (BuildContext context, GoRouterState state) =>
          const FriendInviteScreen(),
    ),
    GoRoute(
      path: '/friendships',
      builder: (BuildContext context, GoRouterState state) =>
          const FriendshipScreen(),
    ),
    GoRoute(
      path: '/history',
      builder: (BuildContext context, GoRouterState state) =>
          const HistoryGridScreen(),
    ),
    GoRoute(
      path: '/image-preview',
      builder: (BuildContext context, GoRouterState state) {
        final imagePath = state.uri.queryParameters['path'] ?? '';
        return ImagePreviewScreen(imagePath: imagePath);
      },
    ),
  ],
);
