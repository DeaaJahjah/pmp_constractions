import 'package:flutter/cupertino.dart';
import 'package:pmpconstractions/features/home_screen/services/client_db_service.dart';
import 'package:pmpconstractions/features/home_screen/services/company_db_service.dart';
import 'package:pmpconstractions/features/home_screen/services/engineer_db_service.dart';

class UserCredentialProvider extends ChangeNotifier {
  var user;

  setUser(String id, String userType) async {
    switch (userType) {
      case 'engineer':
        user = await EngineerDbService().getEngineerById(id);
        break;
      case 'company':
        user = await CompanyDbService().getCompanyById(id);
        break;
      case 'client':
        user = await ClientDbService().getClientById(id);
        break;
    }
    notifyListeners();
  }
}
