part of insta_dart;

class InstgramMannger {
  //"https://www.instagram.com/oauth/authorize?client_id=341783747982324&redirect_uri=https://www.codegrepper.com/&scope=user_profile&response_type=code"
  static const String _connectionUrl = "/oauth/authorize";
  static const String _tokenUrl = "/oauth/access_token";
  static const String _apiUrl = "https://www.instagram.com";
  final String _redirectUri;
  final String _clientId;
  final String _secretKey;
  final Future<Directory> _localStoragePath ; 
  late String _userId;
  late String _code;
   String  ? _pathVar = null ; 

  Future<String> get _path async {
     _pathVar ??= (await _localStoragePath).path + "/savedCard.json";
     return _pathVar! ;
  }

  InstgramMannger(this._clientId, this._secretKey, this._redirectUri,this._localStoragePath);



  Future<InstgramOperator ? > restoreCook(  )async {
    try{
      File file  = await File(await _path);
    String text =await  file.readAsString();
    Map json = jsonDecode(text);
    if(json.containsKey("cookies")&&json.containsKey("user_id")){
 

          InstgramOperator.setUserId(json["user_id"]);
         InstgramOperator.setCookies(json["cookies"]);
         return InstgramOperator();
    }
    }
    catch(e){
      //dont realy care ... 
    }
        return null;
  }


  String get _connectionUrlFull => "$_apiUrl$_connectionUrl";

  String get tokenUrlFull => "$_apiUrl$_tokenUrl";

  String getFullAdress(List<String> scopes) {
    return _connectionUrlFull +
        "?client_id=$_clientId&redirect_uri=$_redirectUri&scope=${scopes.join(",")}&response_type=code";
  }

  set code(String fullAdress) {
    this._code =
        fullAdress.substring(this._redirectUri.length + "?code=".length);
  }

  Future<InstgramOperator> get fromCode async {
    var map = new Map<String, dynamic>();
    map['client_id'] = _clientId;
    map['client_secret'] = _secretKey;
    map['grant_type'] = 'authorization_code';
    map['redirect_uri'] = _redirectUri;
    map['code'] = _code;
    http.Response httprsp = await http.post(Uri.parse(tokenUrlFull), body: map);
    print(httprsp.headers['set-cookie']);
    Map<String, dynamic> respone = json.decode(httprsp.body);
    InstgramOperator.setUserId(respone["user_id"]);
    InstgramOperator.setCookies(httprsp.headers['set-cookie']);
    {
      try {
      Map savedData = Map();
      savedData["user_id"]=respone["user_id"];
      savedData["cookies"]=httprsp.headers['set-cookie'];
      await File(await _path).writeAsString(json.encode(savedData));
      }
      catch(e){
        print(e);
      }
    }


    return InstgramOperator();
  }
}
