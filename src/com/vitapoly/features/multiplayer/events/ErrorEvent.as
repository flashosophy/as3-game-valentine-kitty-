package com.vitapoly.features.multiplayer.events
{
	import flash.events.Event;

	
	public class ErrorEvent extends Event
	{
		public static const TYPE:String = "ERROREVENT";
		
		public var errorMessage:String;
		
		public function ErrorEvent(errorMessage:String, type:String=TYPE, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			this.errorMessage = errorMessage;
		}
	}
}