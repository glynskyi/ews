class WebHeaderCollection {
  final _headers  = Map<String, String>();

  List<String> get AllKeys => _headers.keys.toList();

  void Set(String headerName, String headerValue) {
    _headers[headerName] = headerValue;
  }

  void Add(String headerName, String headerValue) => _headers[headerName] = headerValue;

  String operator[](String headerName) => _headers[headerName];

  operator[]=(String headerName, String headerValue) => _headers[headerName] = headerValue;
}