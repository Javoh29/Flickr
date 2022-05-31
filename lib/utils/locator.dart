import 'package:jbaza/jbaza.dart';

import '../data/viewmodels/local_viewmodel.dart';

final locator = JbazaLocator.instance;

void setupLocator() {
  locator.registerLazySingleton<LocalViewModel>(() => LocalViewModel());
}
