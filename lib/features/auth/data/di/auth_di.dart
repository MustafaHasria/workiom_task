import 'package:get_it/get_it.dart';
import 'package:workiom_task/core/network/network_client.dart';
import 'package:workiom_task/core/storage/token_storage.dart';
import 'package:workiom_task/features/auth/data/repository/auth_repository_impl.dart';
import 'package:workiom_task/features/auth/domain/repository/auth_repository.dart';
import 'package:workiom_task/features/auth/presentation/bloc/auth_bloc.dart';


final getIt = GetIt.instance;

void setupAuthDependencies() {
  //* Core dependencies
  if (!getIt.isRegistered<TokenStorage>()) {
    getIt.registerLazySingleton<TokenStorage>(() => TokenStorage());
  }

  if (!getIt.isRegistered<NetworkClient>()) {
    getIt.registerLazySingleton<NetworkClient>(
      () => NetworkClient(getIt<TokenStorage>()),
    );
  }

  //* Data layer
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      getIt<NetworkClient>(),
      getIt<TokenStorage>(),
    ),
  );

  //* Presentation layer (BLoC)
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(getIt<AuthRepository>()),
  );
}

