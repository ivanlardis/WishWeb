import 'package:angular/angular.dart';
import 'package:wishweb/app_component.template.dart' as ng;

import 'package:http/browser_client.dart';
import 'main.template.dart' as self;


@GenerateInjector([  // You can use routerProviders in production
  ClassProvider(BrowserClient),
])


final InjectorFactory injector = self.injector$Injector;
void main() {
  runApp(ng.AppComponentNgFactory, createInjector: injector);
}