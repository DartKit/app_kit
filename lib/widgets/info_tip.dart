

import '../core/kt_export.dart';

class InfoTip extends StatelessWidget {
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? fontSize;
  final double? iconSize;
  final String title;
  final String sub_title;
  final double? height;
  final VoidCallback? call;
  final Color? color;
  const InfoTip(this.title, {super.key, this.sub_title = '', this.call,this.padding,this.margin,this.fontSize,this.iconSize,this.height,this.color});

  
  @override
  Widget build(BuildContext context) {
    return _tip();
  }
  Widget _tip (){
    if(title.isEmpty) return SizedBox();
    return Container(
      height: height??24.r,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Color(0xFFF8F3EB),
      ),
      child: GestureDetector(
        onTap: (){
          if (call != null) call?.call();
        },
        child: Row(
          children: [
            SizedBox(width: 15.r,),
            Icon(Icons.info,size: iconSize??16.r,color: CC.orange,),
            SizedBox(width: 5.r,),
            Text(title,style: TextStyle(fontSize: fontSize??11.r,color: color??CC.orange),),
            if (sub_title.isNotEmpty) Text(sub_title,style: TextStyle(fontSize: 9.r,color: color??CC.orange),)
          ],
        ),
      ),
    );
  }
}
