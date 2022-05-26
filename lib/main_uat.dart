import 'flavors.dart';
import 'simple_aac_app_wrapper.dart';

void main() async {
  F.appFlavor = Flavor.uat;
  SimpleAACAppWrapper.init();
}
