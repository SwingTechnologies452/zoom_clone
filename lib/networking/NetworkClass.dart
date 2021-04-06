import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:zoom_clone/models/get_config_model.dart';
import 'package:zoom_clone/models/meeting_mode.dart';
import 'package:zoom_clone/networking/Config.dart';

class NetworkClass {
  Dio dio = Dio();

  //Note: Retrive app config from server
  Future<GetConfigModel> getAppConfig() async {
    try {
      final response = await dio
          .get("${Config.baseUrl}/api/v100/config?API-KEY=${Config.apiKey}");
      if (response.statusCode == 200) {
        GetConfigModel getConfigModel = GetConfigModel.fromJson(response.data);
        print("DATA: " + getConfigModel.toJson().toString());
        return getConfigModel;
      }
    } catch (ex) {
      print("ERROR: " + ex.toString());
      return null;
    }
  }

  Future<MeetingModel> joinMeeting(
      {String meetingCode, String userId, String nickName}) async {
    dio.options.headers = {"API-KEY": Config.apiKey};
    FormData formData = new FormData.fromMap({
      "meeting_code": meetingCode,
      "user_id": userId,
      "nick_name": nickName
    });
    try {
      final response = await dio
          .post("${Config.baseUrl}/api/v100/join_meetting/", data: formData);
      MeetingModel joinResponse = MeetingModel.fromJson(response.data);
      if (joinResponse.status == 'success') {
        return joinResponse;
      } else {
        // showShortToast(response.data['message']);
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<MeetingModel> hostMeeting(
      {String meetingCode, String userId, String meetingTitle}) async {
    dio.options.headers = {"API-KEY": Config.apiKey};
    FormData formData = new FormData.fromMap({
      "meeting_code": meetingCode,
      "user_id": userId,
      "meeting_title": meetingTitle,
    });
    try {
      final response = await dio.post(
          "${Config.baseUrl}/api/v100/create_and_join_meetting/",
          data: formData);
      MeetingModel joinResponse = MeetingModel.fromJson(response.data);
      if (joinResponse.status == 'success') {
        return joinResponse;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
