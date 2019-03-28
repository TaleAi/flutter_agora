import AgoraAudioKit
import Flutter

public class AgoraModule: NSObject {
    
    public static func initializeAgoraEngine(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let params = call.arguments as! NSDictionary;
        result(AgoraManager.getInstance.initializeAgoraEngine(appid: params.value(forKey: "appid") as! String,type: params.value(forKey: "channelProfile") as! Int))
    }
    
    public static func joinChannel(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let params = call.arguments as! NSDictionary;
        result(AgoraManager.getInstance.joinChannel(channelId: params.value(forKey: "channelName") as! String, uid:  params.value(forKey: "uid") as! UInt))
    }
    
    public static func joinChannelWithToken(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let params = call.arguments as! NSDictionary;
        result(AgoraManager.getInstance.joinChannelWithToken(token: params.value(forKey: "channelName") as! String,channelId: params.value(forKey: "token") as! String, uid:  params.value(forKey: "uid") as! UInt))
    }
    
    public static func enableLastmileTest(result: @escaping FlutterResult) {
        result(AgoraManager.getInstance.enableLastmileTest())
    }
    
    public static func disableLastmileTest(result: @escaping FlutterResult) {
        result(AgoraManager.getInstance.disableLastmileTest())
    }
    
    public static func leaveChannel(result: @escaping FlutterResult) {
        result(AgoraManager.getInstance.leaveChannel())
    }
    
    public static func setClientRole(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let params = call.arguments as! NSDictionary;
        result(AgoraManager.getInstance.setClientRole(role: params.value(forKey: "role") as! Int))
    }
    
    public static func enableAudioVolumeIndication(_ call: FlutterMethodCall, result: @escaping FlutterResult){
        let params = call.arguments as! NSDictionary;
        result(AgoraManager.getInstance.enableAudioVolumeIndication(interval: params.value(forKey: "interval") as! Int, smooth: params.value(forKey: "smooth") as! Int))
    }
    
    public static func enableAudio(result: @escaping FlutterResult) {
        result(AgoraManager.getInstance.enableAudio())
    }
    
    public static func disableAudio(result: @escaping FlutterResult) {
        result(AgoraManager.getInstance.disableAudio())
    }
    
    public static func setEnableSpeakerphone(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let params = call.arguments as! NSDictionary;
        result(AgoraManager.getInstance.setEnableSpeakerphone(enabled: params.value(forKey: "enabled") as! Bool))
    }
    
    public static func muteLocalAudioStream(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let params = call.arguments as! NSDictionary;
        result(AgoraManager.getInstance.muteLocalAudioStream(muted: params.value(forKey: "muted") as! Bool))
    }
    
    public static func muteAllRemoteAudioStreams(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let params = call.arguments as! NSDictionary;
        result(AgoraManager.getInstance.muteAllRemoteAudioStreams(muted: params.value(forKey: "muted") as! Bool))
    }
    
    public static func muteRemoteAudioStream(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let params = call.arguments as! NSDictionary;
        result(AgoraManager.getInstance.muteRemoteAudioStream(uid: params.value(forKey: "uid") as! UInt, muted: params.value(forKey: "muted") as! Bool))
    }
    
    public static func setDefaultAudioRouteToSpeakerphone(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let params = call.arguments as! NSDictionary
        result(AgoraManager.getInstance.setDefaultAudioRouteToSpeakerphone(defaultToSpeaker: params.value(forKey: "defaultToSpeaker") as! Bool))
    }
    
    public static func createDataStream(result: @escaping FlutterResult) {
        result(AgoraManager.getInstance.createDataStream())
    }
    
    public static func sendStreamMessage(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        result(AgoraManager.getInstance.sendStreamMessage())
    }
    
    public static func startAudioMixing(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let params = call.arguments as! NSDictionary
        result(AgoraManager.getInstance.startAudioMixing(path: params.value(forKey: "path") as! String, loopCount: params.value(forKey: "loopCount") as! Int, replaceMic: params.value(forKey: "replaceMic") as! Bool, shouldLoop: params.value(forKey: "shouldLoop") as! Bool))
    }
    
    public static func adjustAudioMixingVolume(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let params = call.arguments as! NSDictionary
        result(AgoraManager.getInstance.adjustAudioMixingVolume(volume: params.value(forKey: "volume") as! Int))
    }
    
    public static func getAudioMixingDuration(result: @escaping FlutterResult) {
        result(AgoraManager.getInstance.getAudioMixingDuration())
    }
    
    public static func stopAudioMixing(result: @escaping FlutterResult) {
        result(AgoraManager.getInstance.stopAudioMixing())
    }
    
    public static func getAudioMixingCurrentPosition(result: @escaping FlutterResult) {
        result(AgoraManager.getInstance.getAudioMixingCurrentPosition())
    }
    
    public static func pauseAudioMixing(result: @escaping FlutterResult) {
        result(AgoraManager.getInstance.pauseAudioMixing())
    }
    
    public static func resumeAudioMixing(result: @escaping FlutterResult) {
        result(AgoraManager.getInstance.resumeAudioMixing())
    }
    
    public static func getSdkVersion(result: @escaping FlutterResult) {
        result(AgoraRtcEngineKit.getSdkVersion())
    }
    
    public static func destroy(result: @escaping FlutterResult){
        AgoraRtcEngineKit.destroy()
        result(true)
    }
}
