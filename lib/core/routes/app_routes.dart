// household-management-system/lib/core/routes/app_routes.dart

class AppRoutes {
  static const String home = '/';
  static const String tasks = '/tasks';
  static const String schedule = '/schedule';
  static const String taskDetail = '/tasks/:id';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final uri = Uri.parse(settings.name ?? '');
    final args = settings.arguments;

    switch (uri.path) {
      case home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case tasks:
        return MaterialPageRoute(builder: (_) => TasksPage());
      case schedule:
        return MaterialPageRoute(builder: (_) => SchedulePage());
      case taskDetail:
        final taskId = uri.pathSegments.last;
        return MaterialPageRoute(
          builder: (_) => TaskDetailPage(taskId: taskId),
        );
      default:
        return MaterialPageRoute(builder: (_) => NotFoundPage());
    }
  }
}
