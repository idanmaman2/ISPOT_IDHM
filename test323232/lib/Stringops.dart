class StringOPs {
  static String splitTosmall(String x) {
    List<String> xArr = x.split("\n");
    for (int i = 0; i < xArr.length; i++) {
      List<String> adder = xArr[i].split(" ");
      if (adder.length > 5) {
        for (int j = 0; j < adder.length; j += 5) {
          adder[j] += "\n";
        }
      }

      xArr[i] = adder.join(" ");
    }
    print(xArr.join("\n"));
    return xArr.join("\n");
  }

  static String numberShow(String x) {
    List<String> arr = x.split("");
    for (int i = arr.length - 1; i >= 0; i -= 3) {
      if (i != arr.length - 1) {
        arr[i] += ",";
      }
    }
    return arr.join("");
  }
}
