package com.vitapoly.valentinekitty.controller
{
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;
	import com.vitapoly.valentinekitty.Game;
	
	public class ParticleManager extends Sprite
	{
		public var currentParticle:PDParticleSystem;
		private var particleArr:Array;
		private var i:int;
		
		public function ParticleManager()
		{
			particleArr = new Array();
		}
	
		public function createParticleAt(in_name:String, in_texture:String, in_x:int, in_y:int, in_duration:Number=0):PDParticleSystem
		{			
			currentParticle = new PDParticleSystem( XML(new EmbeddedAssets[in_name]), Texture.fromBitmap( new EmbeddedAssets[in_texture]));
			
			if(in_duration==0)
				currentParticle.start();  
			else
				currentParticle.start(in_duration); 
			currentParticle.x = in_x;	currentParticle.y = in_y;	particleArr.push(currentParticle);	
			
			addParticle(currentParticle);
			return currentParticle;
		}
		
		/*
		public function createCustomParticleAt(in_name:String, in_texture:String, in_x:int, in_y:int, in_scale:int =1, in_speed:int = 75, in_speedVariance:int=10, in_tanAcc:int = 25, in_maxPart:int= 10, in_gravityX:int=-20, in_gravityY:int=0):PDParticleSystem
		{
			currentParticle = new PDParticleSystem( Assets.getXML("textures/particles/"+in_name+".pex"),Assets.getTexture("particles/"+in_texture));
			currentParticle.start();currentParticle.x = in_x;	currentParticle.y = in_y;currentParticle.scaleX =in_scale;currentParticle.scaleY = in_scale;
			currentParticle.speed = in_speed;	currentParticle.speedVariance = in_speedVariance;	currentParticle.tangentialAcceleration = in_tanAcc;
			currentParticle.gravityX = in_gravityX;		currentParticle.gravityY = in_gravityY;
			currentParticle.s
			//currentParticle.blendFactorSource = "ONE";                           //1
			//currentParticle.blendFactorDestination ="ONE_MINUS_SOURCE_ALPHA";    //771
			currentParticle.maxCapacity = in_maxPart;
			particleArr.push(currentParticle);
			Main.instance.view.addParticle(currentParticle, false);
			
			return currentParticle;
		}*/
		
		public function cleanUp():void
		{
			var particleNum:int = particleArr.length;
			
			for(i=0; i < particleNum; i++)
			{
				particleArr[i].stop();
				removeParticle(particleArr[i]);
				particleArr[i] = null;
			}
			particleArr = new Array();
			
		}
		
		
		public function addParticle(in_part:PDParticleSystem):void
		{
			Game.getInstance().putParticlesOnTop();
			addChild(in_part);
			in_part.addEventListener(Event.COMPLETE, function(e:Event):void {
				removeParticle(in_part);
			});
			Starling.juggler.add(in_part);
			
		}
		
		public function removeCurrentParticle():void
		{
			removeChild(currentParticle);
			Starling.juggler.remove(currentParticle);
		}
		
		public function removeParticle(in_part:PDParticleSystem):void
		{
			removeChild(in_part);
			Starling.juggler.remove(in_part);
		}
		
		
	}
}

