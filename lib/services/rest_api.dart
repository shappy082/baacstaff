import 'dart:convert';

import 'package:http/http.dart' as http;

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
}
