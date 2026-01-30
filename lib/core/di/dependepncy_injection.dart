// household-management-system/lib/core/di/dependency_injection.dart

final getIt = GetIt.instance;

void setupDependencies() {
  // Регистрация зависимостей
  getIt.registerSingleton<TaskRepository>(TaskRepositoryImpl());
  getIt.registerSingleton<ScheduleRepository>(ScheduleRepositoryImpl());
}
