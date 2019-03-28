package com.ninefrost.agora

import com.ninefrost.agora.Constant
import android.util.Log

import io.agora.rtc.IRtcEngineEventHandler
import io.agora.rtc.PublisherConfiguration
import io.agora.rtc.RtcEngine

import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.PluginRegistry


object AgoraModule {

    private var registrar: PluginRegistry.Registrar? = null
    private var channel: MethodChannel? = null

    val name: String
        @Override
        get() = "RCTAgora"

    fun setMethodChannel(channel: MethodChannel) {
        AgoraModule.channel = channel
    }

    fun setRegistrar(registrar: PluginRegistry.Registrar) {
        AgoraModule.registrar = registrar
    }

    private val mRtcEventHandler = object : IRtcEngineEventHandler() {

        /**
         * 加入频道成功的回调
         */
        override fun onJoinChannelSuccess(channel: String, uid: Int, elapsed: Int) {

            Log.d("Agora", "加入房间成功---" + uid)

            val result = mapOf(
                    "channel" to channel,
                    "uid" to uid
            )
            AgoraModule.channel?.invokeMethod(Constant.ON_JOIN_CHANNEL_SUCCESS, result)
        }

        /**
         * 其他用户加入当前频道
         */
        override fun onUserJoined(uid: Int, elapsed: Int) {

            Log.i("Agora", "有人来了----")

            val result = mapOf(
                    "uid" to uid
            )

            AgoraModule.channel?.invokeMethod(Constant.ON_USER_JOINED, result)

        }

        /**
         * 用户uid离线时的回调
         */
        override fun onUserOffline(uid: Int, reason: Int) {
            val result = mapOf(
                    "uid" to uid,
                    "reason" to reason
            )
            AgoraModule.channel?.invokeMethod(Constant.ON_USER_OFFLINE, result)
        }

        /**
         * 说话声音音量提示回调
         */
        override fun onAudioVolumeIndication(speakers: Array<AudioVolumeInfo>,
                                             totalVolume: Int) {

            val arr = ArrayList<Map<String, Int>>();
            for (i in speakers.indices) {
                Log.d("Agora", "声音---" + speakers[i].uid)
                val obj = mapOf(
                        "uid" to speakers[i].uid,
                        "volume" to speakers[i].volume
                )
                arr.add(obj)
            }
            val result = mapOf(
                    "speakers" to arr,
                    "totalVolume" to totalVolume
            )
            AgoraModule.channel?.invokeMethod(Constant.ON_AUDIO_VOLUME_INDICATION, result)
        }

        override fun onAudioQuality(uid: Int, quality: Int, delay: Short, lost: Short) {
            val result = mapOf(
                    "uid" to uid,
                    "quality" to quality,
                    "delay" to delay,
                    "lost" to lost
            )
            AgoraModule.channel?.invokeMethod(Constant.ON_AUDIO_QUALITY, result)
        }

        /**
         * 错误信息
         */
        override fun onError(err: Int) {
            Log.i("Agora", err.toString() + "错误---")
            AgoraModule.channel?.invokeMethod(Constant.ON_ERROR, mapOf(
                    "err" to err
            ))
        }

        /**
         * 警告
         */
        override fun onWarning(warn: Int) {
            Log.i("Agora", warn.toString() + "警告---")
            AgoraModule.channel?.invokeMethod(Constant.ON_WARNING, mapOf(
                    "warn" to warn
            ))
        }

        /**
         * 退出频道
         */
        override fun onLeaveChannel(stats: RtcStats) {
            AgoraModule.channel?.invokeMethod(Constant.ON_LEAVE_CHANNEL, {})
        }

        /**
         * 用户mute音频回调
         */
        override fun onUserMuteAudio(uid: Int, muted: Boolean) {
            AgoraModule.channel?.invokeMethod(Constant.ON_USER_MUTEAUDIO, mapOf(
                    "uid" to uid,
                    "muted" to muted
            ))
        }

        override fun onConnectionLost() {
            AgoraModule.channel?.invokeMethod(Constant.ON_CONNECTION_LOST, {})
        }

        override fun onNetworkQuality(uid: Int, txQuality: Int, rxQuality: Int) {
            val result = mapOf(
                    "uid" to uid,
                    "txQuality" to txQuality,
                    "rxQuality" to rxQuality
            )
            AgoraModule.channel?.invokeMethod(Constant.ON_NETWORK_QUALITY, result)
        }

        override fun onLastmileQuality(quality: Int) {
            AgoraModule.channel?.invokeMethod(Constant.ON_LASTMILE_QUALITY, mapOf(
                    "quality" to quality
            ))
        }
    }

    fun createAgoraEngine(call: MethodCall) {
        Log.i("appid", call.argument("appid"))
        val options: Map<String, Any?> = mapOf(
                "appid" to call.argument("appid"),
                "channelProfile" to call.argument("channelProfile")
        )
        AgoraManager.instance.createAgoraEngine(registrar!!.context().applicationContext, mRtcEventHandler, options)
    }

    fun enableLastmileTest() {
        AgoraManager.instance.enableLastmileTest()
    }

    fun disableLastmileTest() {
        AgoraManager.instance.disableLastmileTest()
    }

