import 'package:flutter_test/flutter_test.dart';
import 'package:app_kit/utils/amap_static_tool.dart';

void main() {
  test('AmapStaticTool path thinning test', () {
    // 1. Create a point list with > 80 points
    final List<Map<String, dynamic>> points = [];
    for (int i = 0; i < 200; i++) {
      points.add({'lat': 30.0 + i * 0.001, 'lng': 114.0 + i * 0.001});
    }

    final pointData = {'type': 'polyline', 'points': points};

    // 2. Call getStaticMapUrl
    final url = AMapStaticTool.getStaticMapUrl(pointData: pointData);

    // 3. Verify URL
    print('Generated URL: $url');

    expect(url, isNotEmpty);

    // Extract paths parameter
    final uri = Uri.parse(url);
    final paths = uri.queryParameters['paths'];
    expect(paths, isNotNull);

    // paths format: style:lng,lat;lng,lat...
    // Note: The logic might split by just : but verify format first
    final parts = paths!.split(':');
    final coordsString = parts[1];
    final coords = coordsString.split(';');

    print('Original points: ${points.length}');
    print('Thinned points: ${coords.length}');

    // 4. Assert count
    // Max count is set to 80 in implementation
    expect(coords.length, lessThanOrEqualTo(80));
    expect(coords.length, greaterThanOrEqualTo(78));

    // Check start and end match
    final firstCoord = coords.first.split(',');
    final lastCoord = coords.last.split(',');

    expect(double.parse(firstCoord[1]), closeTo(30.0, 0.0001)); // lat
    expect(double.parse(firstCoord[0]), closeTo(114.0, 0.0001)); // lng

    expect(double.parse(lastCoord[1]), closeTo(30.0 + 199 * 0.001, 0.0001));
    expect(double.parse(lastCoord[0]), closeTo(114.0 + 199 * 0.001, 0.0001));

    // 5. Verify Determinism (Same input -> Same output)
    final url2 = AMapStaticTool.getStaticMapUrl(pointData: pointData);
    expect(url, equals(url2));
    print('Determinism verified: URLs are identical.');
  });
}
