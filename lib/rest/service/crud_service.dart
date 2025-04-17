import 'package:bayi_geliyo_mobile_application/rest/entity/persistent.dart';

abstract class CrudService<T extends Persistent> {
  String apiURL = "https://reqres.in/api";
  String hostName = "https://reqres.in";

  /* CrudService() {
    configure();
  }

  configure() {
    String? gatewayIp = DigitalgatePreferenceHandler.instance.digitalgate?.serverIpAddress ?? "";
    String? gatewayPort = DigitalgatePreferenceHandler.instance.digitalgate?.portNumber ?? "";
    String? gatewayDevelopmentPort = DigitalgatePreferenceHandler.instance.digitalgate?.devPortNumber ?? "";
    String? gatewayEndPoint = DigitalgatePreferenceHandler.instance.digitalgate?.endPoint ?? "";
    if (developmentMode) {
      apiURL = "$gatewayIp:$gatewayDevelopmentPort/$gatewayEndPoint";
    } else {
      apiURL = "$gatewayIp:$gatewayPort/$gatewayEndPoint";
    }
    hostName = gatewayIp;
  } */
}