    //进入房间
    fun joinChannel(call: MethodCall) {
        print(call.argument<String>("channelName"))
        AgoraManager.instance.joinChannel(
                call.argument<String>("channelName")!!,
                call.argument<Int>("uid")!!
        )
    }

    fun joinChannelWithToken(call: MethodCall) {
        AgoraManager.instance.joinChannelWithToken(
                call.argument<String>("token") as String,
                call.argument<String>("channelName") as String,
                call.argument<Int>("uid") as Int
        )
    }

    // 设置用户角色
    fun setClientRole(call: MethodCall) {
        AgoraManager.instance.mRtcEngine!!.setClientRole(call.argument<Int>("role") as Int)
    }

    //退出
    fun leaveChannel() {
        AgoraManager.instance.leaveChannel()
    }

    //启用说话者音量提示
    fun enableAudioVolumeIndication(call: MethodCall) {
        AgoraManager.instance.mRtcEngine!!.enableAudioVolumeIndication(
                call.argument<Int>("interval") as Int,
                call.argument<Int>("smooth") as Int
        )
    }

    //打开音频
    fun enableAudio() {
        AgoraManager.instance.mRtcEngine!!.enableAudio()
    }

    //关闭音频
    fun disableAudio() {
        AgoraManager.instance.mRtcEngine!!.disableAudio()
    }

    //打开扬声器
    fun setEnableSpeakerphone(call: MethodCall) {
        AgoraManager.instance.mRtcEngine!!.setEnableSpeakerphone(call.argument<Boolean>("enabled") as Boolean)
    }

    //将自己静音
    fun muteLocalAudioStream(call: MethodCall) {
        AgoraManager.instance.mRtcEngine!!.muteLocalAudioStream(call.argument<Boolean>("muted") as Boolean)
    }

    //静音所有远端音频
    fun muteAllRemoteAudioStreams(call: MethodCall) {
        AgoraManager.instance.mRtcEngine!!.muteAllRemoteAudioStreams(call.argument<Boolean>("muted") as Boolean)
    }

    //静音指定用户音频
    fun muteRemoteAudioStream(call: MethodCall) {
        AgoraManager.instance.mRtcEngine?.muteRemoteAudioStream(
                call.argument<Int>("uid") as Int,
                call.argument<Boolean>("muted") as Boolean
        )
    }

    //修改默认的语音路由 True: 默认路由改为外放(扬声器) False: 默认路由改为听筒
    fun setDefaultAudioRouteToSpeakerphone(call: MethodCall) {
        AgoraManager.instance.mRtcEngine?.setDefaultAudioRoutetoSpeakerphone(call.argument<Boolean>("defaultToSpeaker") as Boolean)
    }

    // 建立数据通道
    fun createDataStream(call: MethodCall, result: MethodChannel.Result) {
        result.success(AgoraManager.instance.mRtcEngine?.createDataStream(
                call.argument<Boolean>("reliable") as Boolean,
                call.argument<Boolean>("ordered") as Boolean
        ))
    }

    // 发送数据
    fun sendStreamMessage(call: MethodCall, result: MethodChannel.Result) {
        result.success(AgoraManager.instance.mRtcEngine?.sendStreamMessage(
                call.argument<Int>("streamId") as Int,
                call.argument<String>("message")!!.toByteArray()
        ))
    }

    //销毁引擎实例
    fun destroy() {
        RtcEngine.destroy()
    }

    //播放音乐
    fun startAudioMixing(call: MethodCall, result: MethodChannel.Result) {
        val r: Int = AgoraManager.instance.startAudioMixing(call.argument<String>("path") as String,
                call.argument<Int>("loopCount") as Int,
                call.argument<Boolean>("replaceMic") as Boolean,
                call.argument<Boolean>("shouldLoop") as Boolean)
        result.success(r);
    }

    /**
     * volume 0 - 100
     */
    fun adjustAudioMixingVolume(call: MethodCall, result: MethodChannel.Result) {
        val r: Int = AgoraManager.instance.mRtcEngine!!.adjustAudioMixingVolume(call.argument<Int>("volume") as Int)
        result.success(r)
    }

    // 获取当前播放的混音音乐的时长
    fun getAudioMixingDuration(result: MethodChannel.Result) {
        val r: Int = AgoraManager.instance.mRtcEngine!!.getAudioMixingDuration()
        result.success(r)
    }

    // 获取当前混音的播放进度
    fun getAudioMixingCurrentPosition(result: MethodChannel.Result) {
        val r: Int = AgoraManager.instance.mRtcEngine!!.getAudioMixingCurrentPosition()
        result.success(r)
    }

    fun pauseAudioMixing(result: MethodChannel.Result) {
        val r: Int = AgoraManager.instance.mRtcEngine!!.pauseAudioMixing()
        result.success(r)
    }

    fun resumeAudioMixing(result: MethodChannel.Result) {
        val r: Int = AgoraManager.instance.mRtcEngine!!.resumeAudioMixing()
        result.success(r)
    }

    fun stopAudioMixing(result: MethodChannel.Result) {
        val r: Int = AgoraManager.instance.mRtcEngine!!.stopAudioMixing()
        result.success(r)
    }


    //查询 SDK 版本号
    fun getSdkVersion(result: MethodChannel.Result) {
        result.success(RtcEngine.getSdkVersion())
    }


}