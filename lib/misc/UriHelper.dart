abstract class UriHelper {
  static Uri concat(Uri? base, String relative) {
    Uri relativeUri = Uri.parse(relative);
    if (relativeUri.isAbsolute) {
      return relativeUri;
    } else {
      return relativeUri.replace(
          scheme: base!.scheme,
          userInfo: base.userInfo,
          host: base.host,
          port: base.port);
    }
  }
}
