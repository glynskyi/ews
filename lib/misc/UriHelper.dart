abstract class UriHelper {
  static Uri concat(Uri base, Uri relative) {
    String baseUri = base.toString();
    String relativeUri = relative.toString();
    if (baseUri.endsWith("/")) {
      baseUri.substring(0, baseUri.length - 2);
    }
    return Uri.parse(baseUri + relativeUri);
  }
}
