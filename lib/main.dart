import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posha/blocs/category_cubit.dart';
import 'package:posha/blocs/onboarding_cubit.dart';
import 'package:posha/route/app_router.dart';

import 'blocs/adopt/adopt_bloc.dart';
import 'blocs/adopt/adopt_event.dart';
import 'blocs/pet_bloc.dart';
import 'blocs/pet_event.dart';
import 'blocs/search/search_cubit.dart';
import 'core/theme.dart';
import 'repo/pet_repository.dart';
import 'core/services/local_storage.dart';
import 'views/favorites/bloc/fav_bloc.dart';
import 'views/favorites/bloc/fav_event.dart';
import 'widgets/bottom_nav/bottom_nav_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final localStorage = LocalStorageService();
  final hasSeenOnboarding = await localStorage.getStatus('seen_onboarding') ?? false;

  runApp(MyApp(showOnboarding: !hasSeenOnboarding, localStorage: localStorage,));
}

class MyApp extends StatelessWidget {
  final bool showOnboarding;
  final LocalStorageService localStorage;

  const MyApp({
    super.key,
    required this.showOnboarding,
    required this.localStorage,
  });

  @override
  Widget build(BuildContext context) {
    final petRepository = PetRepository(localStorage);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => OnBoardingCubit()),
        BlocProvider(create: (_) => CategoryCubit()),
        BlocProvider(create: (_) => NavCubit()),
        BlocProvider(create: (_) => SearchCubit()),
        BlocProvider(create: (_) => PetBloc(petRepository)..add(FetchPets())),
        BlocProvider(create: (_) => FavoriteBloc(petRepository)..add(LoadFavorites())),
        BlocProvider(create: (_) => AdoptionBloc(localStorage)..add(LoadAdoptedPets())),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRoute.router(showOnboarding),
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
      ),
    );
  }
}
