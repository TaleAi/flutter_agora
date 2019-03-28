import 'dart:async';

import 'package:flutter/services.dart';

class Agora {
  static final MethodChannel _channel =
      const MethodChannel('ninefrost.com/agora')
        ..setMethodCallHandler(_handler);

  static StreamController<Map> _responseFromJoinChannelSuccessController =
      new StreamController.broadcast();

  /**
   * 加入频道成功监听
   */
  static Stream<Map> get responseFromJoinChannelSuccess =>
      _responseFromJoinChannelSuccessController.stream;

  static StreamController<Map> _responseFromUserJoinedController =
      new StreamController.broadcast();

  /**
   * 有其它用户加入监听
   */
  static Stream<Map> get responseFromUserJoined =>
      _responseFromUserJoinedController.stream;

  static StreamController<Map> _responseFromUserOfflineController =
      new StreamController.broadcast();

  /**
   * 用户离线监听
   */
  static Stream<Map> get responseFromUserOffline =>
      _responseFromUserOfflineController.stream;

  static StreamController<Map> _responseFromAudioVolumeIndicationController =
      new StreamController.broadcast();

  /**
   * 说话声音回调
   */
  static Stream<Map> get responseFromAudioVolumeIndication =>
      _responseFromAudioVolumeIndicationController.stream;

  static StreamController<Map> _responseFromAudioQualityController =
      new StreamController.broadcast();

  static Stream<Map> get responseFromAudioQuality =>
      _responseFromAudioQualityController.stream;

  static StreamController<Map> _responseFromErrorController =
      new StreamController.broadcast();

  /**
   * 错误监听
   */
  static Stream<Map> get responseFromError =>
      _responseFromErrorController.stream;

  static StreamController<Map> _responseFromWarningController =
      new StreamController.broadcast();

  /**
   * 警告监听
   */
  static Stream<Map> get responseFromWarning =>
      _responseFromWarningController.stream;

  static StreamController<Map> _responseLeaveChannelController =
      new StreamController.broadcast();

  /**
   * 退出频道监听
   */
  static Stream<Map> get responseLeaveChannel =>
      _responseLeaveChannelController.stream;

  static StreamController<Map> _responseFromUserMuteAudioController =
      new StreamController.broadcast();

  /**
   * 静音监听
   */
  static Stream<Map> get responseFromUserMuteAudio =>
      _responseFromUserMuteAudioController.stream;

  static StreamController<Map> _responseFromConnectionLostController =
      new StreamController.broadcast();

  static Stream<Map> get responseFromConnectionLost =>
      _responseFromConnectionLostController.stream;

  static StreamController<Map> _responseFromNetworkQualityController =
      new StreamController.broadcast();

  static Stream<Map> get responseFromNetworkQuality =>
      _responseFromNetworkQualityController.stream;

  static StreamController<Map> _responseFromLastmileQualityController =
      new StreamController.broadcast();

  static Stream<Map> get responseFromLastmileQuality =>
      _responseFromLastmileQualityController.stream;

  /**
   * 回调时调用的对应函数
   */
  static Future<dynamic> _handler(MethodCall methodCall) {
    if ("onJoinChannelSuccess" == methodCall.method) {
      _responseFromJoinChannelSuccessController.add(methodCall.arguments);
    } else if ("onUserJoined" == methodCall.method) {
      _responseFromUserJoinedController.add(methodCall.arguments);
    } else if ("onUserOffline" == methodCall.method) {
      _responseFromUserOfflineController.add(methodCall.arguments);
    } else if ("onAudioVolumeIndication" == methodCall.method) {
      _responseFromAudioVolumeIndicationController.add(methodCall.arguments);
    } else if ("onAudioQuality" == methodCall.method) {
      _responseFromAudioQualityController.add(methodCall.arguments);
    } else if ("onError" == methodCall.method) {
      _responseFromErrorController.add(methodCall.arguments);
    } else if ("onWarning" == methodCall.method) {
      _responseFromWarningController.add(methodCall.arguments);
    } else if ("onLeaveChannel" == methodCall.method) {
      _responseLeaveChannelController.add(methodCall.arguments);
    } else if ("onUserMuteAudio" == methodCall.method) {
      _responseFromUserMuteAudioController.add(methodCall.arguments);
    } else if ("onConnectionLost" == methodCall.method) {
      _responseFromConnectionLostController.add(methodCall.arguments);
    } else if ("onNetworkQuality" == methodCall.method) {
      _responseFromNetworkQualityController.add(methodCall.arguments);
    } else if ("onLastmileQuality" == methodCall.method) {
      _responseFromLastmileQualityController.add(methodCall.arguments);
    }

    return Future.value(true);
  }

