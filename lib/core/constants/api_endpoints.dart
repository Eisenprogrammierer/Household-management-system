// household-management-system/lib/core/constants/api_endpoints.dart

/// API для управления основными сущностями домохозяйства.
///
/// Конечные точки:
///
/// * [TasksApi] - Работа с задачами
/// * [UsersApi] - Управление пользователями
/// * [DevicesApi] - Управление устройствами
/// * [SchedulesApi] - Управление расписаниями
/// * [HouseholdsApi] - Управление домохозяйствами
/// * [TransactionsApi] - Управление передачами данных
/// * [ReportsApi] - Управление сообщениями об ошибках


import 'package:http/http.dart' as http;
import 'dart:convert';

const basePath = '/api';
const endpoints = [
  'tasks', 'users', 'schedules', 'devices', 'transactions', 'households',
  'budget', 'reports'
];
final apiEndpoints = Map.fromEntries(
  endpoints.map((endpoint) => MapEntry(endpoint, '$basePath/$endpoint'))
);

// Кастомное исключение для API ошибок
class ApiException implements Exception {
  final int statusCode;
  final String message;
  final String path;
  final String method;
  
  ApiException(this.statusCode, this.message, this.path, this.method);
  
  @override
  String toString() {
    return 'ApiException(status: $statusCode, message: $message, path: $path, method: $method)';
  }
}

// Класс для управления HTTP-запросами с обработкой ошибок
class ApiClient {
  final http.Client client;
  final String baseUrl;
  
  ApiClient(this.baseUrl) : client = http.Client();
  
  // Обработка GET запросов
  Future<Map<String, dynamic>> get(String path) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl$path'),
        headers: {'Content-Type': 'application/json'},
      );
      
      _handleHttpError(response, 'GET', path);
      return json.decode(response.body);
    } catch (e) {
      throw ApiException(-1, 'Network error: $e', path, 'GET');
    }
  }
  
  // Обработка POST запросов
  Future<Map<String, dynamic>> post(String path, dynamic data) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl$path'),
        body: json.encode(data),
        headers: {'Content-Type': 'application/json'},
      );
      
      _handleHttpError(response, 'POST', path);
      return json.decode(response.body);
    } catch (e) {
      throw ApiException(-1, 'Network error: $e', path, 'POST');
    }
  }
  
  // Обработка PUT запросов
  Future<Map<String, dynamic>> put(String path, dynamic data) async {
    try {
      final response = await client.put(
        Uri.parse('$baseUrl$path'),
        body: json.encode(data),
        headers: {'Content-Type': 'application/json'},
      );
      
      _handleHttpError(response, 'PUT', path);
      return json.decode(response.body);
    } catch (e) {
      throw ApiException(-1, 'Network error: $e', path, 'PUT');
    }
  }
  
  // Обработка DELETE запросов
  Future<void> delete(String path) async {
    try {
      final response = await client.delete(
        Uri.parse('$baseUrl$path'),
        headers: {'Content-Type': 'application/json'},
      );
      
      _handleHttpError(response, 'DELETE', path);
    } catch (e) {
      throw ApiException(-1, 'Network error: $e', path, 'DELETE');
    }
  }
  
  // Обработка ошибок HTTP
  void _handleHttpError(http.Response response, String method, String path) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        // Успешные ответы - ничего не делаем
        break;
      case 400:
        throw ApiException(response.statusCode, 'Bad Request: ${response.body}', path, method);
      case 401:
        throw ApiException(response.statusCode, 'Unauthorized: ${response.body}', path, method);
      case 403:
        throw ApiException(response.statusCode, 'Forbidden: ${response.body}', path, method);
      case 404:
        throw ApiException(response.statusCode, 'Not Found: ${response.body}', path, method);
      case 409:
        throw ApiException(response.statusCode, 'Conflict: ${response.body}', path, method);
      case 500:
        throw ApiException(response.statusCode, 'Internal Server Error: ${response.body}', path, method);
      case 502:
        throw ApiException(response.statusCode, 'Bad Gateway: ${response.body}', path, method);
      case 503:
        throw ApiException(response.statusCode, 'Service Unavailable: ${response.body}', path, method);
      default:
        throw ApiException(response.statusCode, 'HTTP Error ${response.statusCode}: ${response.body}', path, method);
    }
  }
  
  // Закрытие клиента
  void dispose() {
    client.close();
  }
}

// Абстрактный класс для реализации классов конечных точек API
abstract class ApiEndpoint {
  final String baseUrl;
  final ApiClient apiClient;

  ApiEndpoint(this.baseUrl, this.apiClient);

  Future<Map<String, dynamic>> get(String path) async {
    return await apiClient.get(path);
  }

