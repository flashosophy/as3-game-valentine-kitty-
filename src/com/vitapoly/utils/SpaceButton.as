package com.vitapoly.utils
{
	import com.vitapoly.valentinekitty.Constants;
	import com.vitapoly.valentinekitty.Game;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	
	public class SpaceButton extends starling.display.Button
	{		
		public var letter:String = "space";
		private var gloss:Image = null;		
		public var state:String = null;
		
		public function SpaceButton(text:String, width:int, color:uint, inX:int, inY:int, font:String = null)
		{			 
			
			super(Game.sAssets.getTexture("spaceBtn") , text);
			
			fontBold = true;
			fontName = Constants.mainFont;;
			fontSize = 40;
			fontColor = 0x000000; //default
			
			this.color = color;
			
			var scale:Number = width / this.width;
//			this.width = width;
//			this.height *= scale;
			this.scaleX = scale;
			this.scaleY = scale;
			this.x = inX;
			this.y = inY;
			
			this.text = text;
		}

		public function get color():uint
		{ 
			return mBackground.color; 
			
		}
		
		public function set color(value:uint):void
		{
			mBackground.color = value;
		}
		
		public function addDO(in_do:DisplayObject, inX:int, inY:int):void
		{
			in_do.x = inX;
			in_do.y = inY;
			mContents.addChildAt(in_do, 2);
		}
		
		public function setFontColor(value:uint):void
		{
			this.fontColor = value;
		}
		
		public function moveTextToBottom():void
		{
			this.mTextField.y = 50;
		}
		
		public function setText(in_txt:String):void
		{
			this.mTextField.text = in_txt;
		}
		
		public function getText():String
		{
			return this.mTextField.text;
		}
		
	}
}


