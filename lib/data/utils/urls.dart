class Urls{
  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static const String registrationUrl = '$_baseUrl/registration';
  static const String loginUrl = '$_baseUrl/login';
  static const String createNewTaskUrl = '$_baseUrl/createTask';
  static const String taskCountByStatusUrl = '$_baseUrl/taskStatusCount';
  static  String taskListByStatusUrl(String status) => '$_baseUrl/listTaskByStatus/$status';
  static String deleteTask(String id) => '$_baseUrl/deleteTask/$id';
  static String updateStatusTask(String id,String status) => '$_baseUrl/updateTaskStatus/$id/$status';



}