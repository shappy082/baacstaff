import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:baacstaff/models/register_model.dart';

class CallAPI {
  _setHeader() => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

// Register API
  final String baseApiURL =
      'https://www.itgenius.co.th/sandbox_api/baacstaffapi/public/api';

  postData(data, String apiURL) async {
    var url = baseApiURL + apiURL;
    return await http.post(
      url,
      body: jsonEncode(data),
      headers: _setHeader(),
    );
  }

  //read employee detail
  Future<RegisterModel> getEmployee(data) async {
    var url = baseApiURL + '/register';
    final response = await http.post(
      url,
      body: jsonEncode(data),
      headers: _setHeader(),
    );
    if (response.statusCode == 200) {
      return registerModelFromJson(response.body);
    } else {
      return null;
    }
  }
}
