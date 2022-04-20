part of insta_dart;

class InstgramMannger {
  //"https://www.instagram.com/oauth/authorize?client_id=341783747982324&redirect_uri=https://www.codegrepper.com/&scope=user_profile&response_type=code"
  static const String _connectionUrl = "/oauth/authorize";
  static const String _tokenUrl = "/oauth/access_token";
  static const String _apiUrl = "https://www.instagram.com";
  final String _redirectUri;
  final String _clientId;
  final String _secretKey;
  late String _userId;
  late String _code;

  InstgramMannger(this._clientId, this._secretKey, this._redirectUri);

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
    InstgramOperator.setToken(respone["access_token"]);
    InstgramOperator.setUserId(respone["user_id"]);
    InstgramOperator.setCookies(httprsp.headers['set-cookie']);
    return InstgramOperator();
  }
}
