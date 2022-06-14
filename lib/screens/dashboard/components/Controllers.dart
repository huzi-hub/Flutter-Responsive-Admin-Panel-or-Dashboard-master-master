import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class NotesController {
  String BASE_URL = "https://edonations.000webhostapp.com/getdonations.php";
  Dio dio = Dio();

  Future<List> getNotes() async {
    try {
      var response = await dio.get(BASE_URL);

      return response.data['data'];
    } on DioError catch (e) {
      print(e);
      return Future.error("Error Fetching your Notes");
    }
  }

//   Future<List> fetchDonationNum() async {
//   final response = await http.get(
//       Uri.parse('https://edonations.000webhostapp.com/getngos.php'));
//   var msg = jsonDecode(response.body);
//   return msg[0]['data'];
// }

  createNote(String note) async {
    try {
      await dio.post("http://10.0.2.2:7882/notesapp/",
          data: jsonEncode({
            'note': note,
          }),
          options: Options(
            headers: {
              "Content-Type": "application/json",
            },
          ));
    } on DioError catch (e) {
      print(e);
      return Future.error("Error inserting your Notes");
    }
  }

  deleteNote(String id) async {
    try {
      await dio.delete("https://edonations.000webhostapp.com/getdonations.php",
          data: jsonEncode({
            'donation_id': id,
          }),
          options: Options(
            headers: {
              "Content-Type": "application/json",
            },
          ));
    } on DioError catch (e) {
      print(e);
      return Future.error("Error deleting your Notes");
    }
  }

  updateNote(String id, String note) async {
    try {
      await dio.put(
        "http://10.0.2.2:7882/notesapp/",
        data: jsonEncode(
          {
            "id": id,
            "note": note,
          },
        ),
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );
    } on DioError catch (e) {
      print(e);
      return Future.error("Error Updating your Notes");
    }
  }

  Future<List> getNgos() async {
    String BASE_URL_TWO = "https://edonations.000webhostapp.com/getngos.php";
    Dio dio_one = Dio();
    try {
      var response = await dio_one.get(BASE_URL_TWO);

      return response.data['data'];
    } on DioError catch (e) {
      print(e);
      return Future.error("Error Fetching your Notes");
    }
  }

  Future<List> getPendingDonations() async {
    String BASE_URL_TWO =
        "https://edonations.000webhostapp.com/api-all-donations.php";
    Dio dio_one = Dio();
    try {
      var response = await dio_one.get(BASE_URL_TWO);

      return response.data;
    } on DioError catch (e) {
      print(e);
      return Future.error("Error Fetching your Notes");
    }
  }

  Future<List> getDonors() async {
    String BASE_URL_THREE =
        "https://edonations.000webhostapp.com/getdonors.php";
    Dio dio_two = Dio();
    try {
      var response = await dio_two.get(BASE_URL_THREE);

      return response.data['data'];
    } on DioError catch (e) {
      print(e);
      return Future.error("Error Fetching your Notes");
    }
  }
}
