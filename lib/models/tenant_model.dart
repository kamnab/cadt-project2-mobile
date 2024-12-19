import 'dart:convert';

List<Tenant> tenantFromJson(String str) =>
    List<Tenant>.from(json.decode(str).map((x) => Tenant.fromJson(x)));

String tenantToJson(List<Tenant> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tenant {
  final String id;
  final String name;
  final String description;

  Tenant({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Tenant.fromJson(Map<String, dynamic> json) => Tenant(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() =>
      {"_id": id, "name": name, "description": description};
}
