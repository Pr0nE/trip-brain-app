import 'package:trip_brain_data/src/api/api_client.dart';
import 'package:trip_brain_data/src/generated/gpt.pbgrpc.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';

class GeneralRepository implements Pinger {
  GeneralRepository({
    required APIClient client,
  }) : client = GeneralClient(client.grpcChannel);

  final GeneralClient client;

  @override
  Future<bool> ping() async {
    try {
      await client.ping(PingRequest());

      return true;
    } catch (e) {
      return false;
    }
  }
}
