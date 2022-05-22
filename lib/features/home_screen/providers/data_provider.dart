import 'package:flutter/material.dart';
import 'package:pmpconstractions/features/home_screen/models/client.dart';
import 'package:pmpconstractions/features/home_screen/models/company.dart';
import 'package:pmpconstractions/features/home_screen/models/engineer.dart';
import 'package:pmpconstractions/features/home_screen/models/project.dart';
import 'package:pmpconstractions/features/home_screen/services/client_db_service.dart';
import 'package:pmpconstractions/features/home_screen/services/company_db_service.dart';
import 'package:pmpconstractions/features/home_screen/services/engineer_db_service.dart';
import 'package:pmpconstractions/features/home_screen/services/project_db_service.dart';

class DataProvider extends ChangeNotifier {
  List<Project> projects = [];
  List<Company> companies = [];
  List<Engineer> engineers = [];
  List<Client> clients= [];

  fetchData() async {
    projects = await ProjectDbService().getProjects();
    companies = await CompanyDbService().getCompanies();
    engineers = await EngineerDbService().getEngineers();
    clients   =  await ClientDbService().getClients();

    print('Projects lenght ${projects.length}');
    print('companies lenght ${companies.length}');
    print('engineers lenght ${engineers.length}');
    notifyListeners();
  }
}
