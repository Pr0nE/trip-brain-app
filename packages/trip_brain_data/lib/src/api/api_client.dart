import 'package:grpc/grpc.dart';
import 'package:trip_brain_data/src/generated/gpt.pbgrpc.dart';

class GRPClientInfo {
  GRPClientInfo({
    required this.host,
    required this.port,
  });

  final String host;
  final int port;
}

class APIClient {
  APIClient({
    required this.grpcClientInfo,
    this.certificates,
  }) {
    _init();
  }

  static const _timeoutDuration = Duration(seconds: 8);

  final GRPClientInfo grpcClientInfo;
  final List<int>? certificates;
  late ClientChannel grpcChannel;

  late GeneralClient generalClient;
  late AuthClient authClient;
  late PaymentClient paymentClient;
  late PlaceDetailsClient placeDetailsClient;
  late TravelSuggestionClient travelSuggestionClient;

  void _init() {
    grpcChannel = ClientChannel(
      grpcClientInfo.host,
      port: grpcClientInfo.port,
      options: ChannelOptions(
        credentials: certificates != null
            ? ChannelCredentials.secure(certificates: certificates)
            : ChannelCredentials.insecure(),
      ),
    );
    generalClient = GeneralClient(
      grpcChannel,
      options: CallOptions(timeout: _timeoutDuration),
    );
    authClient = AuthClient(
      grpcChannel,
      options: CallOptions(timeout: _timeoutDuration),
    );
    paymentClient = PaymentClient(
      grpcChannel,
      options: CallOptions(timeout: _timeoutDuration),
    );
    placeDetailsClient = PlaceDetailsClient(grpcChannel);
    travelSuggestionClient = TravelSuggestionClient(grpcChannel);
  }

  void reconnect() {
    _init();
  }
}