  Future<Map<String, dynamic>> post(String path, dynamic data) async {
    return await apiClient.post(path, data);
  }

  Future<Map<String, dynamic>> put(String path, dynamic data) async {
    return await apiClient.put(path, data);
  }

  Future<void> delete(String path) async {
    await apiClient.delete(path);
  }
}

/// Класс для работы с задачами через API.
///
/// Предоставляет методы для выполнения CRUD операций над задачами.
class TasksApi extends ApiEndpoint {
  /// Создаёт экземпляр [TasksApi] с указанным базовым URL.
  TasksApi(String baseUrl, ApiClient apiClient) : super(baseUrl, apiClient);

  /// Получает список задач
  ///
  /// Возвращает [List<Task>]
  Future<List<Task>> getTasks() async { 
    final response = await get('/tasks');
    return (response['data'] as List).map((json) => Task.fromJson(json)).toList();
  }

  /// Создаёт новую задачу
  ///
  /// [task] - объект задачи для создания
  /// Возвращает созданный объект [Task]
  Future<Task> createTask(Task task) async {
    final response = await post('/tasks', task.toJson());
    return Task.fromJson(response['data']);
  }

  /// Обновляет существующую задачу
  ///
  /// [id] - идентификатор задачи для обновления
  /// [task] - объект задачи с обновлёнными данными
  /// Возвращает обновленный объект [Task]
  Future<Task> updateTask(String id, Task task) async {
    final response = await put('/tasks/$id', task.toJson());
    return Task.fromJson(response['data']);
  }

  /// Удаляет задачу.
  ///
  /// [id] - идентификатор задачи для удаления.
  /// Кидает [Exception] при ошибке удаления.
  Future<void> deleteTask(String id) async {
    await delete('/tasks/$id');
  }
}

/// Класс для работы с пользовательскими профилями
///
/// Обеспечивает функциональность для работы с профилями пользователей
class UsersApi extends ApiEndpoint {
  /// Создаёт класс [UsersApi] с указанным базовым URL
  UsersApi(String baseUrl, ApiClient apiClient) : super(baseUrl, apiClient);

  /// Регистрирует нового пользователя
  ///
  /// [user] - объект пользователя для регистрации
  /// Возвращает новосозданный объект пользователя
  Future<User> registerUser(User user) async {
    final response = await post('/users/register', user.toJson());
    return User.fromJson(response['data']);
  }

  /// Авторизует пользователя
  ///
  /// [username] - имя пользователя
  /// [password] - пароль пользователя
  /// Возвращает объект [User] при успешной авторизации
  Future<User> loginUser(String username, String password) async {
    final response = await post('/users/login', {'username': username, 'password': password});
    return User.fromJson(response['data']);
  }

  /// Получает профиль пользователя
  ///
  /// Возвращает объект [User] с данными профиля
  Future<User> getUserProfile() async {
    final response = await get('/users/profile');
    return User.fromJson(response['data']);
  }

  /// Обновляет профиль пользователя
  ///
  /// [user] - объект пользователя с обновленными данными
  /// Возвращает обновленный объект [User]
  Future<User> updateUserProfile(User user) async {
    final response = await put('/users/profile', user.toJson());
    return User.fromJson(response['data']);
  }

  /// Удаляет пользователя
  ///
  /// [id] - идентификатор пользователя для удаления
  Future<void> deleteUser(String id) async {
    await delete('/users/$id');
  }
}

/// Класс для работы с расписаниями через API
///
/// Обеспечивает функциональность для управления расписаниями
class SchedulesApi extends ApiEndpoint {
  /// Создает экземпляр [SchedulesApi] с указанным базовым URL
  SchedulesApi(String baseUrl, ApiClient apiClient) : super(baseUrl, apiClient);

  /// Получает список расписаний
  ///
  /// Возвращает список объектов [Schedule]
  Future<List<Schedule>> getSchedules() async {
    final response = await get('/schedules');
    return (response['data'] as List).map((json) => Schedule.fromJson(json)).toList();
  }

  /// Создает новое расписание
  ///
  /// [schedule] - объект расписания для создания
  /// Возвращает созданный объект [Schedule]
  Future<Schedule> createSchedule(Schedule schedule) async {
    final response = await post('/schedules', schedule.toJson());
    return Schedule.fromJson(response['data']);
  }

  /// Обновляет данные расписания
  ///
  /// [id] - идентификатор расписания
  /// [schedule] - объект расписания с обновленными данными
  /// Возвращает обновленный объект [Schedule]
  Future<Schedule> updateSchedule(String id, Schedule schedule) async {
    final response = await put('/schedules/$id', schedule.toJson());
    return Schedule.fromJson(response['data']);
  }

