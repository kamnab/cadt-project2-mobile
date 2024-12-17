import 'dart:convert';

TenantModel TenantModelFromJson(String str) {
  return TenantModel.fromJson(json.decode(str));
}

String TenantModelToJson(TenantModel data) => json.encode(data.toJson());

class TenantModel {
  List<TenantResponse> tenants;

  TenantModel({
    required this.tenants,
  });

  factory TenantModel.fromJson(Map<String, dynamic> json) {
    //print(json);

    return TenantModel(
        tenants: List<TenantResponse>.from(
            json["tenants"].map((x) => TenantResponse.fromJson(x))));
  }

  Map<String, dynamic> toJson() => {
        "tenants": List<dynamic>.from(tenants.map((x) => x.toJson())),
      };
}

class TenantResponse {
  String id;
  String name;
  String description;

  TenantResponse({
    required this.id,
    required this.name,
    required this.description,
  });

  factory TenantResponse.fromJson(Map<String, dynamic> json) => TenantResponse(
        id: json["_id"],
        name: json["name"],
        description: json["description"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
      };
}
