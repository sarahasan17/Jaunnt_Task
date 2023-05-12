import 'package:connectivity/connectivity.dart';

abstract class NetworkTool {
  Future<bool> isConnected();
}

class NetworkInfoImpl implements NetworkTool {
  @override
  Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    return true;
  }
}
