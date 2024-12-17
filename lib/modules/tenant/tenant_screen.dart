import 'package:cadt_project2_mobile/models/tenant_model.dart';
import 'package:cadt_project2_mobile/modules/tenant/tenant_logic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../login/login_logic.dart';

class TenantScreen extends StatefulWidget {
  const TenantScreen({super.key});

  @override
  State<TenantScreen> createState() => _TenantScreenState();
}

class _TenantScreenState extends State<TenantScreen> {
  @override
  Widget build(BuildContext context) {
    final authData = context.watch<LoginLogic>().authData;

    return Scaffold(
      appBar: AppBar(
        title: Text("Tenant Screen"),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    bool loading = context.watch<TenantLogic>().loading;
    String? errorMessage = context.watch<TenantLogic>().errorMessage;

    debugPrint("loading: $loading");

    if (loading) {
      return Center(child: CircularProgressIndicator());
    } else if (errorMessage != null) {
      return _buildError(errorMessage);
    } else {
      List<TenantResponse> items = context.watch<TenantLogic>().tenant.tenants;
      return _buildData(items);
    }
  }

  Widget _buildError(String errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(errorMessage),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<TenantLogic>().fetch();
            },
            child: Text("Retry"),
          ),
        ],
      ),
    );
  }

  Widget _buildData(List<TenantResponse> items) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<TenantLogic>().fetch();
      },
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return _buildItem(items[index]);
        },
      ),
    );
  }

  Widget _buildItem(TenantResponse item) {
    return Card(
      child: ListTile(
        // leading: SizedBox(
        //   width: 50,
        //   height: 50,
        //   child: CachedNetworkImage(
        //     //imageUrl: item.image,
        //     placeholder: (x, y) => Container(color: Colors.grey),
        //     errorWidget: (x, y, z) => Container(color: Colors.grey[900]),
        //   ),
        // ),
        title: Text("${item.name}"),
        subtitle: Text("${item.description}"),
      ),
    );
  }
}
