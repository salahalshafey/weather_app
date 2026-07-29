import 'package:connectivity_plus/connectivity_plus.dart';

/// Reports whether a network transport is currently available.
abstract interface class NetworkInfo {
  Future<bool> get isConnected;
}

/// Connectivity-based implementation of [NetworkInfo].
class NetworkInfoImpl implements NetworkInfo {
  const NetworkInfoImpl(this._connectivity);

  final Connectivity _connectivity;

  @override
  Future<bool> get isConnected async {
    final results = await _connectivity.checkConnectivity();
    return !results.contains(ConnectivityResult.none);
  }
}