  /// 初始化一个实例
  static Future create(String appId, int channelProfile) async {
    return await _channel.invokeMethod('createAgoraEngine',
        {'appid': appId, 'channelProfile': channelProfile});
  }

  /// 加入指定频道
  static Future joinChannel(String channelName, {int uid = 0}) async {
    return await _channel
        .invokeMethod('joinChannel', {'channelName': channelName, 'uid': uid});
  }

  /// 根据token加入频道
  static Future joinChannelWithToken(
      String token, String channelName, int uid) async {
    return await _channel.invokeMethod('joinChannelWithToken',
        {'channelName': channelName, 'uid': uid, 'token': token});
  }

  static Future enableLastmileTest() async {
    return await _channel.invokeMethod('enableLastmileTest');
  }

  static Future disableLastmileTest() async {
    await _channel.invokeMethod('disableLastmileTest');
  }

  static Future leaveChannel() async {
    return await _channel.invokeMethod('leaveChannel');
  }

//  static Future configPublisher() async {
//    await _channel.invokeMethod('configPublisher');
//  }

  static Future enableAudioVolumeIndication(int interval, int smooth) async {
    return await _channel.invokeMethod('enableAudioVolumeIndication',
        {'interval': interval, 'smooth': smooth});
  }

  static Future enableAudio() async {
    return await _channel.invokeMethod('enableAudio');
  }

  static Future disableAudio() async {
    return await _channel.invokeMethod('disableAudio');
  }

  static Future setEnableSpeakerphone(bool enabled) async {
    return await _channel
        .invokeMethod('setEnableSpeakerphone', {'enabled': enabled});
  }

  static Future muteLocalAudioStream(bool muted) async {
    return await _channel
        .invokeMethod('muteLocalAudioStream', {'muted': muted});
  }

  static Future muteAllRemoteAudioStreams(bool muted) async {
    return await _channel
        .invokeMethod('muteAllRemoteAudioStreams', {'muted': muted});
  }

  static Future muteRemoteAudioStream(int uid, bool muted) async {
    return await _channel
        .invokeMethod('muteRemoteAudioStream', {'uid': uid, 'muted': muted});
  }

  static Future setDefaultAudioRouteToSpeakerphone(
      bool defaultToSpeaker) async {
    return await _channel.invokeMethod('setDefaultAudioRouteToSpeakerphone',
        {'defaultToSpeaker': defaultToSpeaker});
  }

//  static Future createDataStream(bool reliable, bool ordered) async {
//    return await _channel.invokeMethod(
//        'createDataStream', {'reliable': reliable, 'ordered': ordered});
//  }
//
//  static Future sendStreamMessage(int streamId, String message) async {
//    return await _channel.invokeMethod(
//        'sendStreamMessage', {'streamId': streamId, 'message': message});
//  }

  static Future getSdkVersion() async {
    return await _channel.invokeMethod('getSdkVersion');
  }

  static Future<int> startAudioMixing(String path,
      {int loopCount = 1,
      bool replaceMic = false,
      bool shouldLoop = false}) async {
    return await _channel.invokeMethod('startAudioMixing', {
      'path': path,
      'loopCount': loopCount,
      'replaceMic': replaceMic,
      'shouldLoop': shouldLoop
    });
  }

  /**
   * volume 0-100
   */
  static Future<int> adjustAudioMixingVolume(int volume) async {
    return await _channel
        .invokeMethod('adjustAudioMixingVolume', {'volume': volume});
  }

  static Future<int> getAudioMixingDuration() async {
    return await _channel.invokeMethod('getAudioMixingDuration');
  }

  static Future<int> getAudioMixingCurrentPosition() async{
    return await _channel.invokeMethod('getAudioMixingCurrentPosition');
  }

  static Future<int> pauseAudioMixing() async{
    return await _channel.invokeMethod('pauseAudioMixing');
  }

  static Future<int> resumeAudioMixing() async{
    return await _channel.invokeMethod('resumeAudioMixing');
  }

  static Future<int> stopAudioMixing() async{
    return await _channel.invokeMethod('stopAudioMixing');
  }

  static Future destroy() async {
    await _channel.invokeMethod('destroy');
  }

  static Future setClientRole(int role) async {
    await _channel.invokeMethod('setClientRole', {'role': role});
  }
//
//
//  static Future get joinChannel async {
//    await _channel.invokeMethod('');
//  }
}
