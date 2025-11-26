import 'package:agni_pariksha/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:agni_pariksha/features/location/presentation/cubit/location_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/app_theme.dart';
import 'core/routes/app_router.dart';
import 'core/services/storage_service.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(
    
          
    MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final authCubit = di.sl<AuthCubit>();
    final appRouter = AppRouter();

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (_) => di.sl<AuthCubit>()),
        BlocProvider<LocationCubit>(create: (_) => di.sl<LocationCubit>()),
      ],
      child: MaterialApp.router(
        title: 'Agni Pariksha',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: appRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
