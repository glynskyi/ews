import 'package:ews/Core/EwsUtilities.dart';
import 'package:test/test.dart';

main() {
  test('parces seconds', () {
    final xsTimeDuration = "T21M42S";

    final timeDuration = EwsUtilities.XSDurationToTimeSpan(xsTimeDuration);

    expect(timeDuration.Minutes, 21);
    expect(timeDuration.Seconds, 42);
  });
}
