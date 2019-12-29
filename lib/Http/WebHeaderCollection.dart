class WebHeaderCollection {
  final _headers = Map<String, String>();

  List<String> get AllKeys => _headers.keys.toList();

  void Set(String headerName, String headerValue) {
    _headers[headerName.toLowerCase()] = headerValue;
  }

  void Add(String headerName, String headerValue) =>
      _headers[headerName.toLowerCase()] = headerValue;

  String operator [](String headerName) => _headers[headerName.toLowerCase()];

  operator []=(String headerName, String headerValue) =>
      _headers[headerName.toLowerCase()] = headerValue;
}
