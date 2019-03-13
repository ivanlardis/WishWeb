import 'dart:convert';
import 'dart:html';

import 'package:http/browser_client.dart';
import 'package:wishweb/src/models/WishFull.dart';
import 'package:wishweb/src/models/WishOpenInfo.dart';

class WishService {
  final BrowserClient _http;

  static var url ="http://34.73.164.26:8888";
  WishService(this._http);

  Future<WishOpenInfo> getAll() async {
    try {
      final response = await _http.get("$url/wishopeninfo");
      Map map = json.decode(response.body);
      final heroes = WishOpenInfo.fromJson(map);
      return heroes;
    } catch (e) {}

    return WishOpenInfo(
        countAllProps: 0, countAllCons: 0, wishsFull: <WishFull>[]);
  }
}

//
//Future<WishOpenInfo> loadWishInfo() async {
//  countAllCons =1;
//  var response =
//  await _http.get('http://localhost:8888/wishopeninfo' );
//
//  print("loadWishInfo body ${response.body}");
////    Map map = json.decode(response.body);
////
////    WishOpenInfo networkWish = WishOpenInfo.fromJson(map);
////    return networkWish;
//}
