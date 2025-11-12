import 'package:app_kit/core/kt_dao.dart';
import '../../core/kt_export.dart';
import '../button/scale_button.dart';
// import '../core/kt_export.dart' show StatelessWidget, Size, Color, BuildContext, Widget, MainAxisAlignment, CrossAxisAlignment, MainAxisSize, SizeExtension, CoImage, SizedBox, C, MainText, CircularProgressIndicator, Center, AppFont, TextStyle, Text, Column, Obx, logs, GestureDetector;


class NoData extends StatelessWidget {
  final double gapBottom;
  final String errCover;
  final String errTip;
  final Size? size;
  final Color? color;
  const NoData({super.key, this.call, this.gapBottom = 60,this.color, this.size,this.errTip = '页面跑空啦，暂无数据！',this.errCover = ''});

  final Function? call;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          logs('--GestureDetector');
          if (call != null) call!();
        },
        child: Obx(
              () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CoImage(kdao.noNet.isTrue?'lib/asts/images/no_net.png' : (errCover.isNotEmpty? errCover: 'lib/asts/images/no_data.png'),circular: 8.r,width: size?.width??250.r,height: size?.height??183.r,color: color,),
              SizedBox(height: 10.r),
              MainText(
                kdao.inReq.isTrue ? ('正在刷新...') : (kdao.noNet.isTrue ? '当前无网络，请检查网络连接~' : errTip.isNotEmpty?errTip:'暂无内容'),
                color: Color(0xFF666666),
                fontSize: 15.r,
              ),
              SizedBox(height: 15.r),
              if ((call != null) && kdao.noNet.isFalse)
                kdao.inReq.isTrue
                    ? SizedBox(
                    height: 23.r,
                    width: 23.r,
                    child: Center(
                      child: SizedBox(
                        height: 12.r,
                        width: 12.r,
                        child: CircularProgressIndicator(
                          strokeWidth: 1.5.r,
                          color: Color(0xFF2F3933)
                        ),
                      ),
                    ))
                    : ScaButton(

                  child: Container(
                      width: 112.r,
                      height: 29.r,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(29.r/2),
                        border: Border.all(width: 1.r,color: Color(0xFF989DAF)),
                      ),
                      child: Text('刷新一下', style: TextStyle(color: Color(0xFF2F3933), fontSize: 13.r, fontWeight: AppFont.medium))),
                  onTap: () {
                    kdao.inReq.value = true;
                    if (call != null) call!();
                  },
                ),
              SizedBox(height: gapBottom.r),
            ],
          ),
        ),
      ),
    );
  }
}
