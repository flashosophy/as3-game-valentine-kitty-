package com.vitapoly.valentinekitty.controller
{
	import com.vitapoly.valentinekitty.Game;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import starling.display.Quad;
	
	public class TransitionManager
	{
		
		private var i:int;
		private var fadeTimer:Timer;
		private var fadeQuad:Quad;
		private var transitionLock:Boolean;
		private var fadeSpeed:Number;
		
		public function TransitionManager()
		{
			fadeTimer = new Timer(60, 100);
			fadeTimer.addEventListener("timer", fadeTimerHandler);
			
		}
		
		//called from controller 
		public function fadeIn(in_color:int, in_fade:Number=.15):void
		{
			fadeSpeed = in_fade;
			if(!transitionLock)
			{
				//making Y bigger cause of scaling for different phones
				fadeQuad = new Quad(1500 , 1500,in_color);	
			
				fadeTimer.reset();
				fadeTimer.start();
				Game.getInstance().addChild(fadeQuad); //highest level
				transitionLock = true;
			}
		}
		
		public function fadeTimerHandler(e:TimerEvent):void
		{
			fadeQuad.alpha -= fadeSpeed;
			if(fadeQuad.alpha <= 0)
			{
				Game.getInstance().removeChild(fadeQuad);
				fadeTimer.stop();
				transitionLock = false;
			}
		}
		
		
		public function cleanUp():void
		{
			fadeTimer.removeEventListener("timer", fadeTimerHandler);
		}
		
	}
}

