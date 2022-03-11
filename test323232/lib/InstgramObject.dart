import 'package:flutter/material.dart';
import 'package:test323232/instgramPage.dart';

class InstaObject {
  String userPhotoLink;
  List<String> items;
  String ProfileName;
  String Bio;

  int Followers;
  InstaObject(List<String> items, String ProfileName, String Bio,
      String userPhotoLink, int Followers)
      : items = items,
        ProfileName = ProfileName,
        userPhotoLink = userPhotoLink,
        Bio = Bio,
        Followers = Followers;
}
