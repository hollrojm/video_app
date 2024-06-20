import 'package:go_router/go_router.dart';
import 'package:video_app/presentation/ui/screens/screens_export.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    name: HomeScreen.name,
    builder: (context, state) => const HomeScreen(),
  )
]);
