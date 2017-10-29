package
{
import flash.display.Sprite;
import flash.events.NetStatusEvent;
import flash.net.NetConnection;
import flash.net.NetStream;
import flash.media.Camera;
import flash.media.Microphone;
import flash.media.Video;
public class video1 extends Sprite
{
private var nc:NetConnection;
private var good:Boolean;
private var rtmpNow:String;
private var nsIn:NetStream;
private var nsOut:NetStream;
private var cam:Camera;
private var mic:Microphone;
private var vidLocal:Video;
private var vidStream:Video;
public function video1 ()
{
rtmpNow="rtmp://localhost/videoo";
nc=new NetConnection();
nc.connect (rtmpNow);

trace("11111222");
nc.addEventListener (NetStatusEvent.NET_STATUS,checkCon);
setCam();
setMic();
//The World’s Easiest Two-Way A/V Chat Application | 95
setVideo();
}
private function checkCon(e:NetStatusEvent):void {
	trace("11111 5"+e.info.code);
good=e.info.code == "NetConnection.Connect.Success";
if (good)
{
nsOut=new NetStream(nc);
nsOut.attachAudio (mic);
nsOut.attachCamera (cam);
nsOut.publish("left","live");
nsIn=new NetStream(nc);
nsIn.play("right");
vidStream.attachNetStream(nsIn);
}
}
private function setCam()
{
cam=Camera.getCamera();
cam.setKeyFrameInterval (9);
cam.setMode (240,180,15);
cam.setQuality (0,80);
}
private function setMic()
{
mic=Microphone.getMicrophone();
mic.gain=85;
mic.rate=11;
mic.setSilenceLevel(15,2000);
}
private function setVideo()
{
vidLocal=new Video(cam.width,cam.height);
addChild(vidLocal);
vidLocal.x=15; 
vidLocal.y=30;
vidLocal.attachCamera(cam);
vidStream=new Video(cam.width,cam.height);
addChild(vidStream);
vidStream.x=(vidLocal.x+ cam.width +10); 
vidStream.y=vidLocal.y;
}
}
}