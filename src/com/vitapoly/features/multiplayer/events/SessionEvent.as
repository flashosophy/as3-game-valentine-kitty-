package com.vitapoly.features.multiplayer.events
{
	import flash.events.Event;

	
	public class SessionEvent extends Event
	{
		public static const JOIN_EVENT:String = "JOIN";
		public static const LEAVE_EVENT:String = "LEAVE";
		public static const ROOM_FILLED:String = "ROOM_FILLED";
		
		public var socketID:int;
		
		public function SessionEvent(socketID:int, type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			this.socketID = socketID;
			trace("join event created: " + socketID);
		}
	}
}