package com.vitapoly.utils
{
	import flash.geom.Point;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;

	public class ViewUtils
	{
		public static function slide(view:DisplayObject, fromX:int, toX:int, fromY:int, toY:int, time:Number = 1.0, delay:Number = 0, easeType:String="easeInOut"):void
		{
			
			view.x = fromX;
			view.y = fromY;
			var tween:Tween = new Tween(view, time,easeType); //.. Transitions.EASE_IN_OUT);
			tween.delay = delay;
			tween.animate("x", toX);
			tween.animate("y", toY);
			Starling.juggler.add(tween); 
		}
		
		public static function clip(image:Image, x:int, y:int, width:int, height:int):void {
			
			var x1:Number = x / image.texture.width;
			var x2:Number = (x + width) / image.texture.width;
			var y1:Number = y / image.texture.height;
			var y2:Number = (y + height) / image.texture.height;
			
			image.setTexCoords(0, new Point(x1, y1));
			image.setTexCoords(1, new Point(x2, y1));
			image.setTexCoords(2, new Point(x1, y2));
			image.setTexCoords(3, new Point(x2, y2));
			
			image.width = width;
			image.height = height;
		}
		
		public static function flip(view:DisplayObject):void {
			view.scaleX = -view.scaleX;
			view.x -= view.scaleX * view.width;
		}
		
		public static function flipVertical(view:DisplayObject):void {
			view.scaleY = -view.scaleY;
			view.y -= view.scaleY * view.height;
		}
		
	}
}