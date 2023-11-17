import 'package:soccer/views/pages/teamPages/table_row_widget.dart';

import '/exports/exports.dart';

class TablePage extends StatefulWidget {
  const TablePage({super.key});

  @override
  State<TablePage> createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        child: DataTable(
          columns: const [
            DataColumn(label: Text("#")),
            DataColumn(label: Text("P")),
            DataColumn(label: Text("W")),
            DataColumn(label: Text("D")),
            DataColumn(label: Text("L")),
            DataColumn(label: Text("GD")),
            DataColumn(label: Text("Pts")),
          ],
          rows: List.generate(
            10,
            (index) => TableRowWidget.drawDatRow(
              context,
              color:
                  index % 2 == 0 ? Colors.grey.shade300 : Colors.grey.shade50,
              id: index + 1,
            ),
          ),
        ),
      ),
    );
  }
}
