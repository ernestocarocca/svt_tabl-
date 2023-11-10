// ignore_for_file: public_member_api_docs, sort_constructors_first
class Radios {
  final String imageUrl;
  final String url;
  Radios({
    required this.imageUrl,
    required this.url,
  });
    factory Radios.fromApiData(Map<String, dynamic> apiData) {
    return Radios(
      imageUrl: apiData['imageUrl'],
      url: apiData['url'],
    );
  }
}
