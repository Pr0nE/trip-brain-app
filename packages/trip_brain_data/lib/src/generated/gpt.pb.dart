///
//  Generated code. Do not modify.
//  source: gpt.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class TravelSuggestionRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TravelSuggestionRequest', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accessToken', protoName: 'accessToken')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'basePlace', protoName: 'basePlace')
    ..pPS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'likes')
    ..pPS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dislikes')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'language')
    ..hasRequiredFields = false
  ;

  TravelSuggestionRequest._() : super();
  factory TravelSuggestionRequest({
    $core.String? accessToken,
    $core.String? basePlace,
    $core.Iterable<$core.String>? likes,
    $core.Iterable<$core.String>? dislikes,
    $core.String? language,
  }) {
    final _result = create();
    if (accessToken != null) {
      _result.accessToken = accessToken;
    }
    if (basePlace != null) {
      _result.basePlace = basePlace;
    }
    if (likes != null) {
      _result.likes.addAll(likes);
    }
    if (dislikes != null) {
      _result.dislikes.addAll(dislikes);
    }
    if (language != null) {
      _result.language = language;
    }
    return _result;
  }
  factory TravelSuggestionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TravelSuggestionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TravelSuggestionRequest clone() => TravelSuggestionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TravelSuggestionRequest copyWith(void Function(TravelSuggestionRequest) updates) => super.copyWith((message) => updates(message as TravelSuggestionRequest)) as TravelSuggestionRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TravelSuggestionRequest create() => TravelSuggestionRequest._();
  TravelSuggestionRequest createEmptyInstance() => create();
  static $pb.PbList<TravelSuggestionRequest> createRepeated() => $pb.PbList<TravelSuggestionRequest>();
  @$core.pragma('dart2js:noInline')
  static TravelSuggestionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TravelSuggestionRequest>(create);
  static TravelSuggestionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accessToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set accessToken($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccessToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccessToken() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get basePlace => $_getSZ(1);
  @$pb.TagNumber(2)
  set basePlace($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBasePlace() => $_has(1);
  @$pb.TagNumber(2)
  void clearBasePlace() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.String> get likes => $_getList(2);

  @$pb.TagNumber(4)
  $core.List<$core.String> get dislikes => $_getList(3);

  @$pb.TagNumber(5)
  $core.String get language => $_getSZ(4);
  @$pb.TagNumber(5)
  set language($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasLanguage() => $_has(4);
  @$pb.TagNumber(5)
  void clearLanguage() => clearField(5);
}

class TravelSuggestionResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TravelSuggestionResponse', createEmptyInstance: create)
    ..pc<TravelPlace>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'places', $pb.PbFieldType.PM, subBuilder: TravelPlace.create)
    ..hasRequiredFields = false
  ;

  TravelSuggestionResponse._() : super();
  factory TravelSuggestionResponse({
    $core.Iterable<TravelPlace>? places,
  }) {
    final _result = create();
    if (places != null) {
      _result.places.addAll(places);
    }
    return _result;
  }
  factory TravelSuggestionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TravelSuggestionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TravelSuggestionResponse clone() => TravelSuggestionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TravelSuggestionResponse copyWith(void Function(TravelSuggestionResponse) updates) => super.copyWith((message) => updates(message as TravelSuggestionResponse)) as TravelSuggestionResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TravelSuggestionResponse create() => TravelSuggestionResponse._();
  TravelSuggestionResponse createEmptyInstance() => create();
  static $pb.PbList<TravelSuggestionResponse> createRepeated() => $pb.PbList<TravelSuggestionResponse>();
  @$core.pragma('dart2js:noInline')
  static TravelSuggestionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TravelSuggestionResponse>(create);
  static TravelSuggestionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<TravelPlace> get places => $_getList(0);
}

class PlaceImageRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PlaceImageRequest', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accessToken', protoName: 'accessToken')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'place')
    ..hasRequiredFields = false
  ;

  PlaceImageRequest._() : super();
  factory PlaceImageRequest({
    $core.String? accessToken,
    $core.String? place,
  }) {
    final _result = create();
    if (accessToken != null) {
      _result.accessToken = accessToken;
    }
    if (place != null) {
      _result.place = place;
    }
    return _result;
  }
  factory PlaceImageRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PlaceImageRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PlaceImageRequest clone() => PlaceImageRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PlaceImageRequest copyWith(void Function(PlaceImageRequest) updates) => super.copyWith((message) => updates(message as PlaceImageRequest)) as PlaceImageRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PlaceImageRequest create() => PlaceImageRequest._();
  PlaceImageRequest createEmptyInstance() => create();
  static $pb.PbList<PlaceImageRequest> createRepeated() => $pb.PbList<PlaceImageRequest>();
  @$core.pragma('dart2js:noInline')
  static PlaceImageRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PlaceImageRequest>(create);
  static PlaceImageRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accessToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set accessToken($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccessToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccessToken() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get place => $_getSZ(1);
  @$pb.TagNumber(2)
  set place($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPlace() => $_has(1);
  @$pb.TagNumber(2)
  void clearPlace() => clearField(2);
}

class PlaceImageResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PlaceImageResponse', createEmptyInstance: create)
    ..pPS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'imageUrls', protoName: 'imageUrls')
    ..hasRequiredFields = false
  ;

  PlaceImageResponse._() : super();
  factory PlaceImageResponse({
    $core.Iterable<$core.String>? imageUrls,
  }) {
    final _result = create();
    if (imageUrls != null) {
      _result.imageUrls.addAll(imageUrls);
    }
    return _result;
  }
  factory PlaceImageResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PlaceImageResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PlaceImageResponse clone() => PlaceImageResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PlaceImageResponse copyWith(void Function(PlaceImageResponse) updates) => super.copyWith((message) => updates(message as PlaceImageResponse)) as PlaceImageResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PlaceImageResponse create() => PlaceImageResponse._();
  PlaceImageResponse createEmptyInstance() => create();
  static $pb.PbList<PlaceImageResponse> createRepeated() => $pb.PbList<PlaceImageResponse>();
  @$core.pragma('dart2js:noInline')
  static PlaceImageResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PlaceImageResponse>(create);
  static PlaceImageResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get imageUrls => $_getList(0);
}

class TravelPlace extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TravelPlace', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..hasRequiredFields = false
  ;

  TravelPlace._() : super();
  factory TravelPlace({
    $core.String? title,
    $core.String? description,
  }) {
    final _result = create();
    if (title != null) {
      _result.title = title;
    }
    if (description != null) {
      _result.description = description;
    }
    return _result;
  }
  factory TravelPlace.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TravelPlace.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TravelPlace clone() => TravelPlace()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TravelPlace copyWith(void Function(TravelPlace) updates) => super.copyWith((message) => updates(message as TravelPlace)) as TravelPlace; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TravelPlace create() => TravelPlace._();
  TravelPlace createEmptyInstance() => create();
  static $pb.PbList<TravelPlace> createRepeated() => $pb.PbList<TravelPlace>();
  @$core.pragma('dart2js:noInline')
  static TravelPlace getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TravelPlace>(create);
  static TravelPlace? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => clearField(2);
}

class SocialAuthorizeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SocialAuthorizeRequest', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'token')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'provider')
    ..hasRequiredFields = false
  ;

  SocialAuthorizeRequest._() : super();
  factory SocialAuthorizeRequest({
    $core.String? token,
    $core.String? provider,
  }) {
    final _result = create();
    if (token != null) {
      _result.token = token;
    }
    if (provider != null) {
      _result.provider = provider;
    }
    return _result;
  }
  factory SocialAuthorizeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SocialAuthorizeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SocialAuthorizeRequest clone() => SocialAuthorizeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SocialAuthorizeRequest copyWith(void Function(SocialAuthorizeRequest) updates) => super.copyWith((message) => updates(message as SocialAuthorizeRequest)) as SocialAuthorizeRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SocialAuthorizeRequest create() => SocialAuthorizeRequest._();
  SocialAuthorizeRequest createEmptyInstance() => create();
  static $pb.PbList<SocialAuthorizeRequest> createRepeated() => $pb.PbList<SocialAuthorizeRequest>();
  @$core.pragma('dart2js:noInline')
  static SocialAuthorizeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SocialAuthorizeRequest>(create);
  static SocialAuthorizeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get provider => $_getSZ(1);
  @$pb.TagNumber(2)
  set provider($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasProvider() => $_has(1);
  @$pb.TagNumber(2)
  void clearProvider() => clearField(2);
}

class SocialAuthorizeResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SocialAuthorizeResponse', createEmptyInstance: create)
    ..aOM<User>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'user', subBuilder: User.create)
    ..hasRequiredFields = false
  ;

  SocialAuthorizeResponse._() : super();
  factory SocialAuthorizeResponse({
    User? user,
  }) {
    final _result = create();
    if (user != null) {
      _result.user = user;
    }
    return _result;
  }
  factory SocialAuthorizeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SocialAuthorizeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SocialAuthorizeResponse clone() => SocialAuthorizeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SocialAuthorizeResponse copyWith(void Function(SocialAuthorizeResponse) updates) => super.copyWith((message) => updates(message as SocialAuthorizeResponse)) as SocialAuthorizeResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SocialAuthorizeResponse create() => SocialAuthorizeResponse._();
  SocialAuthorizeResponse createEmptyInstance() => create();
  static $pb.PbList<SocialAuthorizeResponse> createRepeated() => $pb.PbList<SocialAuthorizeResponse>();
  @$core.pragma('dart2js:noInline')
  static SocialAuthorizeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SocialAuthorizeResponse>(create);
  static SocialAuthorizeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  User get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(User v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => clearField(1);
  @$pb.TagNumber(1)
  User ensureUser() => $_ensure(0);
}

class TokenAuthorizeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TokenAuthorizeRequest', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'token')
    ..hasRequiredFields = false
  ;

  TokenAuthorizeRequest._() : super();
  factory TokenAuthorizeRequest({
    $core.String? token,
  }) {
    final _result = create();
    if (token != null) {
      _result.token = token;
    }
    return _result;
  }
  factory TokenAuthorizeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TokenAuthorizeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TokenAuthorizeRequest clone() => TokenAuthorizeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TokenAuthorizeRequest copyWith(void Function(TokenAuthorizeRequest) updates) => super.copyWith((message) => updates(message as TokenAuthorizeRequest)) as TokenAuthorizeRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TokenAuthorizeRequest create() => TokenAuthorizeRequest._();
  TokenAuthorizeRequest createEmptyInstance() => create();
  static $pb.PbList<TokenAuthorizeRequest> createRepeated() => $pb.PbList<TokenAuthorizeRequest>();
  @$core.pragma('dart2js:noInline')
  static TokenAuthorizeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TokenAuthorizeRequest>(create);
  static TokenAuthorizeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => clearField(1);
}

class TokenAuthorizeResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TokenAuthorizeResponse', createEmptyInstance: create)
    ..aOM<User>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'user', subBuilder: User.create)
    ..hasRequiredFields = false
  ;

  TokenAuthorizeResponse._() : super();
  factory TokenAuthorizeResponse({
    User? user,
  }) {
    final _result = create();
    if (user != null) {
      _result.user = user;
    }
    return _result;
  }
  factory TokenAuthorizeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TokenAuthorizeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TokenAuthorizeResponse clone() => TokenAuthorizeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TokenAuthorizeResponse copyWith(void Function(TokenAuthorizeResponse) updates) => super.copyWith((message) => updates(message as TokenAuthorizeResponse)) as TokenAuthorizeResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TokenAuthorizeResponse create() => TokenAuthorizeResponse._();
  TokenAuthorizeResponse createEmptyInstance() => create();
  static $pb.PbList<TokenAuthorizeResponse> createRepeated() => $pb.PbList<TokenAuthorizeResponse>();
  @$core.pragma('dart2js:noInline')
  static TokenAuthorizeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TokenAuthorizeResponse>(create);
  static TokenAuthorizeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  User get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(User v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => clearField(1);
  @$pb.TagNumber(1)
  User ensureUser() => $_ensure(0);
}

