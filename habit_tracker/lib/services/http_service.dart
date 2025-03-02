import "package:dio/dio.dart";
import "dart:convert";
import "../models/habit_model.dart";

//no password validation for simplicity's sake. anyway not production app.

class HTTPService {

  static final HTTPService _singleton = HTTPService._internal();

  final _dio = Dio();

  factory HTTPService() {
    return _singleton; 
  }

  HTTPService._internal() {
    setup();
  }

  Future<void> setup() async {

    final headers = {
      "Content-Type": "application/json",
    };

    final options = BaseOptions( 
      baseUrl: "http://localhost:3000/",
      headers: headers,
      validateStatus: (status) {
        if (status == null){
          return false;
        } 
        return status < 500;
      }
    );

    _dio.options = options;

  }

  Future<Response?> login(Map data) async { //user successfully login, user exists but password wrong, user does not exist
    try {
      var response = await _dio.post('/login', data:jsonEncode(data));
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Response?> signup(Map data) async { //user successfully signs up, user already exists
    try {
      var response = await _dio.post('/signup', data:jsonEncode(data));
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<HabitModel>?> getHabits(String username) async { //get habits of the specified user.
    try {
      var response = await _dio.get('/habits/$username'); 
      
      if (response.statusCode == 200) {
        List data = response.data;
        List<HabitModel> habits = data.map((e)=> HabitModel.fromJson(e)).toList();
        print(habits);
        return habits;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}