package com.vitapoly.valentinekitty.view
{	
	
	import com.vitapoly.valentinekitty.Game;
	import com.vitapoly.valentinekitty.model.PhysicsEditorObjects;
	
	import citrus.objects.NapePhysicsObject;
	import citrus.physics.nape.NapeUtils;
	
	import nape.callbacks.InteractionCallback;
	
	public class CoinBling extends PhysicsEditorObjects//NapePhysicsObject
	{
		public var owner:NapePhysicsObject;
		private var alreadyHitGround:Boolean;
		
		public function CoinBling(name:String, owner:NapePhysicsObject, params:Object=null)
		{
			params.peObject = name;		
			super(name, params);
			this.owner = owner;
			this.body.mass = this._getDensity();
			
		}
		
		override public function initialize(poolObjectParams:Object=null):void
		{
			super.initialize(poolObjectParams);
		}
		
		private var _elapsedTime:Number = 0;
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
			if(this.y >= 1200)
			{
				Game.getInstance().remove(this);
				this.destroy();
			}
		}
		
		override public function handleBeginContact(callback:InteractionCallback):void
		{
			var collider:NapePhysicsObject = NapeUtils.CollisionGetOther(this, callback);
			
			if ( collider == Game.getInstance().hero )
			{
				Game.getInstance().coinTouched();
				Game.getInstance().remove(this);
				this.destroy();
			}
			
			if ( collider == Game.getInstance().floor && !alreadyHitGround)
			{
				alreadyHitGround = true;
				Game.instance.soundAndMusicManager.coinLand_SFX.play();
			}
			
			
		}
		
		override public function handleEndContact(callback:InteractionCallback):void
		{
			
		}
		
		override protected function createFilter():void
		{
			//_body.setShapeFilters(new InteractionFilter(PhysicsCollisionCategories.Get("rose"), PhysicsCollisionCategories.GetAllExcept("rose")));
		}
	}
}