class User extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'User', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'token')
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'balance', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  User._() : super();
  factory User({
    $core.String? id,
    $core.String? name,
    $core.String? token,
    $core.int? balance,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (token != null) {
      _result.token = token;
    }
    if (balance != null) {
      _result.balance = balance;
    }
    return _result;
  }
  factory User.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory User.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  User clone() => User()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  User copyWith(void Function(User) updates) => super.copyWith((message) => updates(message as User)) as User; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static User create() => User._();
  User createEmptyInstance() => create();
  static $pb.PbList<User> createRepeated() => $pb.PbList<User>();
  @$core.pragma('dart2js:noInline')
  static User getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<User>(create);
  static User? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get token => $_getSZ(2);
  @$pb.TagNumber(3)
  set token($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearToken() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get balance => $_getIZ(3);
  @$pb.TagNumber(4)
  set balance($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBalance() => $_has(3);
  @$pb.TagNumber(4)
  void clearBalance() => clearField(4);
}

class GetDetailRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetDetailRequest', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'token')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'place')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'detail')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'language')
    ..hasRequiredFields = false
  ;

  GetDetailRequest._() : super();
  factory GetDetailRequest({
    $core.String? token,
    $core.String? place,
    $core.String? detail,
    $core.String? language,
  }) {
    final _result = create();
    if (token != null) {
      _result.token = token;
    }
    if (place != null) {
      _result.place = place;
    }
    if (detail != null) {
      _result.detail = detail;
    }
    if (language != null) {
      _result.language = language;
    }
    return _result;
  }
  factory GetDetailRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetDetailRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetDetailRequest clone() => GetDetailRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetDetailRequest copyWith(void Function(GetDetailRequest) updates) => super.copyWith((message) => updates(message as GetDetailRequest)) as GetDetailRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetDetailRequest create() => GetDetailRequest._();
  GetDetailRequest createEmptyInstance() => create();
  static $pb.PbList<GetDetailRequest> createRepeated() => $pb.PbList<GetDetailRequest>();
  @$core.pragma('dart2js:noInline')
  static GetDetailRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetDetailRequest>(create);
  static GetDetailRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get place => $_getSZ(1);
  @$pb.TagNumber(2)
  set place($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPlace() => $_has(1);
  @$pb.TagNumber(2)
  void clearPlace() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get detail => $_getSZ(2);
  @$pb.TagNumber(3)
  set detail($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDetail() => $_has(2);
  @$pb.TagNumber(3)
  void clearDetail() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get language => $_getSZ(3);
  @$pb.TagNumber(4)
  set language($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLanguage() => $_has(3);
  @$pb.TagNumber(4)
  void clearLanguage() => clearField(4);
}

class GetDetailResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetDetailResponse', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'content')
    ..hasRequiredFields = false
  ;

  GetDetailResponse._() : super();
  factory GetDetailResponse({
    $core.String? content,
  }) {
    final _result = create();
    if (content != null) {
      _result.content = content;
    }
    return _result;
  }
  factory GetDetailResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetDetailResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetDetailResponse clone() => GetDetailResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetDetailResponse copyWith(void Function(GetDetailResponse) updates) => super.copyWith((message) => updates(message as GetDetailResponse)) as GetDetailResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetDetailResponse create() => GetDetailResponse._();
  GetDetailResponse createEmptyInstance() => create();
  static $pb.PbList<GetDetailResponse> createRepeated() => $pb.PbList<GetDetailResponse>();
  @$core.pragma('dart2js:noInline')
  static GetDetailResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetDetailResponse>(create);
  static GetDetailResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get content => $_getSZ(0);
  @$pb.TagNumber(1)
  set content($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasContent() => $_has(0);
  @$pb.TagNumber(1)
  void clearContent() => clearField(1);
}

class BuyCreditRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BuyCreditRequest', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'token')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.O3)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..hasRequiredFields = false
  ;

  BuyCreditRequest._() : super();
  factory BuyCreditRequest({
    $core.String? token,
    $core.int? amount,
    $core.String? currency,
  }) {
    final _result = create();
    if (token != null) {
      _result.token = token;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    return _result;
  }
  factory BuyCreditRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BuyCreditRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BuyCreditRequest clone() => BuyCreditRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BuyCreditRequest copyWith(void Function(BuyCreditRequest) updates) => super.copyWith((message) => updates(message as BuyCreditRequest)) as BuyCreditRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BuyCreditRequest create() => BuyCreditRequest._();
  BuyCreditRequest createEmptyInstance() => create();
  static $pb.PbList<BuyCreditRequest> createRepeated() => $pb.PbList<BuyCreditRequest>();
  @$core.pragma('dart2js:noInline')
  static BuyCreditRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BuyCreditRequest>(create);
  static BuyCreditRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get amount => $_getIZ(1);
  @$pb.TagNumber(2)
  set amount($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => clearField(3);
}

class BuyCreditResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BuyCreditResponse', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'clientSecret', protoName: 'clientSecret')
    ..hasRequiredFields = false
  ;

  BuyCreditResponse._() : super();
  factory BuyCreditResponse({
    $core.String? clientSecret,
  }) {
    final _result = create();
    if (clientSecret != null) {
      _result.clientSecret = clientSecret;
    }
    return _result;
  }
  factory BuyCreditResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BuyCreditResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BuyCreditResponse clone() => BuyCreditResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BuyCreditResponse copyWith(void Function(BuyCreditResponse) updates) => super.copyWith((message) => updates(message as BuyCreditResponse)) as BuyCreditResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BuyCreditResponse create() => BuyCreditResponse._();
  BuyCreditResponse createEmptyInstance() => create();
  static $pb.PbList<BuyCreditResponse> createRepeated() => $pb.PbList<BuyCreditResponse>();
  @$core.pragma('dart2js:noInline')
  static BuyCreditResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BuyCreditResponse>(create);
  static BuyCreditResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get clientSecret => $_getSZ(0);
  @$pb.TagNumber(1)
  set clientSecret($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasClientSecret() => $_has(0);
  @$pb.TagNumber(1)
  void clearClientSecret() => clearField(1);
}

class FetchPricesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FetchPricesRequest', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  FetchPricesRequest._() : super();
  factory FetchPricesRequest() => create();
  factory FetchPricesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FetchPricesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FetchPricesRequest clone() => FetchPricesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FetchPricesRequest copyWith(void Function(FetchPricesRequest) updates) => super.copyWith((message) => updates(message as FetchPricesRequest)) as FetchPricesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FetchPricesRequest create() => FetchPricesRequest._();
  FetchPricesRequest createEmptyInstance() => create();
  static $pb.PbList<FetchPricesRequest> createRepeated() => $pb.PbList<FetchPricesRequest>();
  @$core.pragma('dart2js:noInline')
  static FetchPricesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FetchPricesRequest>(create);
  static FetchPricesRequest? _defaultInstance;
}

class SuggestionPrice extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SuggestionPrice', createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'price', $pb.PbFieldType.OF)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'suggestionAmount', $pb.PbFieldType.O3, protoName: 'suggestionAmount')
    ..hasRequiredFields = false
  ;

  SuggestionPrice._() : super();
  factory SuggestionPrice({
    $core.double? price,
    $core.int? suggestionAmount,
  }) {
    final _result = create();
    if (price != null) {
      _result.price = price;
    }
    if (suggestionAmount != null) {
      _result.suggestionAmount = suggestionAmount;
    }
    return _result;
  }
  factory SuggestionPrice.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SuggestionPrice.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SuggestionPrice clone() => SuggestionPrice()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SuggestionPrice copyWith(void Function(SuggestionPrice) updates) => super.copyWith((message) => updates(message as SuggestionPrice)) as SuggestionPrice; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SuggestionPrice create() => SuggestionPrice._();
  SuggestionPrice createEmptyInstance() => create();
  static $pb.PbList<SuggestionPrice> createRepeated() => $pb.PbList<SuggestionPrice>();
  @$core.pragma('dart2js:noInline')
  static SuggestionPrice getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SuggestionPrice>(create);
  static SuggestionPrice? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get price => $_getN(0);
  @$pb.TagNumber(1)
  set price($core.double v) { $_setFloat(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPrice() => $_has(0);
  @$pb.TagNumber(1)
  void clearPrice() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get suggestionAmount => $_getIZ(1);
  @$pb.TagNumber(2)
  set suggestionAmount($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuggestionAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuggestionAmount() => clearField(2);
}

class FetchPricesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FetchPricesResponse', createEmptyInstance: create)
    ..pc<SuggestionPrice>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'prices', $pb.PbFieldType.PM, subBuilder: SuggestionPrice.create)
    ..hasRequiredFields = false
  ;

  FetchPricesResponse._() : super();
  factory FetchPricesResponse({
    $core.Iterable<SuggestionPrice>? prices,
  }) {
    final _result = create();
    if (prices != null) {
      _result.prices.addAll(prices);
    }
    return _result;
  }
  factory FetchPricesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FetchPricesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FetchPricesResponse clone() => FetchPricesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FetchPricesResponse copyWith(void Function(FetchPricesResponse) updates) => super.copyWith((message) => updates(message as FetchPricesResponse)) as FetchPricesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FetchPricesResponse create() => FetchPricesResponse._();
  FetchPricesResponse createEmptyInstance() => create();
  static $pb.PbList<FetchPricesResponse> createRepeated() => $pb.PbList<FetchPricesResponse>();
  @$core.pragma('dart2js:noInline')
  static FetchPricesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FetchPricesResponse>(create);
  static FetchPricesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<SuggestionPrice> get prices => $_getList(0);
}

class PingRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PingRequest', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  PingRequest._() : super();
  factory PingRequest() => create();
  factory PingRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PingRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PingRequest clone() => PingRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PingRequest copyWith(void Function(PingRequest) updates) => super.copyWith((message) => updates(message as PingRequest)) as PingRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PingRequest create() => PingRequest._();
  PingRequest createEmptyInstance() => create();
  static $pb.PbList<PingRequest> createRepeated() => $pb.PbList<PingRequest>();
  @$core.pragma('dart2js:noInline')
  static PingRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PingRequest>(create);
  static PingRequest? _defaultInstance;
}

class PingResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PingResponse', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  PingResponse._() : super();
  factory PingResponse() => create();
  factory PingResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PingResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PingResponse clone() => PingResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PingResponse copyWith(void Function(PingResponse) updates) => super.copyWith((message) => updates(message as PingResponse)) as PingResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PingResponse create() => PingResponse._();
  PingResponse createEmptyInstance() => create();
  static $pb.PbList<PingResponse> createRepeated() => $pb.PbList<PingResponse>();
  @$core.pragma('dart2js:noInline')
  static PingResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PingResponse>(create);
  static PingResponse? _defaultInstance;
}

class GetCurrentVersionRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCurrentVersionRequest', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetCurrentVersionRequest._() : super();
  factory GetCurrentVersionRequest() => create();
  factory GetCurrentVersionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCurrentVersionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCurrentVersionRequest clone() => GetCurrentVersionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCurrentVersionRequest copyWith(void Function(GetCurrentVersionRequest) updates) => super.copyWith((message) => updates(message as GetCurrentVersionRequest)) as GetCurrentVersionRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetCurrentVersionRequest create() => GetCurrentVersionRequest._();
  GetCurrentVersionRequest createEmptyInstance() => create();
  static $pb.PbList<GetCurrentVersionRequest> createRepeated() => $pb.PbList<GetCurrentVersionRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCurrentVersionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCurrentVersionRequest>(create);
  static GetCurrentVersionRequest? _defaultInstance;
}

class GetCurrentVersionResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCurrentVersionResponse', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'version')
    ..hasRequiredFields = false
  ;

  GetCurrentVersionResponse._() : super();
  factory GetCurrentVersionResponse({
    $core.String? version,
  }) {
    final _result = create();
    if (version != null) {
      _result.version = version;
    }
    return _result;
  }
  factory GetCurrentVersionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCurrentVersionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCurrentVersionResponse clone() => GetCurrentVersionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCurrentVersionResponse copyWith(void Function(GetCurrentVersionResponse) updates) => super.copyWith((message) => updates(message as GetCurrentVersionResponse)) as GetCurrentVersionResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetCurrentVersionResponse create() => GetCurrentVersionResponse._();
  GetCurrentVersionResponse createEmptyInstance() => create();
  static $pb.PbList<GetCurrentVersionResponse> createRepeated() => $pb.PbList<GetCurrentVersionResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCurrentVersionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCurrentVersionResponse>(create);
  static GetCurrentVersionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get version => $_getSZ(0);
  @$pb.TagNumber(1)
  set version($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersion() => clearField(1);
}

