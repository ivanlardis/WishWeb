import 'package:wishweb/src/models/WishFull.dart';

class WishOpenInfo {
  WishOpenInfo(
      {
        this.countAllProps,
        this.wishsFull,
        this.countAllCons});

  factory WishOpenInfo.fromJson(Map<String, dynamic> json) {
    return WishOpenInfo(
      countAllProps: json['countAllProps'] as int,
      wishsFull: (json['wishsFull'] as List).map((model) =>WishFull.fromJson(model)).toList(),
      countAllCons: json['countAllCons'] as int,);
  }

  Map<String, dynamic> toJson() => {
    'countAllProps': countAllProps,
    'countAllCons': countAllCons,
    'wishsFull': wishsFull,
  };
  var wishsFull = new List<WishFull>();
  int countAllProps = 0;
  int countAllCons = 0;
}