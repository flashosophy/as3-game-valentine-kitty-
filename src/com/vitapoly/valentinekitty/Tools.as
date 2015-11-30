
//must include the .as files here or else it won't be aware
//only works for textures and text files such as xml (doesn't work with audio)
package com.vitapoly.valentinekitty
{
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	
	public class Tools
	{
		
		public function slide(view:DisplayObject, fromX:int, toX:int, fromY:int, toY:int, time:Number = 1.0, delay:Number = 0, easeType:String="easeInOut"):void
		{			
			view.x = fromX;
			view.y = fromY;
			var tween:Tween = new Tween(view, time,easeType); //.. Transitions.EASE_IN_OUT);
			tween.delay = delay;
			tween.animate("x", toX);
			tween.animate("y", toY);
			Starling.juggler.add(tween); 
		}
		
		public function randRange(min:Number, max:Number):Number{
			var randomNum:Number = Math.floor(Math.random() * (max - min + 1)) + min
			return randomNum
		}
		
		
	}
}