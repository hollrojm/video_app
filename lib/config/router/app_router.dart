import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:video_app/presentation/ui/screens/home/cubit/video_cubit.dart';
import 'package:video_app/presentation/ui/screens/screens_export.dart';
import 'package:video_app/injection_container.dart' as injection_container;

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => BlocProvider(
        create: ((context) =>
            injection_container.serviceLocator<VideoCubit>()..loadVideos()),
        child: const HomeScreen(),
      ),
    ),
  ],
);
