class Endpoints {
  static const baseUrl = 'http://localhost:8001';
  static const signIn = '$baseUrl/auth/signin';
  static const signUp = '$baseUrl/auth/signup';
  static const createSchedule = '$baseUrl/createSchedule';
  static const updateSchedule = '$baseUrl/updateSchedule';
  static const getUsersByRole = '$baseUrl/getUsersByRole';
  static const getAllProgramByAdmin = '$baseUrl/getAllProgramByAdmin';
  static const getProgramByAdmin = '$baseUrl/getProgramByAdmin';
  static const getAllProgramByUser = '$baseUrl/getAllProgramByUser';
  static const createTask = '$baseUrl/createTask';
  static const updateTask = '$baseUrl/updateTask';
  static const getTask = '$baseUrl/getTask';
  static const getTaskByEmployee = '$baseUrl/getTaskByEmployee';
  static const getAllTaskByManager = '$baseUrl/getAllTaskByManager';
  static const getAllTaskByUser = '$baseUrl/getAllTaskByUser';
  static const updateTaskStatus = '$baseUrl/updateTaskStatus';
}
