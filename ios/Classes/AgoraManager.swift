import Flutter
import AgoraAudioKit

public class AgoraManager: NSObject,AgoraRtcEngineDelegate {
    var agoraKit: AgoraRtcEngineKit!
    private var channel: FlutterMethodChannel!
    
    static var getInstance : AgoraManager {
        struct Static {
            static let instance : AgoraManager = AgoraManager()
        }
        return Static.instance
    }
    
    func setMethodChannel(channel: FlutterMethodChannel) {
        self.channel = channel
    }
    
    func initializeAgoraEngine(appid: String, type: Int) -> Int {
        agoraKit = AgoraRtcEngineKit.sharedEngine(withAppId: appid, delegate: self)
        self.setChannelProfile(type: type)
        if(agoraKit != nil) {
            return 0
        } else {
            return -1;
        }
    }
    
    func setChannelProfile(type: Int) {
        agoraKit.setChannelProfile(AgoraChannelProfile(rawValue: type) ?? AgoraChannelProfile.liveBroadcasting)
    }
    
    func joinChannel(channelId: String, uid: UInt) -> Int32 {
        return agoraKit.joinChannel(byToken: nil, channelId: channelId, info: "", uid: uid, joinSuccess: nil)
    }
    
    func joinChannelWithToken(token:String, channelId: String, uid: UInt) -> Int32 {
        return agoraKit.joinChannel(byToken: token, channelId: channelId, info: "", uid: uid , joinSuccess: nil)
    }
    
    public func enableLastmileTest() -> Int32 {
        return agoraKit.enableLastmileTest()
    }
    
    public func disableLastmileTest() -> Int32 {
        return agoraKit.disableLastmileTest()
    }
    
    func leaveChannel() -> Int32 {
        return agoraKit.leaveChannel()
    }
    
    public func setClientRole(role: Int) -> Int32{
        return agoraKit.setClientRole(AgoraClientRole(rawValue: role) ?? AgoraClientRole.audience)
    }
    
    public func enableAudioVolumeIndication(interval: Int, smooth: Int) -> Int32 {
        return agoraKit.enableAudioVolumeIndication(interval, smooth: smooth)
    }
    
    public func enableAudio() -> Int32{
        return agoraKit.enableAudio()
    }
    
    public func disableAudio() -> Int32{
        return agoraKit.disableAudio()
    }
    
    public func setEnableSpeakerphone(enabled: Bool) -> Int32{
        return agoraKit.setEnableSpeakerphone(enabled)
    }
    
    public func muteLocalAudioStream(muted: Bool) -> Int32{
        return agoraKit.muteLocalAudioStream(muted)
    }
    
    public func muteAllRemoteAudioStreams(muted: Bool) -> Int32 {
        return agoraKit.muteAllRemoteAudioStreams(muted)
    }
    
    public func muteRemoteAudioStream(uid: UInt, muted: Bool) -> Int32 {
        return agoraKit.muteRemoteAudioStream(uid, mute: muted)
    }
    
    public func setDefaultAudioRouteToSpeakerphone(defaultToSpeaker: Bool) -> Int32{
        return agoraKit.setDefaultAudioRouteToSpeakerphone(defaultToSpeaker)
    }
    
    public func createDataStream() {
    }
    
    public func sendStreamMessage() {
    }
    
    public func startAudioMixing(path:String, loopCount: Int, replaceMic: Bool, shouldLoop: Bool) -> Int32 {
       return agoraKit.startAudioMixing(path, loopback: shouldLoop, replace: replaceMic, cycle: loopCount)
    }
    
    public func adjustAudioMixingVolume(volume: Int) -> Int32{
        return agoraKit.adjustAudioMixingVolume(volume)
    }
    
    public func getAudioMixingDuration() -> Int32 {
        return agoraKit.getAudioMixingDuration()
    }
    
    public func stopAudioMixing() -> Int32{
        return agoraKit.stopAudioMixing()
    }
    
