part of insta_dart;

class InstaObject implements IInsta {
  String userPhotoLink;
  List<String> items;
  String profileName;
  String bio;
  int followers;
  InstaObject(this.items, this.profileName, this.bio, this.userPhotoLink,
      this.followers);

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
    return "@" + profileName;
  }

  String get formatedBio {
    List<String> xArr = bio.split("\n");
    for (int i = 0; i < xArr.length; i++) {
      List<String> adder = xArr[i].split(" ");
      if (adder.length > 5) {
        for (int j = 0; j < adder.length; j += 5) {
          if (adder[j].contains('\n')) {
            adder[j] += "\n";
          }
        }
      }

      xArr[i] = adder.join(" ");
      if (xArr[i].length > 50) {
        List<String> xArrNew = xArr[i].split("");
        for (int j = 0; j < xArr[i].length; j += 10) {
          for (;
              j > 0 &&
                  !(xArrNew[j] == " " ||
                      xArrNew[j] == ":" ||
                      xArrNew[j] == "&&");
              j--);

          xArrNew[j] += "\n";
        }
        xArr[i] = xArrNew.join("");
      }
    }
    print(xArr.join("\n"));
    return xArr.join("\n");
  }

  Stream<String> StreamBio(int rate, int displaySize) async* {
    int placeOfDisplay = 0;
    String text = bio.isEmpty ? "Empty Screen" : bio.replaceAll("\n", " ");
    int len = text.length;
    while (true) {
      await Future.delayed(Duration(milliseconds: (1 / rate * 1000).toInt()));
      placeOfDisplay = (placeOfDisplay + 1) % text.length;
      int sizeOfDisplayFixed =
          displaySize > text.length ? text.length : displaySize;
      if ((placeOfDisplay + sizeOfDisplayFixed) / text.length > 1) {
        yield text.substring(placeOfDisplay, text.length) +
            " " +
            text.substring(
                0, (placeOfDisplay + sizeOfDisplayFixed - len) % (len) + 1);
      } else {
        yield text.substring(
            placeOfDisplay, (placeOfDisplay + sizeOfDisplayFixed) % len + 1);
      }
    }
  }
}
