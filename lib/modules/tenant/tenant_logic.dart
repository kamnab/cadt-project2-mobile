import 'package:cadt_project2_mobile/models/tenant_model.dart';
import 'package:flutter/material.dart';

import 'tenant_service.dart';

class TenantLogic extends ChangeNotifier {
  TenantModel _tenantModel = TenantModel(tenants: []);
  TenantModel get tenant => _tenantModel;

  bool _loading = false;
  bool get loading => _loading;

  void enableLoading() {
    _loading = true;
    notifyListeners();
  }

  void disableLoading() {
    _loading = false;
    notifyListeners();
  }

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetch() async {
    enableLoading();
    try {
      TenantModel response = await TenantService.readData();
      _tenantModel = response;
    } catch (e) {
      _errorMessage = e.toString();
    }

    disableLoading();
    notifyListeners();
  }
}