  /// Удаляет расписание
  ///
  /// [id] - идентификатор расписания для удаления
  Future<void> deleteSchedule(String id) async {
    await delete('/schedules/$id');
  }
}

/// Класс для работы с домохозяйствами через API
///
/// Обеспечивает методы для выполнения CRUD операций над домохозяйствами
class HouseholdsApi extends ApiEndpoint {
  /// Создаёт экземпляр [HouseholdsApi] с указанным базовым URL
  HouseholdsApi(String baseUrl, ApiClient apiClient) : super(baseUrl, apiClient);

  /// Получает список домохозяйств
  ///
  /// Возвращает список объектов [Household]
  Future<List<Household>> getHouseholds() async {
    final response = await get('/households');
    return (response['data'] as List).map((json) => Household.fromJson(json)).toList();
  }

  /// Создает новое домохозяйство
  ///
  /// [household] - объект домохозяйства для создания
  /// Возвращает созданный объект [Household]
  Future<Household> createHousehold(Household household) async {
    final response = await post('/households', household.toJson());
    return Household.fromJson(response['data']);
  }

  /// Обновляет данные домохозяйства
  ///
  /// [id] - идентификатор домохозяйства
  /// [household] - объект домохозяйства с обновлёнными данными
  /// Возвращает обновлённый объект [Household]
  Future<Household> updateHousehold(String id, Household household) async {
    final response = await put('/households/$id', household.toJson());
    return Household.fromJson(response['data']);
  }

  /// Удаляет домохозяйство
  ///
  /// [id] - идентификатор домохозяйства для удаления
  Future<void> deleteHousehold(String id) async {
    await delete('/households/$id');
  }
}

/// Класс для работы с устройствами через API
///
/// Обеспечивает методы для выполнения CRUD операций над устройствами
class DevicesApi extends ApiEndpoint {
  /// Создаёт экземпляр [DevicesApi] с указанным базовым URL
  DevicesApi(String baseUrl, ApiClient apiClient) : super(baseUrl, apiClient);

  /// Получает список устройств
  ///
  /// Возвращает список объектов [Device]
  Future<List<Device>> getDevices() async {
    final response = await get(apiEndpoints['devices']!);
    return (response['data'] as List).map((json) => Device.fromJson(json)).toList();
  }

  /// Создаёт новое устройство
  ///
  /// [device] - объект устройства для создания
  /// Возвращает созданный объект [Device]
  Future<Device> createDevice(Device device) async {
    final response = await post(apiEndpoints['devices']!, device.toJson());
    return Device.fromJson(response['data']);
  }

  /// Обновляет данные устройства
  ///
  /// [id] - идентификатор устройства
  /// [device] - объект устройства с обновленными данными
  /// Возвращает обновленный объект [Device]
  Future<Device> updateDevice(String id, Device device) async {
    final response = await put('${apiEndpoints['devices']!}/$id', device.toJson());
    return Device.fromJson(response['data']);
  }

  /// Удаляет устройство
  ///
  /// [id] - идентификатор устройства для удаления
  Future<void> deleteDevice(String id) async {
    await delete('${apiEndpoints['devices']!}/$id');
  }
}

/// Класс для работы с бюджетами через API
///
/// Обеспечивает функциональность для управления бюджетами
class BudgetApi extends ApiEndpoint {
  /// Создает экземпляр [BudgetApi] с указанным базовым URL
  BudgetApi(String baseUrl, ApiClient apiClient) : super(baseUrl, apiClient);

  /// Получает текущий бюджет
  ///
  /// Возвращает объект [Budget]
  Future<Budget> getBudget() async {
    final response = await get('/budget');
    return Budget.fromJson(response['data']);
  }

  /// Обновляет данные бюджета
  ///
  /// [budget] - объект бюджета с обновлёнными данными
  /// Возвращает обновлённый объект [Budget]
  Future<Budget> updateBudget(Budget budget) async {
    final response = await put('/budget', budget.toJson());
    return Budget.fromJson(response['data']);
  }
}

/// Класс для работы с отчётами об ошибках через API
///
/// Обеспечивает функциональность для управления отчётами
class ReportsApi extends ApiEndpoint {
  /// Создает экземпляр [ReportsApi] с указанным базовым URL
  ReportsApi(String baseUrl, ApiClient apiClient) : super(baseUrl, apiClient);
  
  /// Получает список отчётов
  ///
  /// Возвращает список объектов [Report]
  Future<List<Report>> getReports() async {
    final response = await get('/reports');
    return (response['data'] as List).map((json) => Report.fromJson(json)).toList();
  }
}
