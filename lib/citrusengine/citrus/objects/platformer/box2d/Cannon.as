package citrus.objects.platformer.box2d {

	import citrus.objects.Box2DPhysicsObject;

	import org.osflash.signals.Signal;

	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * A cannon is an object which fires missiles. A cannon is a static body so it extends Platform.
	 * <ul>Properties:
	 * <li>fireRate : The frequency that missiles are fired.</li>
	 * <li>startingDirection : The direction that missiles are fired.</li>
	 * <li>openFire : Indicate if the cannon shoot at start or not.</li></ul>
	 * 
	 * <ul>Events:
	 * <li>onGiveDamage - Dispatched when the missile explodes on a Box2DPhysicsObject. Passes one parameter:
	 * 				  The Object it exploded on (Box2DPhysicsObject)</li></ul>
	 */
	public class Cannon extends Platform {
		
		/**
		 * The frequency that missiles are fired.
		 */
		[Inspectable(defaultValue="2000")]
		public var fireRate:Number = 2000;
		
		/**
		 * The direction that missiles are fired
		 */
		[Inspectable(defaultValue="right",enumeration="right,left")]
		public var startingDirection:String = "right";
		
		/**
		 * Indicate if the cannon shoot at start or not.
		 */
		[Inspectable(defaultValue="true")]
		public var openFire:Boolean = true;

		[Inspectable(defaultValue="20")]
		public var missileWidth:uint = 20;

		[Inspectable(defaultValue="20")]
		public var missileHeight:uint = 20;

		[Inspectable(defaultValue="2")]
		public var missileSpeed:Number = 2;

		[Inspectable(defaultValue="0")]
		public var missileAngle:Number = 0;

		[Inspectable(defaultValue="1000")]
		public var missileExplodeDuration:Number = 1000;

		[Inspectable(defaultValue="10000")]
		public var missileFuseDuration:Number = 10000;

		[Inspectable(defaultValue="",format="File",type="String")]
		public var missileView:* = MovieClip;

		/**
		 * Dispatched when the missile explodes on a Box2DPhysicsObject. Passes one parameter:
		 * 				  The Object it exploded on (Box2DPhysicsObject)
		 */
		public var onGiveDamage:Signal;

		protected var _firing:Boolean = false;

		protected var _timer:Timer;

		public function Cannon(name:String, params:Object = null) {
			
			super(name, params);

			onGiveDamage = new Signal(Box2DPhysicsObject);
		}
			
		override public function initialize(poolObjectParams:Object = null):void {
			
			super.initialize(poolObjectParams);
			
			if (openFire)
				startFire();
		}

		override public function destroy():void {

			onGiveDamage.removeAll();

			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER, _fire);

			super.destroy();
		}

		override public function update(timeDelta:Number):void {

			super.update(timeDelta);

			_updateAnimation();
		}
		
		/**
		 * Dispatch onGiveDamage's Signal if a missile fired by the cannon explodes.
		 */
		protected function _damage(missile:Missile, contact:Box2DPhysicsObject):void {

			if (contact != null)
				onGiveDamage.dispatch(contact);
		}
		
		/**
		 * Cannon starts to fire. The timer is also started with the <code>fireRate</code>'s frequency.
		 */
		public function startFire():void {

			_firing = true;

			_timer = new Timer(fireRate);
			_timer.addEventListener(TimerEvent.TIMER, _fire);
			_timer.start();
		}

		/**
		 * Cannon stops to fire, timer is stopped.
		 */
		public function stopFire():void {

			_firing = false;

			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER, _fire);
		}
		
		/**
		 * Cannon fires a missile. This missile called the <code>_damage</code> function on missile's explosion.
		 */
		protected function _fire(tEvt:TimerEvent):void {

			var missile:Missile;

			if (startingDirection == "right")
				missile = new Missile("Missile", {x:x + width, y:y, width:missileWidth, height:missileHeight, speed:missileSpeed, angle:missileAngle, explodeDuration:missileExplodeDuration, fuseDuration:missileFuseDuration, view:missileView});
			else
				missile = new Missile("Missile", {x:x - width, y:y, width:missileWidth, height:missileHeight, speed:-missileSpeed, angle:missileAngle, explodeDuration:missileExplodeDuration, fuseDuration:missileFuseDuration, view:missileView});

			_ce.state.add(missile);
			missile.onExplode.addOnce(_damage);
		}

		protected function _updateAnimation():void {
			
			_animation = _firing ? "fire" : "normal";
		}
	}
}