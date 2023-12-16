import '../exports/exports.dart';

class NoData extends StatelessWidget {
  const NoData({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/empty.svg",
            width: 300,
            height: 300,
          ),
          Text(
            "No match dates found",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}
