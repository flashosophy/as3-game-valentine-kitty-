package com.vitapoly.features.multiplayer.events
{
	import flash.events.Event;

	
	public class UsersEvent extends Event
	{
		public static const TYPE:String = "USERS";
		
		public var users:Array;
		
		public function UsersEvent(users:Array, type:String=TYPE, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			this.users = users;
		}
	}
}