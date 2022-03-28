
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test323232/Objects/track_object.dart';
class InstaObject {

  String userPhotoLink;
  List<String> items;
  String profileName;
  String bio;
  int followers;
  static const String  _siteHeader = "https://www.instagram.com/";
  static const String  _dataScrapeTail = "/?__a=1";
  static const String  _searchAdress = "web/search/topsearch/?context=blended&query=";
  static const String  _errorText = "<!DOCTYPE html>";
  InstaObject(this.items, this.profileName, this.bio,
      this.userPhotoLink, this.followers);
static  Future<InstaObject> fromInstaUserName(String profileName )async{
              String insta;
              final List<String> links = [];
              do {
                insta = await http.read(Uri.parse("$_siteHeader$profileName$_dataScrapeTail"));
                await Future.delayed(Duration(milliseconds: 40));
              } while (insta.contains(_errorText) );
              var instaJson = jsonDecode(insta);
              instaJson['graphql']?['user']?['edge_owner_to_timeline_media']?
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
                insatSearch = await http.read(Uri.parse("$_siteHeader$_searchAdress$fullName"));
                print(insatSearch);
              } while (insatSearch.contains(_errorText));
              var instaSearchJson = jsonDecode(insatSearch);
              print((instaSearchJson['users']).first['user']["username"]);
              return (instaSearchJson['users']).first['user']["username"];

  }
 
  static  Future<InstaObject> fromSpotifyUserName(String profileName )async 
        => await fromInstaUserName(await findInstaName(profileName));

  static  Future<InstaObject> fromSpotifyTrack(TrackSpot  track )async 
        => await fromSpotifyUserName(track.singersFullName.first) ;




}
