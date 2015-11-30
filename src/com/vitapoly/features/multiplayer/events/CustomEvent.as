package com.vitapoly.features.multiplayer.events
{
	import flash.events.Event;
	import flash.utils.ByteArray;

	
	public class CustomEvent extends Event
	{
		public static const TYPE:String = "CustomEvent"
		
		public var socketID:int;
		public var data:ByteArray;
		public var eventID:int;	// also known as command
		
		public function CustomEvent(eventID:int, socketID:int, data:ByteArray, type:String=TYPE, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			this.socketID = socketID;
			this.eventID = eventID;
			this.data = data;
		}
	}
}