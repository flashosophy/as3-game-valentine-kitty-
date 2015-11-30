package com.vitapoly.utils
{
	import com.vitapoly.valentinekitty.Game;
	import com.vitapoly.valentinekitty.Constants;
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class GlossyButton extends starling.display.Button
	{
		public static const SQUARE:String = "square";
		public static const RECT:String = "rect";
		public static const LONG:String = "long";
		public static const SHORT:String = "short";
		
		// static var, can be changed
		public static var FONT:String = "MarkerFelt";
		
		private static var atlas:TextureAtlas;
		
		public var state:String = null;
		
		public function GlossyButton(type:String, text:String, width:int, color:uint=0xffffff, inX:int=0, inY:int=0, font:String = null)
		{
			type = type.toLowerCase();
		
			super(Game.sAssets.getTexture(type+"Btn"), text);
			
			
			font = Constants.mainFont;
			
			fontBold = true;
			fontName = font;
			fontSize = 50;
			fontColor = 0x000000; //default
			
			this.color = color;
			var scale:Number = width / this.width;
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