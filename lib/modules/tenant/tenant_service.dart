import 'dart:convert';
import 'package:cadt_project2_mobile/models/tenant_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

//android, change from localhost -> 10.0.2.2
//https://api.talkemie.app/v1/public/files
const someUrl =
    "https://cadt-project2-backend-967d3b0aaf48.herokuapp.com/tenants";

class TenantService {
  static Future<TenantModel> readData() async {
    http.Response response = await http.post(Uri.parse(someUrl));
    // print(response.body);
    // Map map = json.decode(response.body);
    // bool success = map['success'];

    return compute(TenantModelFromJson, response.body);
  }
}
