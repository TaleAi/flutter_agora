import Flutter
import UIKit

public class SwiftAgoraPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "ninefrost.com/agora", binaryMessenger: registrar.messenger())
    let instance = SwiftAgoraPlugin()
    AgoraManager.getInstance.setMethodChannel(channel: channel)
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if( CREATE_AGORA_ENGINE == call.method) {
        AgoraModule.initializeAgoraEngine(call, result: result)
    } else if(JOIN_CHANNEL == call.method) {
        AgoraModule.joinChannel(call, result: result)
    } else if(JOIN_CHANNEL_WITH_TOKEN == call.method){
        AgoraModule.joinChannelWithToken(call, result: result)
    } else if(ENABLE_LASTMILE_TEST == call.method){
        AgoraModule.enableLastmileTest(result: result)
    } else if(DISABLE_LASTMILE_TEST == call.method){
        AgoraModule.disableLastmileTest(result: result)
    } else if(LEAVE_CHANNEL == call.method){
        AgoraModule.leaveChannel(result: result)
    } else if(SET_CLIENT_ROLE == call.method){
        AgoraModule.setClientRole(call, result: result)
    } else if(ENABLE_AUDIO_VOLUME_INDICATION == call.method){
        AgoraModule.enableAudioVolumeIndication(call, result: result)
    } else if(ENABLE_AUDIO == call.method){
        AgoraModule.enableAudio(result: result)
    } else if(DISABLE_AUDIO == call.method){
        AgoraModule.disableAudio(result: result)
    } else if(SET_ENABLE_SPEAKERPHONE == call.method){
        AgoraModule.setEnableSpeakerphone(call, result: result)
    } else if(MUTE_LOCAL_AUDIO_STREAM == call.method){
        AgoraModule.muteLocalAudioStream(call, result: result)
    } else if(MUTE_ALL_REMOTE_AUDIO_STREAMS == call.method){
        AgoraModule.muteAllRemoteAudioStreams(call, result: result)
    } else if(MUTE_REMOTE_AUDIO_STREAM == call.method){
        AgoraModule.muteRemoteAudioStream(call, result: result)
    } else if(SET_DEFAULT_AUDIO_ROUTE_TO_SPEAKERPHONE == call.method){
        AgoraModule.setDefaultAudioRouteToSpeakerphone(call, result: result)
    } else if(CREATE_DATA_STREAM == call.method){
        AgoraModule.createDataStream(result: result)
    } else if(SEND_STREAM_MESSAGE == call.method){
        AgoraModule.sendStreamMessage(call, result: result)
    } else if(GET_SDK_VERSION == call.method){
        AgoraModule.getSdkVersion(result: result)
    } else if(START_AUDIO_MIXING == call.method){
        AgoraModule.startAudioMixing(call, result: result)
    } else if(ADJUST_AUDIOMIXING_VOLUME == call.method){
        AgoraModule.adjustAudioMixingVolume(call, result: result)
    } else if(GET_AUDIO_MIXING_DURATION == call.method){
        AgoraModule.getAudioMixingDuration(result: result)
    } else if(GET_AUDIO_MIXING_CURRENTPOSITION == call.method){
        AgoraModule.getAudioMixingDuration(result: result)
    } else if(PAUSE_AUDIO_MIXING == call.method){
        AgoraModule.pauseAudioMixing(result: result)
    } else if(RESUME_AUDIO_MIXING == call.method){
        AgoraModule.resumeAudioMixing(result: result)
    } else if(STOP_AUDIO_MIXING == call.method){
        AgoraModule.stopAudioMixing(result: result)
    } else if("destroy" == call.method){
        AgoraModule.destroy(result: result)
    }else {
        result(FlutterMethodNotImplemented)
    }
  }
}
