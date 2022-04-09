part of insta_dart;

class InstgramOperator {
  static String? _token;
  static int? _userId;
  static const String _siteHeader = "https://www.instagram.com/";
  static const String _dataScrapeTail = "/?__a=1";
  static const String _searchAdress =
      "web/search/topsearch/?context=blended&query=";
  static const String _errorText = "<!DOCTYPE html>";

  static void setToken(String token) {
    _token = token;
  }

  static void setUserId(int UserId) {
    _userId = UserId;
  }

  static Future<InstaObject> findInstaName(String fullName) async {
    String insatSearch;
    do {
      insatSearch = await http.read(Uri.parse(
          "$_siteHeader$_searchAdress$fullName${_token == null ? "" : "&access_token=$_token"} "));
      print(insatSearch);
    } while (insatSearch.contains(_errorText));
    var instaSearchJson = jsonDecode(insatSearch);
    print((instaSearchJson['users']).first['user']["username"]);
    String name = (instaSearchJson['users']).first['user']["username"];
    return await getInstgram(name);
  }

  static Future<InstaObject> getInstgram(String profileName) async {
    String insta;
    final List<String> links = [];
    do {
      insta = await http.read(Uri.parse(
          "$_siteHeader$profileName$_dataScrapeTail${_token == null ? "" : "&access_token=$_token"}"));
      print(insta);
    } while (insta.contains(_errorText));
    var instaJson = jsonDecode(insta);
    instaJson['graphql']?['user']?['edge_owner_to_timeline_media']?['edges']
        .forEach((element) {
      //print(element);
    });
    (instaJson['graphql']['user']['edge_owner_to_timeline_media']['edges'])
        .map((e) => e['node']['display_url'].toString())
        .forEach((x) => links.add(x));
    print(links);
    print(instaJson["graphql"]['user']["id"]);
    return InstaObject(
        links,
        profileName,
        instaJson['graphql']['user']['biography'],
        instaJson['graphql']['user']['profile_pic_url_hd'],
        int.parse(
          instaJson['graphql']['user']["edge_followed_by"]["count"].toString(),
        ));
  }
}
