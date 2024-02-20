import '/exports/exports.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double buttonHeight;
  final double buttonRadius;
  final Color? buttonColor;
  final Color? textColor;
  final double opacity;
  final bool loading;
  final double? width;
  final FontWeight? fontWeight;
  final VoidCallback onPress;
  const CustomButton(
      {super.key,
      this.text = '',
      this.loading = false,
      required this.onPress,
      this.buttonHeight = 50,
      this.buttonRadius = 20,
      this.buttonColor,
      this.fontWeight,
      this.opacity = 0.12,
      this.textColor,
      this.width});

  @override
  Widget build(BuildContext context) {
    return TapEffect(
      onClick: onPress,
      child: Container(
        width: width ?? MediaQuery.of(context).size.width,
        height: buttonHeight,
        decoration: BoxDecoration(
          color: loading
              ? Theme.of(context).disabledColor
              : buttonColor ?? primaryColor.withOpacity(opacity),
          borderRadius: BorderRadius.circular(buttonRadius),
        ),
        child: Center(
          child: loading
              ? const CircularProgressIndicator.adaptive()
              : Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(color: textColor ?? primaryColor),
                  textAlign: TextAlign.center,
                ),
        ),
      ),
    );
  }
}
