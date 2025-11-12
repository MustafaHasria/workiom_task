import 'package:workiom_task/features/auth/data/di/auth_di.dart';

//? App-level dependency injection setup
class AppDependencies {
  static void init() {
    //* Initialize auth dependencies
    setupAuthDependencies();

    //TODO: Add other feature dependencies here
  }
}

