import 'package:app_kit/core/kt_export.dart';

class MineCell extends StatelessWidget {
  const MineCell(
      {super.key,
      required this.name,
      required this.icon,
      required this.callback,
      this.subTitle = '',
      this.tail,
      this.son,
      this.arrow = false});
  final String name;
  final IconData icon;
  final Function callback;
  final String subTitle;
  final Widget? tail;
  final Widget? son;
  final bool arrow;

  @override
  Widget build(BuildContext context) {
    return _cell();
  }

  Widget _cell() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.r, vertical: 5.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(width: 1.r, color: CC.line),
      ),
      child: InkWell(
        onTap: () => callback(),
        borderRadius: BorderRadius.circular(10.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.r, vertical: 12.r),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Icon(icon),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlackText(name),
                        MainText(
                          subTitle,
                          fontSize: 12.r,
                          color: CC.lightGrey,
                        ),
                      ],
                    ),
                  ),
                  if (tail != null) tail!,
                  if (arrow) Icon(Icons.arrow_forward_ios_rounded),
                ],
              ),
              son ?? Container(),
            ],
          ),
        ),
      ),
    );
  }
}
