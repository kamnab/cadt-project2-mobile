import 'package:cadt_project2_mobile/models/tenant_model.dart';
import 'package:flutter/material.dart';

import 'tenant_service.dart';

class TenantLogic extends ChangeNotifier {
  List<Tenant> _tenantModel = [];
  List<Tenant> get tenants => _tenantModel;

  bool _loading = false;
  bool get loading => _loading;

  void enableLoading() {
    _errorMessage = null;
    _loading = true;
    notifyListeners();
  }

  void disableLoading() {
    _loading = false;
    notifyListeners();
  }

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetch(String? token) async {
    enableLoading();
    try {
      _tenantModel = await TenantService.readData(token);
    } catch (e) {
      _errorMessage = e.toString();
    }

    disableLoading();
    notifyListeners();
  }
}
