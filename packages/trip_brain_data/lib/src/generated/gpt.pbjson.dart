///
//  Generated code. Do not modify.
//  source: gpt.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use travelSuggestionRequestDescriptor instead')
const TravelSuggestionRequest$json = const {
  '1': 'TravelSuggestionRequest',
  '2': const [
    const {'1': 'accessToken', '3': 1, '4': 1, '5': 9, '10': 'accessToken'},
    const {'1': 'basePlace', '3': 2, '4': 1, '5': 9, '10': 'basePlace'},
    const {'1': 'likes', '3': 3, '4': 3, '5': 9, '10': 'likes'},
    const {'1': 'dislikes', '3': 4, '4': 3, '5': 9, '10': 'dislikes'},
    const {'1': 'language', '3': 5, '4': 1, '5': 9, '10': 'language'},
  ],
};

/// Descriptor for `TravelSuggestionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List travelSuggestionRequestDescriptor = $convert.base64Decode('ChdUcmF2ZWxTdWdnZXN0aW9uUmVxdWVzdBIgCgthY2Nlc3NUb2tlbhgBIAEoCVILYWNjZXNzVG9rZW4SHAoJYmFzZVBsYWNlGAIgASgJUgliYXNlUGxhY2USFAoFbGlrZXMYAyADKAlSBWxpa2VzEhoKCGRpc2xpa2VzGAQgAygJUghkaXNsaWtlcxIaCghsYW5ndWFnZRgFIAEoCVIIbGFuZ3VhZ2U=');
@$core.Deprecated('Use travelSuggestionResponseDescriptor instead')
const TravelSuggestionResponse$json = const {
  '1': 'TravelSuggestionResponse',
  '2': const [
    const {'1': 'places', '3': 1, '4': 3, '5': 11, '6': '.TravelPlace', '10': 'places'},
  ],
};

/// Descriptor for `TravelSuggestionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List travelSuggestionResponseDescriptor = $convert.base64Decode('ChhUcmF2ZWxTdWdnZXN0aW9uUmVzcG9uc2USJAoGcGxhY2VzGAEgAygLMgwuVHJhdmVsUGxhY2VSBnBsYWNlcw==');
@$core.Deprecated('Use placeImageRequestDescriptor instead')
const PlaceImageRequest$json = const {
  '1': 'PlaceImageRequest',
  '2': const [
    const {'1': 'accessToken', '3': 1, '4': 1, '5': 9, '10': 'accessToken'},
    const {'1': 'place', '3': 2, '4': 1, '5': 9, '10': 'place'},
  ],
};

/// Descriptor for `PlaceImageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List placeImageRequestDescriptor = $convert.base64Decode('ChFQbGFjZUltYWdlUmVxdWVzdBIgCgthY2Nlc3NUb2tlbhgBIAEoCVILYWNjZXNzVG9rZW4SFAoFcGxhY2UYAiABKAlSBXBsYWNl');
@$core.Deprecated('Use placeImageResponseDescriptor instead')
const PlaceImageResponse$json = const {
  '1': 'PlaceImageResponse',
  '2': const [
    const {'1': 'imageUrls', '3': 1, '4': 3, '5': 9, '10': 'imageUrls'},
  ],
};

