package com.vitapoly.valentinekitty.controller
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import com.vitapoly.valentinekitty.Game;
	import com.vitapoly.valentinekitty.Tools;
	import com.vitapoly.valentinekitty.Constants;
	
	public class LevelManager
	{
		public var level:int;
		private var i:int, dropSpeed:int;
		private var tools:Tools;
		private var levelUpTimer:Timer;
		private var dropItemTimer:Timer;
		
		public function LevelManager()
		{
			tools = new Tools;
		}
		
		public function init():void
		{
			level =0;
			cleanUp();
			dropSpeed = 2000; //drop something every 2 seconds
			levelUpTimer = new Timer(1000,Constants.secondsPerLevel); //level up every 20 seconds
			levelUpTimer.addEventListener(TimerEvent.TIMER_COMPLETE, levelUpTimerCompleteHandler);
			levelUpTimer.start();
			
			dropItemTimer = new Timer(dropSpeed,0); //drops until level up
			dropItemTimer.addEventListener(TimerEvent.TIMER, dropItemTimerHandler);
			dropItemTimer.start();
			
		}
		
		
		private function dropItemTimerHandler(e:TimerEvent):void
		{
			Game.getInstance().itemGenerator.generateRose();
			Game.getInstance().itemGenerator.generateUpToLevel(level);					
			
			if(level > 2) //2 items at a time
				Game.getInstance().itemGenerator.generateUpToLevel(level);
		}
		
		
		private function levelUpTimerCompleteHandler(e:TimerEvent):void
		{
			dropSpeed -= 500;
			if(dropSpeed <= 500)
				dropSpeed = 250;
			
			level++;
			levelUpTimer.reset();
			levelUpTimer.start();			
			Game.getInstance().gameGUI.showlevelUp(level);
		}
		
		public function cleanUp():void
		{
			if(dropItemTimer)dropItemTimer.removeEventListener(TimerEvent.TIMER, dropItemTimerHandler);
			if(levelUpTimer)levelUpTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, levelUpTimerCompleteHandler);
		}
	}
}

