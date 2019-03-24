import 'dart:convert';

import 'package:angular/angular.dart';
import 'package:intl/intl.dart';
import 'package:wishweb/src/models/OverView.dart';
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
    List<OverView> info = await _wishService.getAll();
    wishsFullCount.clear();
    for (var value in info) {

      DateTime date = new DateTime.fromMillisecondsSinceEpoch(value.start);
      var pulseAverage =  (value.max.toDouble()+ value.min.toDouble())/2;
      var weight = 80;

      var format = new DateFormat("Hms");
      var dateString = format.format(date);
      var duration =((DateTime.now().millisecondsSinceEpoch - value.start)/1000).toInt() ;

      var min= duration/60;
      var sec= duration%60;
      var burnCal =   0.014 * weight * min * (0.12 * pulseAverage - 7);
      var burnCalFormat = format11(burnCal);

      if (value.curent != 0){
        wishsFullCount.add(new WishItemList(startTime: dateString,
            name: value.userName,
            pulse: "${value.curent}",
            pulseMax: "${value.max}",
            pulseMin: "${value.min}",
            burnCal: burnCalFormat,
            duration: "${min.toInt()}:${sec.toInt()}"


        ));
      } else {

        wishsFullCount.add(new WishItemList(startTime: dateString,
            name: value.userName,
            pulse: "-",
            pulseMax: "-",
            pulseMin: "-",
            burnCal: "-",
            duration: "${min.toInt()}:${sec.toInt()}"


        ));
      }

    }



  }


  String format11(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
  }
}
