class ConstData {
  static setHeadersToken(token) => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
  static setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
}