    public func getAudioMixingCurrentPosition() -> Int32{
        return agoraKit.getAudioMixingCurrentPosition()
    }
    
    public func pauseAudioMixing() -> Int32{
        return agoraKit.pauseAudioMixing()
    }
    
    public func resumeAudioMixing() -> Int32 {
        return agoraKit.resumeAudioMixing()
    }
    
    public func rtcEngine(_ engine: AgoraRtcEngineKit, didRejoinChannel channel: String, withUid uid: UInt, elapsed: Int) {
        self.agoraKit.setEnableSpeakerphone(true)
        self.channel.invokeMethod(ON_JOIN_CHANNEL_SUCCESS, arguments: ["channel": channel, "uid": uid])
    }
    
    public func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinChannel channel: String, withUid uid: UInt, elapsed: Int) {
        self.agoraKit.setEnableSpeakerphone(true)
        self.channel.invokeMethod(ON_JOIN_CHANNEL_SUCCESS, arguments: ["channel": channel, "uid": uid])
    }
    
    public func rtcEngine(_ engine: AgoraRtcEngineKit, didLeaveChannelWith stats: AgoraChannelStats) {
        self.channel.invokeMethod(ON_LEAVE_CHANNEL, arguments: [])
    }
    
    public func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinedOfUid uid: UInt, elapsed: Int) {
        self.channel.invokeMethod(ON_USER_JOINED, arguments: ["uid": uid])
    }
    
    public func rtcEngine(_ engine: AgoraRtcEngineKit, didOfflineOfUid uid: UInt, reason: AgoraUserOfflineReason) {
        self.channel.invokeMethod(ON_USER_OFFLINE, arguments: ["uid": uid, "reason": reason.rawValue])
    }
    
    public func rtcEngine(_ engine: AgoraRtcEngineKit, reportAudioVolumeIndicationOfSpeakers speakers: [AgoraRtcAudioVolumeInfo], totalVolume: Int) {
        var arr = [NSDictionary]()
        for speaker in speakers {
            arr.append(["uid": speaker.uid, "volume": speaker.volume])
        }
        self.channel.invokeMethod(ON_AUDIO_VOLUME_INDICATION, arguments: ["speakers": arr, "totalVolume":totalVolume])
    }
    
    public func rtcEngine(_ engine: AgoraRtcEngineKit, didOccurError errorCode: AgoraErrorCode) {
        print(errorCode)
        channel.invokeMethod(ON_ERROR, arguments: ["err": errorCode.rawValue])
    }
    
    public func rtcEngine(_ engine: AgoraRtcEngineKit, didOccurWarning warningCode: AgoraWarningCode) {
        channel.invokeMethod(ON_WARNING, arguments: ["warn": warningCode.rawValue])
    }
    
    public func rtcEngine(_ engine: AgoraRtcEngineKit, didAudioMuted muted: Bool, byUid uid: UInt) {
        channel.invokeMethod(ON_USER_MUTE_AUDIO, arguments: ["uid":uid, "muted":muted])
    }
    
    public func rtcEngineConnectionDidLost(_ engine: AgoraRtcEngineKit) {
        channel.invokeMethod(ON_CONNECTION_LOST, arguments: [])
    }
    
    public func rtcEngine(_ engine: AgoraRtcEngineKit, lastmileQuality quality: AgoraNetworkQuality) {
        channel.invokeMethod(ON_LASTMILE_QUALITY, arguments: ["quality": quality.rawValue])
    }
    
    public func rtcEngine(_ engine: AgoraRtcEngineKit, networkQuality uid: UInt, txQuality: AgoraNetworkQuality, rxQuality: AgoraNetworkQuality) {
        channel.invokeMethod(ON_NETWORK_QUALITY, arguments: ["txQuality": txQuality.rawValue, "rxQuality": rxQuality.rawValue, "uid": uid])
    }
}
