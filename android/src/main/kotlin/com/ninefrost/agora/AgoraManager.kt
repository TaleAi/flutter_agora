package com.ninefrost.agora

import android.content.Context
import android.util.Log

import io.agora.rtc.IRtcEngineEventHandler
import io.agora.rtc.RtcEngine
//import io.agora.rtc.Constants

class AgoraManager private constructor() {

    var mRtcEngine: RtcEngine? = null

    private var context: Context? = null

    /**
     * 初始化RtcEngine
     */
    fun createAgoraEngine(
            context: Context,
            mRtcEventHandler: IRtcEngineEventHandler,
            options: Map<String, Any?>
    ) {
        this.context = context
        //创建RtcEngine对象，mRtcEventHandler为RtcEngine的回调
        try {
            mRtcEngine = RtcEngine.create(context, options.getValue("appid") as String?, mRtcEventHandler)
        } catch (e: Exception) {
            throw RuntimeException("NEED TO check rtc sdk init fatal error\n" + Log.getStackTraceString(e))
        }

//        //开启视频功能
//        mRtcEngine!!.enableVideo()
//        mRtcEngine!!.setVideoProfile(options.getInt("videoProfile"), options.getBoolean("swapWidthAndHeight")) //视频配置，
//        mRtcEngine!!.enableWebSdkInteroperability(true)  //设置和web通信
          mRtcEngine!!.setChannelProfile(options.getValue("channelProfile") as Int) //设置模式
//        mRtcEngine!!.setClientRole(options.getInt("clientRole"), null) //设置角色
    }

    /**
     * 加入通信频道，不需要验证
     * 如果已在频道中，用户必须调用 leaveChannel 方法退出当前频道，才能进入下一个频道。
     */
    fun joinChannel(channel: String, uid: Int): AgoraManager {
        mRtcEngine!!.joinChannel(null, channel, null, uid)
        return this
    }

    /**
     * 加入频道，需要验证
     */
    fun joinChannelWithToken(token: String, channel: String, uid: Int): AgoraManager {
        mRtcEngine!!.joinChannel(token, channel, null, uid)
        return this
    }

    fun enableLastmileTest(): AgoraManager {
        mRtcEngine!!.enableLastmileTest()
        return this
    }

    fun disableLastmileTest(): AgoraManager {
        mRtcEngine!!.disableLastmileTest()
        return this
    }

    fun leaveChannel() {
        mRtcEngine!!.leaveChannel()
    }

    /**
     * 播放混音
     */
    fun startAudioMixing(path: String, loopCount: Int, replaceMic: Boolean, shouldLoop: Boolean): Int {
        return mRtcEngine!!.startAudioMixing(path, shouldLoop, replaceMic, loopCount)
    }

    companion object {

        var sAgoraManager: AgoraManager? = null

        val instance: AgoraManager
            get() {
                if (sAgoraManager == null) {
                    synchronized(AgoraManager::class.java) {
                        if (sAgoraManager == null) {
                            sAgoraManager = AgoraManager()
                        }
                    }
                }
                return sAgoraManager!!
            }
    }


}