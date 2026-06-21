/// Placeholder for the future REST backend.
///
/// When moving off-device, implement the repository interfaces in
/// `domain/repositories/repositories.dart` against this client (e.g.
/// `RemoteCrossingRepository`) and switch the providers in
/// `core/providers.dart` to the remote implementations. The `uuid`,
/// `serverId`, `updatedAt` and `syncStatus` columns already present on every
/// table are there to support that synchronization.
class ApiClient {
  ApiClient({required this.baseUrl});

  final String baseUrl;

  Future<Map<String, dynamic>> get(String path) {
    throw UnimplementedError('Remote backend not yet enabled');
  }

  Future<Map<String, dynamic>> post(String path, Map<String, dynamic> body) {
    throw UnimplementedError('Remote backend not yet enabled');
  }

  Future<Map<String, dynamic>> put(String path, Map<String, dynamic> body) {
    throw UnimplementedError('Remote backend not yet enabled');
  }

  Future<void> delete(String path) {
    throw UnimplementedError('Remote backend not yet enabled');
  }
}
