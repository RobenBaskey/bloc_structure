
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/local_data_source/local_data_source.dart';
import '../../data/remote_data_source/remote_data_source.dart';
import '../../presentation/pages/login/bloc/login_bloc.dart';
import '../../presentation/pages/login/repo/login_repo.dart';
import '../../presentation/pages/splash/bloc/splash_bloc.dart';
import '../../presentation/pages/splash/repo/splash_repo.dart';
import '../../presentation/routes/app_router.dart';
import '../../presentation/routes/route_names.dart';
import '../../presentation/utils/app_colors.dart';
import '../../presentation/widgets/size_config.dart';

class App extends StatelessWidget {
  App({super.key });



  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final AppRouter appRouter = AppRouter();
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<RemoteDataSource>(
            create: (context) => RemoteDataSourceImpl(),
          ),
          RepositoryProvider<LocalDataSource>(
            create: (context) => LocalDataSourceImpl(),
          ),
          RepositoryProvider<SplashRepository>(
            create: (context) => SplashRepositoryImpl(
                remoteDataSource:
                RepositoryProvider.of<RemoteDataSource>(context),
                localDataSource:
                RepositoryProvider.of<LocalDataSource>(context)),
          ),

          RepositoryProvider<LoginRepository>(
            create: (context) => LoginRepoImpl(
                remoteDataSource:
                    RepositoryProvider.of<RemoteDataSource>(context),
                localDataSource:
                    RepositoryProvider.of<LocalDataSource>(context)),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<SplashBloc>(
              create: (BuildContext context) => SplashBloc(splashRepo:RepositoryProvider.of<SplashRepository>(context) ),
            ),
            BlocProvider<LoginBloc>(
              create: (BuildContext context) => LoginBloc(loginRepo:RepositoryProvider.of<LoginRepository>(context) ),
            ),

          ],
          // create: (context) => SubjectBloc(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              // appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
              useMaterial3: true,
              colorScheme: ColorScheme.fromSwatch(
                accentColor: Colors.green,
                backgroundColor: Colors.white,
              ),
              scaffoldBackgroundColor: backgroundColor,
              appBarTheme: const AppBarTheme(
                backgroundColor: backgroundColor,
                surfaceTintColor: backgroundColor,
              ),
            ),
            onGenerateRoute: appRouter.onGenerateRoute,
            initialRoute: RouteNames.init,
            // localizationsDelegates: AppLocalizations.localizationsDelegates,
            // supportedLocales: AppLocalizations.supportedLocales,
          ),
        ));
  }
}
