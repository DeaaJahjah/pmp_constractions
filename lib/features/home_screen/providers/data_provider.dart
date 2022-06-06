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
  List<Client> clients = [];

  fetchData() async {
    await fetchProjects();
    await fetchClients();
    await fetchEngineers();
    await fetchCompanies();
  }

  fetchProjects() async {
    projects = await ProjectDbService().getProjects();
    notifyListeners();
  }

  fetchEngineers() async {
    engineers = await EngineerDbService().getEngineers();
    notifyListeners();
  }

  fetchCompanies() async {
    companies = await CompanyDbService().getCompanies();
    notifyListeners();
  }

  fetchClients() async {
    clients = await ClientDbService().getClients();
    notifyListeners();
  }
}
