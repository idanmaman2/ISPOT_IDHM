
import 'dart:convert';

import 'package:http/http.dart' as http;
class InstaObject {
   late String userPhotoLink;
   late List<String> items;
      late String bio;
  late int followers;
    late String profileName; //uniq 
    

    static const _siteHeader = "https://www.instagram.com/";
    static const String _searchAdress = "$_siteHeader/web/search/topsearch/?context=blended&query=";
    static const String _errorText = "<!DOCTYPE html>";
    static const String _dataScrapeTail = "/?__a=1";
    
  InstaObject(this.items, this.profileName, this.bio,
      this.userPhotoLink, this.followers);
    
  static  Future<InstaObject> fromInstaUserName(String profileName )async{
              String insta;
              const List<String> links = [];
              do {
                insta = await http.read(Uri.parse("$_siteHeader$profileName$_dataScrapeTail"));
              } while (insta.contains(_errorText) );
              var instaJson = jsonDecode(insta);
              instaJson['graphql']['user']['edge_owner_to_timeline_media']
                      ['edges']
                  .forEach((element) {
                print(element);
              });
              (instaJson['graphql']['user']['edge_owner_to_timeline_media']
                      ['edges'])
                  .map((e) => e['node']['display_url'].toString())
                  .forEach((x) => links.add(x));
              print(links);
              return  InstaObject(
                  links,
                profileName,
                  instaJson['graphql']['user']['biography'],
                  instaJson['graphql']['user']['profile_pic_url_hd'],
                  int.parse(instaJson['graphql']['user']["edge_followed_by"]
                          ["count"]
                      .toString()));
  }

  static Future<String> findInstaName(String fullName)async{
              String insatSearch;
              do {
                insatSearch = await http.read(Uri.parse("$_searchAdress$fullName"));
                print(insatSearch);
              } while (insatSearch.contains(_errorText));
              var instaSearchJson = jsonDecode(insatSearch);
              print((instaSearchJson['users']).first['user']["username"]);
              return (instaSearchJson['users']).first['user']["username"];

  }
}
