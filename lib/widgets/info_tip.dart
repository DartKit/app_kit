

import '../core/kt_export.dart';

class InfoTip extends StatelessWidget {
  const InfoTip(this.text,{super.key,this.height,this.fontSize,this.color});
  final String text;
  final double? height;
  final double? fontSize;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return _tip();
  }
  Widget _tip (){
    if(text.isEmpty) return SizedBox();
    return Container(
      height: height??24.r,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Color(0xFFF8F3EB),
      ),
      child: Row(
        children: [
          SizedBox(width: 19.r,),
          Icon(Icons.info,size: 16.r,color: C.orange,),
          SizedBox(width: 5.r,),
          Text(text,style: TextStyle(fontSize: fontSize??11.r,color: color??C.orange),)
        ],
      ),
    );
  }
}
