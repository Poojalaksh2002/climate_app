import 'dart:convert';

import 'package:http/http.dart' as http;

class Networking {
  Networking(this.url);
  final String url;

  Future fetchData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = response.body;
      var decodedJsonData = jsonDecode(data);
      return decodedJsonData;
    } else {
      print(response.statusCode);
    }
  }
}
