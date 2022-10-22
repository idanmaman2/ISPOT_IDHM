part of insta_dart;

class InstgramOperator {
  static int? _userId;
  static String? _cookies;
  static const String _siteHeader = "https://i.instagram.com/api/v1";
  static const String _profileAdressHead = "/users/web_profile_info/";
  static const String _profileAdressTail = "?username=";
  static const String _searchAdressHead = "/web/search/topsearch/";
  static const String _searchAdressTail ="?query=";
  static const String _errorText = "<!DOCTYPE html>";


  static void setUserId(int UserId) {
    print(UserId);
    _userId = UserId;
  }

  static void setCookies(String? cookies) {
    _cookies = cookies;
  }

  static Future<InstaObject> findInstaName(String fullName) async {
    print("entered");
    String insatSearch=_errorText;


      insatSearch = await http.read(
          Uri.parse(
              "$_siteHeader$_searchAdressHead$_searchAdressTail$fullName"),
          headers: _cookies == null ? {} : {'set-cookie': _cookies! , 'x-ig-app-id': '936619743392459'});
      print(insatSearch);

    var instaSearchJson = jsonDecode(insatSearch);
    String name = (instaSearchJson['users']).first['user']["username"];
    
    return await getInstgram(name);
  }

  static Future<InstaObject> getInstgram(String profileName) async {
    String insta=_errorText;
    final List<String> links = [];

      insta = await http.read(
          Uri.parse(
              "$_siteHeader$_profileAdressHead$_profileAdressTail$profileName"),
          headers: _cookies == null ? {} : {'set-cookie': _cookies!, 'x-ig-app-id': '936619743392459'});
    var instaJson = jsonDecode(insta);
    (instaJson['data']['user']['edge_owner_to_timeline_media']['edges'])
        .map((e) => e['node']['display_url'])
        .forEach((x) => links.add(x));
    print(links);
    print(instaJson["data"]['user']["id"]);
    return InstaObject(
      links,
      profileName,
      instaJson['data']['user']['biography'],
      instaJson['data']['user']['profile_pic_url_hd'],
      instaJson['data']['user']["edge_followed_by"]["count"],
    );
  }
}
