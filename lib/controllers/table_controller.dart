import '../models/table_model.dart';
import '../services/table_service.dart';
import '/exports/exports.dart';

class TableController with ChangeNotifier {
  bool _loading = true;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  List<Message> _tableData = [];
  List<Message> get tableData => _tableData;
  void fetchData(String league) {
    TableService().getTeams(league).then((value) {
      _tableData = value;
      loading = false;
      notifyListeners();
    });
  }
}
