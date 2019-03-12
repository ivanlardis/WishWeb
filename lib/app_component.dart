import 'dart:convert';

import 'package:angular/angular.dart';
import 'package:wishweb/src/models/WishFull.dart';
import 'package:wishweb/src/models/WishItemList.dart';
import 'package:wishweb/src/models/WishOpenInfo.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:wishweb/src/service/WishService.dart';
import 'package:rxdart/rxdart.dart';

import 'package:http/http.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components
@Component(
  directives: [coreDirectives, formDirectives],
  selector: 'my-app',
  styleUrls: ['app_component.css'],
  templateUrl: 'app_component.html',
  providers: [ClassProvider(WishService)],
)
class AppComponent {
  List<WishItemList> wishsFullFast = List<WishItemList>();
  List<WishItemList> wishsFullCount = List<WishItemList>();
  int countAllCons = 0;
  int countAllProps = 0;

  final WishService _wishService;

  AppComponent(this._wishService) {
    var timerObservable = Observable.periodic(Duration(seconds: 1));

    timerObservable.listen((i) {
      loadData();
    });
  }

  void loadData() async {
    WishOpenInfo info = await _wishService.getAll();

    var wishsFull = info.wishsFull;
    wishsFull.sort(
        (a, b) => (a.timeAfterLastPress) > (b.timeAfterLastPress) ? 1 : -1);

    var wishsFullFastBuf = List<WishItemList>();
    for (int i = 0; i < wishsFull.length; i++) {
      wishsFullFastBuf.add(WishItemList(
          position: i + 1,
          name: wishsFull[i].userName,
          value: wishsFull[i].timeAfterLastPress));
    }
    wishsFullFast = wishsFullFastBuf;


    wishsFull.sort(
            (a, b) => (a.getAllCountPressed()) < (b.getAllCountPressed()) ? 1 : -1);

    var wishsFullCountBuf = List<WishItemList>();
    for (int i = 0; i < wishsFull.length; i++) {
      wishsFullCountBuf.add(WishItemList(
          position: i + 1,
          name: wishsFull[i].userName,
          value: wishsFull[i].getAllCountPressed()));
    }
    wishsFullCount = wishsFullCountBuf;

    countAllCons = info.countAllCons;
    countAllProps = info.countAllProps;
  }
}
