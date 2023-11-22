import '/exports/exports.dart';

class TableRowWidget {
  static TableRow draw(
    BuildContext context, {
    Color? color,
  }) {
    return TableRow(
      decoration: BoxDecoration(
        color: color,
      ),
      children: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text("#"),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text(""),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text("P"),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text("W"),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text("D"),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text("L"),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text("GD"),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text("Pts"),
          ),
        ),
      ],
    );
  }

  static TableRow drawData(
    BuildContext context, {
    Color? color,
    int? id,
    int? p,
    int? w,
    int? d,
    int? l,
    int? gd,
    int? pts,
  }) {
    return TableRow(
      decoration: BoxDecoration(
        color: color,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text(
              "$id",
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(0),
          child: TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Image.asset(
              "assets/leagues/komafo.jpeg",
              width: 35,
              height: 35,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text("$p"),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text("$w"),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text("$d"),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text("$l"),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text("$gd"),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text("$pts"),
          ),
        ),
      ],
    );
  }

  static DataRow drawDatRow(
    BuildContext context, {
    Color? color,
    required String image,
    int? id,
    int? p,
    int? w,
    int? d,
    int? l,
    int? gd,
    int? pts,
  }) {
    return DataRow(
      color: MaterialStateProperty.all(color),
      cells: [
        DataCell(
          Row(
            children: [
              Text("$id"),
             const SizedBox.square(
                dimension: 10,
              ),
              Image.network(
              Apis.image + image,
                width: 35,
                height: 35,
              )
            ],
          ),
        ),
        DataCell(Text("$p")),
        DataCell(Text("$w")),
        DataCell(Text("$d")),
        DataCell(Text("$l")),
        DataCell(Text("$gd")),
        DataCell(Text("$pts")),
      ],
    );
  }
}
