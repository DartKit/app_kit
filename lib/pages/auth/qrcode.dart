import 'package:app_kit/core/kt_export.dart';
import 'package:app_kit/pages/auth/qrcode_layout.dart';
import 'package:app_kit/widgets/kit_view.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';
import '../tools/app_web.dart';

class QrCodePage extends StatefulWidget {
  const QrCodePage({super.key});

  @override
  State<QrCodePage> createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 3 * 2;

    return Scaffold(
      appBar: CoAppBar('扫一扫'),
      body: Stack(
        children: [
          QRCodeDartScanView(
              // scanInvertedQRCode:
              //     false, // enable scan invert qr code ( default = false)
              typeScan: TypeScan.live, // if TypeScan.takePicture will try decode when click to take a picture (default TypeScan.live)
              // takePictureButtonBuilder: (context,controller,isLoading){ // if typeScan == TypeScan.takePicture you can customize the button.
              //    if(loading) return CircularProgressIndicator();
              //    return ElevatedButton(
              //       onPressed:controller.takePictureAndDecode,
              //       child:Text('Take a picture'),
              //    );
              // }
              resolutionPreset: QRCodeDartScanResolutionPreset.high,
              // formats: [ // You can restrict specific formats.
              //   BarcodeFormat.QR_CODE,
              //   BarcodeFormat.AZTEC,
              //   BarcodeFormat.DATA_MATRIX,
              //   BarcodeFormat.PDF_417,
              //   BarcodeFormat.CODE_39,
              //   BarcodeFormat.CODE_93,
              //   BarcodeFormat.CODE_128,
              //  BarcodeFormat.EAN_8,
              //   BarcodeFormat.EAN_13,
              // ],
              onCapture: (Result res) async {
                // do anything with result
                // result.text
                // result.rawBytes
                // result.resultPoints
                // result.format
                // result.numBits
                // result.resultMetadata
                // result.time

                logs('----:${res.text.runtimeType}---res.text--${res.text}');
                var text = res.text;
                if (text.startsWith('http')) {
                  Get.to(() => AppWebPage(
                        url: text,
                        title: '扫描结果',
                        showSysWeb: true,
                      ));
                  return;
                } else {
                  KitView.alert(
                    title: '扫描结果',
                    content: KitView.serial_no(text, tip: ''),
                    noCancel: true,
                    sure: () {
                      Get.back(result: text);
                    },
                  );
                }
              }),
          Center(
            child: Container(
              color: Colors.transparent,
              child: QRCodeLayout(
                // 设置扫描框的大小
                size: Size(width, width),
                // 直角长度
                angleLength: 25,
                // 直角线粗细
                angleWidth: 4,
                // 边框宽度
                borderWidth: 0.5,
                // 是否显示边框
                showBorder: true,
                // 扫描动画时长
                animationDuration: 3000,
                // 扫描横线宽度
                scannerWidth: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
