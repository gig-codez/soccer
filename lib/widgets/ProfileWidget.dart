import '/exports/exports.dart';

class ProfileWidget extends StatelessWidget {
  final String titleText;
  final String? subText;
  final Color? color;
  final VoidCallback? onPress;
  final VoidCallback? editProfile;
  final void Function()? onLongPress;
  final IconData? icon;
  final Widget? trailing;
  final double size;
  final bool tile;
  final String? img;
  final double iconSize;
  final String? prefixIcon;
  const ProfileWidget({
    super.key,
    required this.titleText,
    this.subText,
    this.prefixIcon,
    this.color,
    this.icon,
    this.editProfile,
    this.size = 30,
    this.iconSize = 35,
    this.tile = false,
    this.img,
    this.onPress,
    this.onLongPress,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return tile == true
        ? TapEffect(
            onClick: onPress ?? () {},
            child: Card(
              elevation: 0,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey.shade100
                  : Colors.white12,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: color?.withOpacity(0.13),
                      radius: size,
                      backgroundImage: img == null ? null : NetworkImage(img!),
                      child: prefixIcon != null
                          ? SvgPicture.asset(
                              prefixIcon ?? "assets/football.svg",
                              width: iconSize,
                              height: iconSize,
                              color: color,
                            )
                          : null,
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "$titleText\n",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                          ),
                          subText != null
                              ? TextSpan(
                                  text: "$subText",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16,
                                      ),
                                )
                              : const TextSpan(text: ""),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: editProfile,
                      icon: Icon(icon),
                    )
                  ],
                ),
              ),
            ),
          )
        : TapEffect(
            isClickable: false,
            onClick: onPress ?? () {},
            child: Card(
              elevation: 0,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey.shade100
                  : Colors.white12,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  bottom: 8.0,
                ),
                child: ListTile(
                  onTap: onPress,
                  onLongPress: onLongPress,
                  leading: CircleAvatar(
                    radius: size,
                    backgroundColor: color?.withOpacity(0.12),
                    backgroundImage: img == null ? null : NetworkImage(img!),
                    child: prefixIcon != null
                        ? SvgPicture.asset(
                            prefixIcon ?? "assets/football.svg",
                            width: iconSize,
                            height: iconSize,
                            color: color,
                          )
                        : null,
                  ),
                  title: Text(
                    titleText,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  trailing: trailing,
                ),
              ),
            ),
          );
  }
}
