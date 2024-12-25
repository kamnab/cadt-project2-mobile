import 'package:http/http.dart' as http;

import '../../models/tenant_model.dart';

//android, change from localhost -> 10.0.2.2
//https://api.talkemie.app/v1/public/files
const tenantListUrl =
    "https://cadt-project2-backend-967d3b0aaf48.herokuapp.com/tenants";

class TenantService {
  static Future<List<Tenant>> readData(String? token) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    http.Response response = await http.get(
      Uri.parse(tenantListUrl),
      headers: headers,
    );

    return tenantFromJson(response.body);
  }
}
