
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test323232/Objects/interface_instgram.dart';
import 'package:test323232/Objects/track_object.dart';
class InstaObject implements IInsta {

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

   String get formatedFollowers {
    List<String> arr = followers.toString().split("");
    for (int i = arr.length - 1; i >= 0; i -= 3) {
      if (i != arr.length - 1) {
        arr[i] += ",";
      }
    }
    return arr.join("");
  }

  String get formatedName {
    return "@" + profileName ; 
  }

  String get formatedBio {
     List<String> xArr = bio.split("\n");
    for (int i = 0; i < xArr.length; i++) {
      List<String> adder = xArr[i].split(" ");
      if (adder.length > 5) {
        for (int j = 0; j < adder.length; j += 5) {
          if(adder[j].contains('\n')){
            adder[j] += "\n";
          }
        }
      }

      xArr[i] = adder.join(" ");
    }
    print(xArr.join("\n"));
    return xArr.join("\n");


  }  

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
  
  Stream<String> StreamBio(int rate , int displaySize)async*{
    int placeOfDisplay = 0 ; 
    String text = bio.isEmpty ? "Empty Screen":bio.replaceAll("\n", " ");
    int len  = text.length ;
    while(true){
  await Future.delayed(Duration(milliseconds: (1/rate * 1000).toInt()));
    placeOfDisplay = (placeOfDisplay + 1  )%text.length ; 
    int sizeOfDisplayFixed  = displaySize > text.length ? text.length : displaySize ; 
    if( (placeOfDisplay+sizeOfDisplayFixed)/text.length >1 ){  
      yield text.substring(placeOfDisplay, text.length) + " " 
      + text.substring(0, (placeOfDisplay + sizeOfDisplayFixed - len )% (len)+1 );
    }
    else {
        yield text.substring(placeOfDisplay, (placeOfDisplay+sizeOfDisplayFixed )%len + 1 );
    }
    }

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






}
