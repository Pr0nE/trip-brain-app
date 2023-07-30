import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:grpc/grpc.dart';
import 'package:trip_brain_data/src/api/api_exception.dart';
import 'package:trip_brain_data/src/generated/gpt.pbgrpc.dart';

enum APIRequestMethod { get, post, patch, delete, put }

class GRPClientInfo {
  GRPClientInfo({
    required this.host,
    required this.port,
  });

  final String host;
  final int port;
}

class HTTPClientInfo {
  HTTPClientInfo({
    required this.host,
    required this.port,
    required this.schema,
  });

  final String host;
  final String schema;
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
  static const defaultHeaders = {'Content-Type': 'application/json'};

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
    placeDetailsClient = PlaceDetailsClient(
      grpcChannel,
    );
    travelSuggestionClient = TravelSuggestionClient(
      grpcChannel,
    );
  }

  void reconnect() {
    _init();
  }

  //TODO remove
  Future<dynamic> request(
    Uri uri, {
    APIRequestMethod method = APIRequestMethod.get,
    Map<String, dynamic>? body,
    Map<String, String>? queryParameters,
    Map<String, String>? extraHeaders,
  }) async {
    try {
      late final http.Response response;
      // final Map<String, String> headers = {...?extraHeaders, ...defaultHeaders};
      final Map<String, String> headers = {...?extraHeaders};

      switch (method) {
        case APIRequestMethod.get:
          response =
              await http.get(uri, headers: headers).timeout(_timeoutDuration);
          break;
        case APIRequestMethod.post:
          response = await http
              .post(uri, headers: headers, body: jsonEncode(body))
              .timeout(_timeoutDuration);
          break;
        case APIRequestMethod.patch:
          response = await http
              .patch(uri, body: jsonEncode(body), headers: headers)
              .timeout(_timeoutDuration);
          break;
        case APIRequestMethod.put:
          response = await http
              .put(uri, body: jsonEncode(body), headers: headers)
              .timeout(_timeoutDuration);
          break;
        case APIRequestMethod.delete:
          response = await http
              .delete(uri, headers: headers)
              .timeout(_timeoutDuration);
          break;
      }

      final int hundreds = response.statusCode ~/ 100;

      switch (hundreds) {
        case 2:
          return jsonDecode(response.body);
        case 4:
          final String errorCode = jsonDecode(response.body)['errorCode'];
          throw APIException(
              status: APIExceptionStatus.badRequest, errorCode: errorCode);
        case 5:
          throw APIException(status: APIExceptionStatus.serverError);
        default:
          throw APIException(status: APIExceptionStatus.unknownError);
      }
    } on APIException {
      rethrow;
    } catch (exception) {
      if (exception is TimeoutException) {
        throw APIException(status: APIExceptionStatus.networkError);
      } else if (exception is SocketException) {
        throw APIException(status: APIExceptionStatus.networkError);
      } else {
        throw APIException(status: APIExceptionStatus.unknownError);
      }
    }
  }
}
