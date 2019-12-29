import 'package:ews/Core/ServiceObjects/ServiceObject.dart';

import '../ExchangeService.dart';

typedef T IGetObjectInstanceDelegate<T extends ServiceObject>(
    ExchangeService service, String xmlElementName);
