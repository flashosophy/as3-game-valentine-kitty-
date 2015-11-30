﻿package com.vitapoly.valentinekitty.view{	import com.vitapoly.valentinekitty.Game;	import com.vitapoly.valentinekitty.Constants;	import flash.geom.Rectangle;	import flash.utils.Timer;		import starling.display.Button;	import starling.textures.Texture;
   public class LetterBtn extends starling.display.Button   {		public var ID:uint;		public var isRight:Boolean;		public var letter:String;				private var nextRow:int;		private var moveTimer:Timer;		private var mTextBounds:Rectangle;		      public function LetterBtn(width:int, color:uint, inX:int, inY:int, in_letter:String="")	  {		  letter=in_letter;		  			super(Game.sAssets.getTexture("squareBtn"), text);			 			fontBold = true;			fontName = Constants.mainFont;			fontSize = 70;			fontColor = 0xFF6600; //default			 			addChild(mTextField);			  			var scale:Number = width / this.width;			this.scaleX = scale;			this.scaleY = scale;			this.x = inX;			this.y = inY;    			updateLetter(letter);      }	      public function updateLetter(in_Str:String):void{         letter = in_Str;		 this.mTextField.text= letter;      }	  public function setLetterUpperCase(in_boo:Boolean):void	  {		  if(in_boo)		  {			  letter =  letter.toUpperCase();		  }		  else		  {			  letter = letter.toLowerCase();		  }		  this.mTextField.text= letter;	  }	  	  public function cleanUp():void	  {		// this.removeEventListener(starling.events.Event.TRIGGERED, btnPressed);		//  Main.instance.stage.removeEventListener(TouchEvent.TOUCH, onTouch);	  }	     }//end class}