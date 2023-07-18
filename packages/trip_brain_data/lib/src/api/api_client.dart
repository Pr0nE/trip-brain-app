import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_connection_interface.dart';
import 'package:trip_brain_data/src/api/api_exception.dart';

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
  }) : grpcChannel = ClientChannel(
          grpcClientInfo.host,
          port: grpcClientInfo.port,
          options: // TODO: tls
              const ChannelOptions(
            connectTimeout: _timeoutDuration,
            connectionTimeout: _timeoutDuration,
            credentials: ChannelCredentials.insecure(),
          ),
        );

  final GRPClientInfo grpcClientInfo;

  final ClientChannel grpcChannel;

  static const _timeoutDuration = Duration(seconds: 5);
  static const defaultHeaders = {'Content-Type': 'application/json'};

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
