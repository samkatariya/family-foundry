import 'package:go_router/go_router.dart';
import '../features/dashboard/dashboard_screen.dart';
import '../features/members/members_list_screen.dart';
import '../features/members/member_detail_screen.dart';
import '../features/problems/problems_list_screen.dart';
import '../features/problems/problem_detail_screen.dart';
import '../features/ideas/ideas_list_screen.dart';
import '../features/ideas/idea_detail_screen.dart';
import '../features/experiments/experiments_list_screen.dart';
import '../features/experiments/experiment_detail_screen.dart';
import '../features/meetings/meetings_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/members',
      builder: (context, state) {
        final searchQuery = state.uri.queryParameters['search'] ?? '';
        return MembersListScreen(initialSearch: searchQuery);
      },
      routes: [
        GoRoute(
          path: ':id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return MemberDetailScreen(memberId: id);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/problems',
      builder: (context, state) => const ProblemsListScreen(),
      routes: [
        GoRoute(
          path: ':id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return ProblemDetailScreen(problemId: id);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/ideas',
      builder: (context, state) => const IdeasListScreen(),
      routes: [
        GoRoute(
          path: ':id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return IdeaDetailScreen(ideaId: id);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/experiments',
      builder: (context, state) => const ExperimentsListScreen(),
      routes: [
        GoRoute(
          path: ':id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return ExperimentDetailScreen(experimentId: id);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/meetings',
      builder: (context, state) => const MeetingsScreen(),
    ),
  ],
);
