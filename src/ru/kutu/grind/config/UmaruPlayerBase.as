package ru.kutu.grind.config {

	import flash.events.TimerEvent;
	import flash.events.IEventDispatcher;
	import flash.net.SharedObject;
	import flash.utils.Timer;

	import flash.external.ExternalInterface;

	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLRequestHeader;
	import flash.net.URLLoader;

	import flash.events.Event;
	import flash.events.ErrorEvent;

	import org.osmf.media.MediaPlayer;

	import ru.kutu.grind.events.LoadMediaEvent;
	import ru.kutu.grind.events.LoadVideoInfoEvent;

	import robotlegs.bender.framework.api.ILogger;

	public class UmaruPlayerBase {

		[Inject] public var logger:ILogger;
		[Inject] public var player:MediaPlayer;

		[Inject] public var eventDispatcher:IEventDispatcher;

		[Inject] public var playerConfiguration:PlayerConfiguration;


		private var apiBase:String = 'http://uapi.guancloud.com/1.0/';

		public function UmaruPlayerBase() {

		}

		public function configure():void{
			ExternalInterface.call("console.log", playerConfiguration);

			loadVideoInfo(playerConfiguration.vid);
		}

		public function loadVideoInfo(id:String):void{
			ExternalInterface.call("console.log", id);

			var request:URLRequest = new URLRequest();
			request.url = apiBase + 'video/' + id + '/?format=json';
			request.method = URLRequestMethod.GET;

			var loader:URLLoader = new URLLoader();

			loader.addEventListener(Event.COMPLETE, onVideoInfoLoaded);
			loader.addEventListener(ErrorEvent.ERROR, onError);
			loader.load(request);
		}

		public function onVideoInfoLoaded(event:Event):void
		{
			var videoInfo:Object = JSON.parse(event.target.data);
			ExternalInterface.call("console.log", 'Video info loaded');

			eventDispatcher.dispatchEvent(new LoadVideoInfoEvent(LoadVideoInfoEvent.LOAD, videoInfo));
		}

		public function onError(event:Event):void
		{
			ExternalInterface.call("console.log", event);
		}

	}

}