/// Descriptor for `PlaceImageResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List placeImageResponseDescriptor = $convert.base64Decode('ChJQbGFjZUltYWdlUmVzcG9uc2USHAoJaW1hZ2VVcmxzGAEgAygJUglpbWFnZVVybHM=');
@$core.Deprecated('Use travelPlaceDescriptor instead')
const TravelPlace$json = const {
  '1': 'TravelPlace',
  '2': const [
    const {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
  ],
};

/// Descriptor for `TravelPlace`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List travelPlaceDescriptor = $convert.base64Decode('CgtUcmF2ZWxQbGFjZRIUCgV0aXRsZRgBIAEoCVIFdGl0bGUSIAoLZGVzY3JpcHRpb24YAiABKAlSC2Rlc2NyaXB0aW9u');
@$core.Deprecated('Use socialAuthorizeRequestDescriptor instead')
const SocialAuthorizeRequest$json = const {
  '1': 'SocialAuthorizeRequest',
  '2': const [
    const {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    const {'1': 'provider', '3': 2, '4': 1, '5': 9, '10': 'provider'},
  ],
};

/// Descriptor for `SocialAuthorizeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List socialAuthorizeRequestDescriptor = $convert.base64Decode('ChZTb2NpYWxBdXRob3JpemVSZXF1ZXN0EhQKBXRva2VuGAEgASgJUgV0b2tlbhIaCghwcm92aWRlchgCIAEoCVIIcHJvdmlkZXI=');
@$core.Deprecated('Use socialAuthorizeResponseDescriptor instead')
const SocialAuthorizeResponse$json = const {
  '1': 'SocialAuthorizeResponse',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.User', '10': 'user'},
  ],
};

/// Descriptor for `SocialAuthorizeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List socialAuthorizeResponseDescriptor = $convert.base64Decode('ChdTb2NpYWxBdXRob3JpemVSZXNwb25zZRIZCgR1c2VyGAEgASgLMgUuVXNlclIEdXNlcg==');
@$core.Deprecated('Use tokenAuthorizeRequestDescriptor instead')
const TokenAuthorizeRequest$json = const {
  '1': 'TokenAuthorizeRequest',
  '2': const [
    const {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `TokenAuthorizeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tokenAuthorizeRequestDescriptor = $convert.base64Decode('ChVUb2tlbkF1dGhvcml6ZVJlcXVlc3QSFAoFdG9rZW4YASABKAlSBXRva2Vu');
@$core.Deprecated('Use tokenAuthorizeResponseDescriptor instead')
const TokenAuthorizeResponse$json = const {
  '1': 'TokenAuthorizeResponse',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.User', '10': 'user'},
  ],
};

/// Descriptor for `TokenAuthorizeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tokenAuthorizeResponseDescriptor = $convert.base64Decode('ChZUb2tlbkF1dGhvcml6ZVJlc3BvbnNlEhkKBHVzZXIYASABKAsyBS5Vc2VyUgR1c2Vy');
@$core.Deprecated('Use userDescriptor instead')
const User$json = const {
  '1': 'User',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'token', '3': 3, '4': 1, '5': 9, '10': 'token'},
    const {'1': 'balance', '3': 4, '4': 1, '5': 5, '10': 'balance'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode('CgRVc2VyEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEhQKBXRva2VuGAMgASgJUgV0b2tlbhIYCgdiYWxhbmNlGAQgASgFUgdiYWxhbmNl');
@$core.Deprecated('Use getDetailRequestDescriptor instead')
const GetDetailRequest$json = const {
  '1': 'GetDetailRequest',
  '2': const [
    const {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    const {'1': 'place', '3': 2, '4': 1, '5': 9, '10': 'place'},
    const {'1': 'detail', '3': 3, '4': 1, '5': 9, '10': 'detail'},
    const {'1': 'language', '3': 4, '4': 1, '5': 9, '10': 'language'},
  ],
};

/// Descriptor for `GetDetailRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDetailRequestDescriptor = $convert.base64Decode('ChBHZXREZXRhaWxSZXF1ZXN0EhQKBXRva2VuGAEgASgJUgV0b2tlbhIUCgVwbGFjZRgCIAEoCVIFcGxhY2USFgoGZGV0YWlsGAMgASgJUgZkZXRhaWwSGgoIbGFuZ3VhZ2UYBCABKAlSCGxhbmd1YWdl');
@$core.Deprecated('Use getDetailResponseDescriptor instead')
const GetDetailResponse$json = const {
  '1': 'GetDetailResponse',
  '2': const [
    const {'1': 'content', '3': 1, '4': 1, '5': 9, '10': 'content'},
  ],
};

/// Descriptor for `GetDetailResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDetailResponseDescriptor = $convert.base64Decode('ChFHZXREZXRhaWxSZXNwb25zZRIYCgdjb250ZW50GAEgASgJUgdjb250ZW50');
@$core.Deprecated('Use buyCreditRequestDescriptor instead')
const BuyCreditRequest$json = const {
  '1': 'BuyCreditRequest',
  '2': const [
    const {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 5, '10': 'amount'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `BuyCreditRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyCreditRequestDescriptor = $convert.base64Decode('ChBCdXlDcmVkaXRSZXF1ZXN0EhQKBXRva2VuGAEgASgJUgV0b2tlbhIWCgZhbW91bnQYAiABKAVSBmFtb3VudBIaCghjdXJyZW5jeRgDIAEoCVIIY3VycmVuY3k=');
@$core.Deprecated('Use buyCreditResponseDescriptor instead')
const BuyCreditResponse$json = const {
  '1': 'BuyCreditResponse',
  '2': const [
    const {'1': 'clientSecret', '3': 1, '4': 1, '5': 9, '10': 'clientSecret'},
  ],
};

/// Descriptor for `BuyCreditResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyCreditResponseDescriptor = $convert.base64Decode('ChFCdXlDcmVkaXRSZXNwb25zZRIiCgxjbGllbnRTZWNyZXQYASABKAlSDGNsaWVudFNlY3JldA==');
@$core.Deprecated('Use pingRequestDescriptor instead')
const PingRequest$json = const {
  '1': 'PingRequest',
};

/// Descriptor for `PingRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pingRequestDescriptor = $convert.base64Decode('CgtQaW5nUmVxdWVzdA==');
@$core.Deprecated('Use pingResponseDescriptor instead')
const PingResponse$json = const {
  '1': 'PingResponse',
};

/// Descriptor for `PingResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pingResponseDescriptor = $convert.base64Decode('CgxQaW5nUmVzcG9uc2U=');
@$core.Deprecated('Use getCurrentVersionRequestDescriptor instead')
const GetCurrentVersionRequest$json = const {
  '1': 'GetCurrentVersionRequest',
};

/// Descriptor for `GetCurrentVersionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCurrentVersionRequestDescriptor = $convert.base64Decode('ChhHZXRDdXJyZW50VmVyc2lvblJlcXVlc3Q=');
@$core.Deprecated('Use getCurrentVersionResponseDescriptor instead')
const GetCurrentVersionResponse$json = const {
  '1': 'GetCurrentVersionResponse',
  '2': const [
    const {'1': 'version', '3': 1, '4': 1, '5': 9, '10': 'version'},
  ],
};

/// Descriptor for `GetCurrentVersionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCurrentVersionResponseDescriptor = $convert.base64Decode('ChlHZXRDdXJyZW50VmVyc2lvblJlc3BvbnNlEhgKB3ZlcnNpb24YASABKAlSB3ZlcnNpb24=');
