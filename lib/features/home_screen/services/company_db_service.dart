import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pmpconstractions/features/home_screen/models/company.dart';

class CompanyDbService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Company>> getCompanies() async {
    var queryData = await _db.collection('companies').get();
    List<Company> companies = [];

    for (var doc in queryData.docs) {
      companies.add(Company.fromFirestore(doc));
    }

    return companies;
  }

  Future<Company> getCompanyById(String id) async {
    var doc = await _db.collection('companies').doc(id).get();
    Map<String, dynamic>? cc = doc.data() as Map<String, dynamic>;

    return Company.fromJson(cc);
  }
}
