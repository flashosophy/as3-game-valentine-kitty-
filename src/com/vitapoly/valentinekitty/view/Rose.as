package com.vitapoly.valentinekitty.view
{	
	
	import citrus.objects.NapePhysicsObject;
	import citrus.physics.PhysicsCollisionCategories;
	import citrus.physics.nape.NapeUtils;
	
	import nape.callbacks.InteractionCallback;
	import nape.dynamics.InteractionFilter;
	import com.vitapoly.valentinekitty.Game;
	import com.vitapoly.valentinekitty.model.PhysicsEditorObjects;
	
	public class Rose extends PhysicsEditorObjects//NapePhysicsObject
	{
		public var owner:NapePhysicsObject;
		
		public function Rose(name:String, owner:NapePhysicsObject, params:Object=null)
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
				Game.getInstance().roseTouched();
				Game.getInstance().remove(this);
				
				Game.instance.soundAndMusicManager.hearts_SFX.play();
				this.destroy();
				
			}
					
		}
		
		override public function handleEndContact(callback:InteractionCallback):void
		{
			
		}
		
		override protected function createFilter():void
		{
			_body.setShapeFilters(new InteractionFilter(PhysicsCollisionCategories.Get("rose"), 
				PhysicsCollisionCategories.GetAllExcept("rose")));
		}
	}
}




