import 'package:get_it/get_it.dart';

import '../../cubit/auth_status/auth_status_cubit.dart';
import '../../cubit/counter/counter_cubit.dart';
import '../../cubit/login/login_cubit.dart';
import '../../cubit/register/register_cubit.dart';
import '../../cubit/reset_password/reset_password_cubit.dart';
import '../../firebase/firestore_service.dart';

final locator = GetIt.instance;

void locatorSetup() {
  locator.registerLazySingleton<LoginCubit>(() => LoginCubit());
  locator.registerLazySingleton<RegisterCubit>(() => RegisterCubit());
  locator.registerLazySingleton<AuthStatusCubit>(() => AuthStatusCubit());
  locator.registerLazySingleton<ResetPasswordCubit>(() => ResetPasswordCubit());
  locator.registerLazySingleton<CounterCubit>(
      () => CounterCubit(FirestoreService()));
}
