import 'package:flutter_test/flutter_test.dart';
import 'package:my_resto/api/api_service.dart';

void main() {
  test('Fetch name restaurant', () async {
    final restoData = await ApiService().listResto();
    var restoName = restoData.restaurants[1];
    expect(restoName.name, "Kafe Kita");
  });
}
