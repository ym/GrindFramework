package ru.kutu.grind.events {

	import flash.events.Event;
	import flash.geom.Point;

	public class LoadVideoInfoEvent extends Event {

		public static const LOAD:String = "umaru.LoadVideoInfoEvent";

		private var _info:Object;

		public function LoadVideoInfoEvent(type:String, info:Object, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);

			_info = info;
		}

		public function get info():Object { return _info }

		override public function clone():Event {
			return new LoadVideoInfoEvent(type, _info, bubbles, cancelable);
		}

		override public function toString():String {
			return formatToString("LoadVideoInfoEvent", "type", "info", "bubbles", "cancelable", "eventPhase");
		}

	}

}
