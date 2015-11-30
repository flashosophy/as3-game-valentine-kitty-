package com.vitapoly.valentinekitty.view
{	
	
	import com.vitapoly.valentinekitty.Game;
	import com.vitapoly.valentinekitty.model.PhysicsEditorObjects;
	
	import citrus.objects.NapePhysicsObject;
	import citrus.physics.nape.NapeUtils;
	
	import nape.callbacks.InteractionCallback;
	
	public class DangerItem extends PhysicsEditorObjects//NapePhysicsObject
	{
		public var owner:NapePhysicsObject;
		public var coinsValue:int;
		public var damage:int;
		private var alreadyHitHero:Boolean, alreadyHitGround:Boolean;
		
		public function DangerItem(name:String, owner:NapePhysicsObject, params:Object=null)
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
			if(this.y >= 1500)
			{
				var isRight:Boolean;
				if(this.x > 500) 
					isRight = true;
				
				Game.getInstance().itemGenerator.generateCoin();	
				cleanUp();
			}
		}
		
		override public function handleBeginContact(callback:InteractionCallback):void
		{
			var collider:NapePhysicsObject = NapeUtils.CollisionGetOther(this, callback);
	
			//only hit if above head
			if ( collider == Game.getInstance().hero && (this.y <  Game.getInstance().hero.y - 50 ) && !alreadyHitHero)
			{
				alreadyHitHero = true; //can only get hit once by an item
				Game.getInstance().hurtPlayer(damage);
				
			}
			
			if ( collider == Game.getInstance().floor && !alreadyHitGround)
			{
				alreadyHitGround = true;
				if(Math.random() >= .5)
					Game.instance.soundAndMusicManager.land0_SFX.play();
				else
					Game.instance.soundAndMusicManager.land1_SFX.play();
			}
					
		}
		
		public function cleanUp():void
		{
			Game.getInstance().remove(this);
			this.destroy();
		}
		
		/*
		override public function handleEndContact(callback:InteractionCallback):void
		{
			
		}
		
		override protected function createFilter():void
		{
			_body.setShapeFilters(new InteractionFilter(PhysicsCollisionCategories.Get("rose"), 
				PhysicsCollisionCategories.GetAllExcept("rose")));
		}*/
	}
}




