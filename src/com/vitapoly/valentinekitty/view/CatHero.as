package com.vitapoly.valentinekitty.view
{
	import com.vitapoly.valentinekitty.Game;
	
	import flash.events.Event;
	
	import citrus.objects.NapePhysicsObject;

	import dragonBones.Armature;
	import dragonBones.Bone;
	import dragonBones.factorys.StarlingFactory;
	
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class CatHero extends NapePhysicsObject //citrus.objects.platformer.nape.Hero 
	{
		public var armature:Armature;
		private var factory:StarlingFactory;		
		private var armatureClip:Sprite;	
		private var currentAnim:int =0;
		private var catHeadTextures:Array = ["parts/headSad", "parts/headHappy"];
		private var catHatTextures:Array = ["parts/hatSad", "parts/hatHappy"];
		private var catGuitarTextures:Array = ["parts/guitarBrown","parts/guitarWhite"];
		
		public function CatHero(name:String, params:Object=null)
		{
			params.width = 75;
			params.height = 200;
			
			super(name, params);
			this.body.mass = 10;
			//this.controlsEnabled = false;

			this.offsetX += 10;
			this.offsetY -= 20;

		}
		
		public function init():void
		{						
			factory = new StarlingFactory();
			factory.addEventListener( flash.events.Event.COMPLETE, textureCompleteHandler);
			factory.parseData(new EmbeddedAssetsNonManaged["catResourcesData"]);	
		
		}
		
		
		private function textureCompleteHandler(e:flash.events.Event):void
		{
			armature = factory.buildArmature("Cat"); //skeleton list
			armatureClip = armature.display as Sprite;
			armatureClip.scaleX = .75;
			armatureClip.scaleY = .75;
			this.view = armatureClip;

			updateBehavior(0);			
			Game.getInstance().heroLoadComplete();
			guitarRegular();	
		}
		
		
		public function updateBehavior(in_moveDir:int):void
		{
			
			
			if (in_moveDir == 0)
			{
				armature.animation.gotoAndPlay("stand");
			}
			else
				if(in_moveDir == 1 && currentAnim != 1)
				{				
					armature.animation.gotoAndPlay("walkRight");
				}
				else
					if(in_moveDir == -1 && currentAnim != -1)
					{
						//armatureClip.scaleX = -moveDir;				
						armature.animation.gotoAndPlay("walkLeft");
					}
			currentAnim = in_moveDir;
		}

		
		
		public function changeFace(in_isHappy:Boolean):void
		{
			var textureIndex:int;
			if(in_isHappy)
			{
				textureIndex =1;
				
			}
			else
			{
				textureIndex =0;
			}
			
			//get the image instant from textureData
			var _textureName:String = catHeadTextures[textureIndex];
			var _image:Image = StarlingFactory.getTextureDisplay(factory.textureAtlasData, _textureName);
			
			// assign image to bone.display for chaging clothes effect. (using bone.display to dispose)
			var _bone:Bone = armature.getBone("head"); 
			_bone.display.dispose();
			_bone.display = _image;
			
			
			
			//for the hat
			_textureName = catHatTextures[textureIndex];
			_image = StarlingFactory.getTextureDisplay(factory.textureAtlasData, _textureName);
			
			_bone = armature.getBone("hat"); 
			_bone.display.dispose();
			_bone.display = _image;
			
			
			armature.update();
		} 
		
		public function guitarRegular():void
		{
			
			//get the image instant from textureData
			var _textureName:String = catGuitarTextures[0];
			var _image:Image = StarlingFactory.getTextureDisplay(factory.textureAtlasData, _textureName);
			
			// assign image to bone.display for chaging clothes effect. (using bone.display to dispose)
			var _bone:Bone = armature.getBone("guitar"); 
			_bone.display.dispose();
			_bone.display = _image;
			
			armature.update();
		}
		
		public function guitarUpgrade():void
		{
						
			//get the image instant from textureData
			var _textureName:String = catGuitarTextures[1];
			var _image:Image = StarlingFactory.getTextureDisplay(factory.textureAtlasData, _textureName);
			
			// assign image to bone.display for chaging clothes effect. (using bone.display to dispose)
			var _bone:Bone = armature.getBone("guitar"); 
			_bone.display.dispose();
			_bone.display = _image;
			
			armature.update();
		}
		
		
		public function checkArmatureUpdate():void
		{
			if(armature)
				armature.update();
		}
		
		/*
		override public function handleBeginContact(callback:InteractionCallback):void
		{
			var collider:NapePhysicsObject = NapeUtils.CollisionGetOther(this, callback);
			
			//if ( collider == Main.getInstance().hero )
			{
				//valentinekitty.instance.playSound("hearts",1,1);				
			
			}
			
		}*/
		
	} //end class
	
}



