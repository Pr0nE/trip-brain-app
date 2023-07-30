///
//  Generated code. Do not modify.
//  source: gpt.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'gpt.pb.dart' as $0;
export 'gpt.pb.dart';

class TravelSuggestionClient extends $grpc.Client {
  static final _$suggest = $grpc.ClientMethod<$0.TravelSuggestionRequest,
          $0.TravelSuggestionResponse>(
      '/TravelSuggestion/Suggest',
      ($0.TravelSuggestionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.TravelSuggestionResponse.fromBuffer(value));
  static final _$getPlaceImage =
      $grpc.ClientMethod<$0.PlaceImageRequest, $0.PlaceImageResponse>(
          '/TravelSuggestion/GetPlaceImage',
          ($0.PlaceImageRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.PlaceImageResponse.fromBuffer(value));

  TravelSuggestionClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseStream<$0.TravelSuggestionResponse> suggest(
      $0.TravelSuggestionRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$suggest, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$0.PlaceImageResponse> getPlaceImage(
      $0.PlaceImageRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPlaceImage, request, options: options);
  }
}

abstract class TravelSuggestionServiceBase extends $grpc.Service {
  $core.String get $name => 'TravelSuggestion';

  TravelSuggestionServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.TravelSuggestionRequest,
            $0.TravelSuggestionResponse>(
        'Suggest',
        suggest_Pre,
        false,
        true,
        ($core.List<$core.int> value) =>
            $0.TravelSuggestionRequest.fromBuffer(value),
        ($0.TravelSuggestionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PlaceImageRequest, $0.PlaceImageResponse>(
        'GetPlaceImage',
        getPlaceImage_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PlaceImageRequest.fromBuffer(value),
        ($0.PlaceImageResponse value) => value.writeToBuffer()));
  }

  $async.Stream<$0.TravelSuggestionResponse> suggest_Pre($grpc.ServiceCall call,
      $async.Future<$0.TravelSuggestionRequest> request) async* {
    yield* suggest(call, await request);
  }

  $async.Future<$0.PlaceImageResponse> getPlaceImage_Pre($grpc.ServiceCall call,
      $async.Future<$0.PlaceImageRequest> request) async {
    return getPlaceImage(call, await request);
  }

  $async.Stream<$0.TravelSuggestionResponse> suggest(
      $grpc.ServiceCall call, $0.TravelSuggestionRequest request);
  $async.Future<$0.PlaceImageResponse> getPlaceImage(
      $grpc.ServiceCall call, $0.PlaceImageRequest request);
}

class AuthClient extends $grpc.Client {
  static final _$socialAuthorize =
      $grpc.ClientMethod<$0.SocialAuthorizeRequest, $0.SocialAuthorizeResponse>(
          '/Auth/SocialAuthorize',
          ($0.SocialAuthorizeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.SocialAuthorizeResponse.fromBuffer(value));
  static final _$tokenAuthorize =
      $grpc.ClientMethod<$0.TokenAuthorizeRequest, $0.TokenAuthorizeResponse>(
          '/Auth/TokenAuthorize',
          ($0.TokenAuthorizeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.TokenAuthorizeResponse.fromBuffer(value));

  AuthClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.SocialAuthorizeResponse> socialAuthorize(
      $0.SocialAuthorizeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$socialAuthorize, request, options: options);
  }

  $grpc.ResponseFuture<$0.TokenAuthorizeResponse> tokenAuthorize(
      $0.TokenAuthorizeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$tokenAuthorize, request, options: options);
  }
}

abstract class AuthServiceBase extends $grpc.Service {
  $core.String get $name => 'Auth';

  AuthServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.SocialAuthorizeRequest,
            $0.SocialAuthorizeResponse>(
        'SocialAuthorize',
        socialAuthorize_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SocialAuthorizeRequest.fromBuffer(value),
        ($0.SocialAuthorizeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TokenAuthorizeRequest,
            $0.TokenAuthorizeResponse>(
        'TokenAuthorize',
        tokenAuthorize_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.TokenAuthorizeRequest.fromBuffer(value),
        ($0.TokenAuthorizeResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.SocialAuthorizeResponse> socialAuthorize_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.SocialAuthorizeRequest> request) async {
    return socialAuthorize(call, await request);
  }

  $async.Future<$0.TokenAuthorizeResponse> tokenAuthorize_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.TokenAuthorizeRequest> request) async {
    return tokenAuthorize(call, await request);
  }

  $async.Future<$0.SocialAuthorizeResponse> socialAuthorize(
      $grpc.ServiceCall call, $0.SocialAuthorizeRequest request);
  $async.Future<$0.TokenAuthorizeResponse> tokenAuthorize(
      $grpc.ServiceCall call, $0.TokenAuthorizeRequest request);
}

class PlaceDetailsClient extends $grpc.Client {
  static final _$getDetail =
      $grpc.ClientMethod<$0.GetDetailRequest, $0.GetDetailResponse>(
          '/PlaceDetails/GetDetail',
          ($0.GetDetailRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetDetailResponse.fromBuffer(value));

  PlaceDetailsClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseStream<$0.GetDetailResponse> getDetail(
      $0.GetDetailRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$getDetail, $async.Stream.fromIterable([request]),
        options: options);
  }
}

abstract class PlaceDetailsServiceBase extends $grpc.Service {
  $core.String get $name => 'PlaceDetails';

  PlaceDetailsServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetDetailRequest, $0.GetDetailResponse>(
        'GetDetail',
        getDetail_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.GetDetailRequest.fromBuffer(value),
        ($0.GetDetailResponse value) => value.writeToBuffer()));
  }

  $async.Stream<$0.GetDetailResponse> getDetail_Pre($grpc.ServiceCall call,
      $async.Future<$0.GetDetailRequest> request) async* {
    yield* getDetail(call, await request);
  }

  $async.Stream<$0.GetDetailResponse> getDetail(
      $grpc.ServiceCall call, $0.GetDetailRequest request);
}

class PaymentClient extends $grpc.Client {
  static final _$buyCredit =
      $grpc.ClientMethod<$0.BuyCreditRequest, $0.BuyCreditResponse>(
          '/Payment/BuyCredit',
          ($0.BuyCreditRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.BuyCreditResponse.fromBuffer(value));

  PaymentClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.BuyCreditResponse> buyCredit(
      $0.BuyCreditRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$buyCredit, request, options: options);
  }
}

abstract class PaymentServiceBase extends $grpc.Service {
  $core.String get $name => 'Payment';

  PaymentServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.BuyCreditRequest, $0.BuyCreditResponse>(
        'BuyCredit',
        buyCredit_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.BuyCreditRequest.fromBuffer(value),
        ($0.BuyCreditResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.BuyCreditResponse> buyCredit_Pre($grpc.ServiceCall call,
      $async.Future<$0.BuyCreditRequest> request) async {
    return buyCredit(call, await request);
  }

  $async.Future<$0.BuyCreditResponse> buyCredit(
      $grpc.ServiceCall call, $0.BuyCreditRequest request);
}

class GeneralClient extends $grpc.Client {
  static final _$ping = $grpc.ClientMethod<$0.PingRequest, $0.PingResponse>(
      '/General/Ping',
      ($0.PingRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.PingResponse.fromBuffer(value));
  static final _$getCurrentVersion = $grpc.ClientMethod<
          $0.GetCurrentVersionRequest, $0.GetCurrentVersionResponse>(
      '/General/GetCurrentVersion',
      ($0.GetCurrentVersionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetCurrentVersionResponse.fromBuffer(value));

  GeneralClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.PingResponse> ping($0.PingRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$ping, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetCurrentVersionResponse> getCurrentVersion(
      $0.GetCurrentVersionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCurrentVersion, request, options: options);
  }
}

abstract class GeneralServiceBase extends $grpc.Service {
  $core.String get $name => 'General';

  GeneralServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.PingRequest, $0.PingResponse>(
        'Ping',
        ping_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PingRequest.fromBuffer(value),
        ($0.PingResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetCurrentVersionRequest,
            $0.GetCurrentVersionResponse>(
        'GetCurrentVersion',
        getCurrentVersion_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetCurrentVersionRequest.fromBuffer(value),
        ($0.GetCurrentVersionResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.PingResponse> ping_Pre(
      $grpc.ServiceCall call, $async.Future<$0.PingRequest> request) async {
    return ping(call, await request);
  }

  $async.Future<$0.GetCurrentVersionResponse> getCurrentVersion_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetCurrentVersionRequest> request) async {
    return getCurrentVersion(call, await request);
  }

  $async.Future<$0.PingResponse> ping(
      $grpc.ServiceCall call, $0.PingRequest request);
  $async.Future<$0.GetCurrentVersionResponse> getCurrentVersion(
      $grpc.ServiceCall call, $0.GetCurrentVersionRequest request);
}
