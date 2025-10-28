import '../../../core/kt_export.dart';
import '../../widgets/kit_views/kit_view.dart';

class MapFormEntry extends StatelessWidget {
  // final String longitude;
  // final String latitude;
  final String lng_lat;
  final String address;
  final String name;
  final bool is_required;
  final Function()? call;
  const MapFormEntry({super.key, this.lng_lat = '', this.name = '地址', this.address = '', this.call, this.is_required = false});

  @override
  Widget build(BuildContext context) {
    logs('---lng_lat--:$lng_lat-address--:$address');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (is_required)
              Text(
                '∗',
                style: TextStyle(color: C.red, fontSize: 16.r, fontWeight: FontWeight.w700),
              ),
            MainText(name.isEmpty ? '地址' : name, fontSize: 16.r, color: C.deepBlack),
          ],
        ),
        SizedBox(height: 7),
        _mapFormEntry(),
      ],
    );
  }

  Widget _mapFormEntry() {
    List ls = lng_lat.split(',');
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(width: 1.r, color: C.fiveColor),
        color: C.orange.withOpacity(0.1),
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            child: KitView.textTag(
              '修改定位',
              callback: () {
                logs('--lng_lat--:$lng_lat');
                if (call != null) call!();
              },
            ),
          ),
          SizedBox(width: 10),
          Expanded(child: MainText((ls.first.toString().toDouble == 0) ? '未设置$name' : (address.isNotEmpty ? address : lng_lat), color: C.red)),
        ],
      ),
    );
  }
}
