package com.ninefrost.agora

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

class AgoraPlugin(private val registrar: Registrar, private val channel: MethodChannel): MethodCallHandler {
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "ninefrost.com/agora")
      AgoraModule.setRegistrar(registrar)
      AgoraModule.setMethodChannel(channel)
      channel.setMethodCallHandler(AgoraPlugin(registrar, channel))
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == Constant.CREATE_AGORA_ENGINE) {
      AgoraModule.createAgoraEngine(call)
      return result.success(mapOf("success" to true))
    }

    if(call.method == Constant.JOIN_CHANNEL) {
      AgoraModule.joinChannel(call)
      return result.success(mapOf("success" to true))
    }

    if(call.method == Constant.JOIN_CHANNEL_WITH_TOKEN) {
      AgoraModule.joinChannelWithToken(call)
      return result.success(mapOf("success" to true))
    }

    if(call.method == Constant.ENABLE_LASTMILE_TEST) {
      AgoraModule.enableLastmileTest()
      return result.success(mapOf("success" to true))
    }

    if(call.method == Constant.DISABLE_LASTMILE_TEST) {
      AgoraModule.disableLastmileTest()
      return result.success(mapOf("success" to true))
    }

    if(call.method == Constant.LEAVE_CHANNEL) {
      AgoraModule.leaveChannel()
      return result.success(mapOf("success" to true))
    }

    if(call.method == Constant.SET_CLIENT_ROLE) {
      AgoraModule.setClientRole(call)
      return result.success(mapOf("success" to true))
    }

    if(call.method == Constant.ENABLE_AUDIO_VOLUME_INDICATION) {
      AgoraModule.enableAudioVolumeIndication(call)
      return result.success(mapOf("success" to true))
    }

    if(call.method == Constant.ENABLE_AUDIO) {
      AgoraModule.enableAudio()
      return result.success(mapOf("success" to true))
    }

    if(call.method == Constant.DISABLE_AUDIO) {
      AgoraModule.disableAudio()
      return result.success(mapOf("success" to true))
    }

    if(call.method == Constant.SET_ENABLE_SPEAKERPHONE) {
      AgoraModule.setEnableSpeakerphone(call)
      return result.success(mapOf("success" to true))
    }

    if(call.method == Constant.MUTE_LOCAL_AUDIO_STREAM) {
      AgoraModule.muteLocalAudioStream(call)
      return result.success(mapOf("success" to true))
    }

    if(call.method == Constant.MUTE_ALL_REMOTE_AUDIO_STREAMS) {
      AgoraModule.muteAllRemoteAudioStreams(call)
      return result.success(mapOf("success" to true))
    }

    if(call.method == Constant.SET_DEFAULT_AUDIO_ROUTE_TO_SPEAKERPHONE) {
      AgoraModule.setDefaultAudioRouteToSpeakerphone(call)
      return result.success(mapOf("success" to true))
    }

    if(call.method == Constant.MUTE_REMOTE_AUDIO_STREAM) {
      AgoraModule.muteRemoteAudioStream(call)
      return result.success(mapOf("success" to true))
    }

    if(call.method == Constant.CREATE_DATA_STREAM) {
      AgoraModule.createDataStream(call, result)
      return result.success(mapOf("success" to true))
    }

    if(call.method == Constant.SEND_STREAM_MESSAGE) {
      AgoraModule.sendStreamMessage(call, result)
      return result.success(mapOf("success" to true))
    }

    if(call.method == Constant.GET_SDK_VERSION) {
      AgoraModule.getSdkVersion(result)
    }

    if(call.method == Constant.START_AUDIO_MIXING) {
      AgoraModule.startAudioMixing(call, result)
    }

    if(call.method == Constant.ADJUST_AUDIOMIXING_VOLUME) {
      AgoraModule.adjustAudioMixingVolume(call, result)
    }

    if(call.method == Constant.GET_AUDIO_MIXING_DURATION) {
      AgoraModule.getAudioMixingDuration(result)
    }

    if(call.method == Constant.GET_AUDIO_MIXING_CURRENTPOSITION) {
      AgoraModule.getAudioMixingCurrentPosition(result)
    }

    if(call.method == Constant.PAUSE_AUDIO_MIXING) {
      AgoraModule.pauseAudioMixing(result)
    }

    if(call.method == Constant.RESUME_AUDIO_MIXING) {
      AgoraModule.resumeAudioMixing(result)
    }

    if(call.method == Constant.STOP_AUDIO_MIXING) {
      AgoraModule.stopAudioMixing(result)
    }

    if("destroy" == call.method) {
      AgoraModule.destroy()
      result.success(mapOf("success" to true))
    }else {
      result.notImplemented()
    }
  }
}
