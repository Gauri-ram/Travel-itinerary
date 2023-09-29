import 'package:http/http.dart' as http;

class LocationSearch {
  static Future<String> fetchGeoId(String query) async {
    final client = http.Client();

    final mediaType = 'application/json';
    final body = '''{
      "query": "$query",
      "updateToken": ""
    }''';

    final response = await client.post(
      Uri.parse(
          'https://travel-advisor.p.rapidapi.com/locations/v2/search?currency=USD&units=km&lang=en_US'),
      headers: {
        'content-type': mediaType,
        'X-RapidAPI-Key': '',
        'X-RapidAPI-Host': 'travel-advisor.p.rapidapi.com',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      final responseBody = response.body;
      final geoId = parseGeoIdFromResponse(responseBody);
      return geoId;
    } else {
      throw Exception('Failed to fetch geoId');
    }
  }

  static String parseGeoIdFromResponse(String responseBody) {
    // Parse the JSON response and extract the geoId
    // Implement parsing logic based on the response structure
    return '12345'; // Replace with the actual parsed geoId
  }
}
