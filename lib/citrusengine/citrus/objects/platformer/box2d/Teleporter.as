package citrus.objects.platformer.box2d {

	import Box2D.Dynamics.Contacts.b2Contact;

	import citrus.objects.Box2DPhysicsObject;

	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
 
	/**
	 * A Teleporter, moves an object to a destination. The waiting time is more or less long.
	 * It is a Sensor which can be activate after a contact.
	 * <ul>Properties:
	 * <li>endX : the object's x destination after teleportation.</li>
	 * <li>endY : the object's y destination after teleportation.</li>
	 * <li>object : the PhysicsObject teleported.</li>
	 * <li>waitingTime : how many time before teleportation, master ?</li>
	 * <li>teleport : set it to true to teleport your object.</li></ul>
	 */
	public class Teleporter extends Sensor {
 		
		/**
		 * the object's x destination after teleportation.
		 */
		[Inspectable(defaultValue="0")]
		public var endX:Number = 0;
		
		/**
		 * the object's y destination after teleportation.
		 */
		[Inspectable(defaultValue="0")]
		public var endY:Number = 0;
		
		/**
		 * the PhysicsObject teleported.
		 */
		[Inspectable(defaultValue="",type="String")]
		public var object:Box2DPhysicsObject;
 		
		/**
		 * how many time before teleportation, master ?
		 */
 		[Inspectable(defaultValue="0")]
		public var waitingTime:Number = 0;
		
		/**
		 * set it to true to teleport your object.
		 */
		public var teleport:Boolean = false;
 
		protected var _teleporting:Boolean = false;
 
		protected var _teleportTimeoutID:uint;
 
		public function Teleporter(name:String, params:Object = null) {
			super(name, params);
		}
 
		override public function destroy():void {
 
			clearTimeout(_teleportTimeoutID);
 
			super.destroy();
		}
 
		override public function update(timeDelta:Number):void {
 
			super.update(timeDelta);
 
			if (teleport) {
 
				_teleporting = true;
 
				_teleportTimeoutID = setTimeout(_teleport, waitingTime);
 
				teleport = false;
			}
 
			_updateAnimation();
		}
			
		override public function handleBeginContact(contact:b2Contact):void {
			
			onBeginContact.dispatch(contact);
			
			teleport = true;
		}
 
		protected function _teleport():void {
 
			_teleporting = false;
 
			object.x = endX;
			object.y = endY;
 
			clearTimeout(_teleportTimeoutID);
		}
 
		protected function _updateAnimation():void {
 			
			_animation = _teleporting ? "teleport" : "normal";
		}
	}
}