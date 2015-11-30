package com.vitapoly.valentinekitty.view
{
	import com.vitapoly.utils.GlossyButton;
	import com.vitapoly.valentinekitty.Constants;
	import com.vitapoly.valentinekitty.Game;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	
	public class SubmitPost
	{
		
		public var view:Sprite;
		private var i:int, charLimit0:int, charLimit1:int, charLimit2:int;
		private var toFromMessageStaticTxt:TextField, fromDynTxt:TextField, toDynTxt:TextField, msgDynTxt:TextField, currrentSelectedTextField:TextField , charLimitTxt0:TextField,charLimitTxt1:TextField ,charLimitTxt2:TextField  ;
		private var arrowImage:Image;
		private var postBtn:GlossyButton, cancleBtn:GlossyButton;
		private var isFirstEntry:Boolean;
		
		private var blockerQuad:Quad;
		
		public function SubmitPost()
		{						
			view = new Sprite();
			toFromMessageStaticTxt = new TextField(500,500,"", Constants.mainFont, 30, 0x000000);
			toFromMessageStaticTxt.hAlign = "left"; toFromMessageStaticTxt.vAlign ="top";
			toFromMessageStaticTxt.x = 150; toFromMessageStaticTxt.y = 20;
			toFromMessageStaticTxt.touchable = false;
			blockerQuad = new Quad(1280,500,0xFFFFCC);

			fromDynTxt = new TextField(500,30,"", Constants.mainFont, 30, 0x663300);
			fromDynTxt.x = 270;  fromDynTxt.y = 20; fromDynTxt.hAlign = "left"; fromDynTxt.vAlign ="top";			
			
			toDynTxt = new TextField(500,30,"", Constants.mainFont, 30, 0x663300);
			toDynTxt.x = 270;  toDynTxt.y = 80; toDynTxt.hAlign = "left"; toDynTxt.vAlign ="top";
			
			msgDynTxt = new TextField(1000,30,"", Constants.mainFont, 30, 0x663300);
			msgDynTxt.x = 150;  msgDynTxt.y = 200; msgDynTxt.hAlign = "left"; msgDynTxt.vAlign ="top";
			
			arrowImage = new Image(Game.sAssets.getTexture("arrow") );
			arrowImage.x = 100 ; arrowImage.y = fromDynTxt.y ; 
			
			charLimitTxt0= new TextField(200,30,"", Constants.mainFont, 30, 0x663300);
			charLimitTxt0.x = 20;  charLimitTxt0.y = fromDynTxt.y; charLimitTxt0.hAlign = "left"; charLimitTxt0.vAlign ="top";	
			charLimitTxt1= new TextField(200,30,"(30)", Constants.mainFont, 30, 0x663300);
			charLimitTxt1.x = 20;  charLimitTxt1.y = toDynTxt.y; charLimitTxt1.hAlign = "left"; charLimitTxt1.vAlign ="top";	
			charLimitTxt2= new TextField(200,30,"(90)", Constants.mainFont, 30, 0x663300);
			charLimitTxt2.x = 20;  charLimitTxt2.y = msgDynTxt.y; charLimitTxt2.hAlign = "left"; charLimitTxt2.vAlign ="top";	
			
			postBtn = new GlossyButton("rect", "Post", 150,0xFFCCFF,700, 20);
			cancleBtn = new GlossyButton("rect", "Cancel", 150,0xFF0000, 700, 120);
			
		}
		
		//adds the keys and puts it in right location
		public function init():void
		{				

			view.addChild(blockerQuad);
			view.addChild(toFromMessageStaticTxt);
			view.addChild(fromDynTxt);
			view.addChild(toDynTxt);
			view.addChild(msgDynTxt);
			view.addChild(arrowImage);
			view.addChild(postBtn);
			view.addChild(cancleBtn);
			
			view.addChild(charLimitTxt0);
			view.addChild(charLimitTxt1);
			view.addChild(charLimitTxt2);
			
		}
		
		public function show():void
		{
			cleanUp();
			enableListeners();
			
			toFromMessageStaticTxt.text= "From      :\n\nTo          :\n\nMessage With "+ Game.getInstance().userProfile.totalRosesCollected +" Roses:";
			fromDynTxt.text = "Touch Here To Edit/Erase Name.";
			toDynTxt.text = "Touch Here To Edit/Erase Name.";
			msgDynTxt.text = "Touch Here To Edit/Erase Message.";
			
			resetCharLimitTxt(fromDynTxt);
			resetCharLimitTxt(toDynTxt);
			resetCharLimitTxt(msgDynTxt);			
			
			currrentSelectedTextField = fromDynTxt; //default
			valentinekitty.instance.tools.slide(view, 0,0, -500, 0,1,0, "easeOut");
			isFirstEntry = true;
		}
		
		private function resetCharLimitTxt(in_txt:TextField):void
		{
			if(in_txt == fromDynTxt)
			{
				charLimit0 = 30;
				charLimitTxt0.text = "(30)";
			}
			else
				if(in_txt == toDynTxt)
				{	
					charLimit1 = 30;
					charLimitTxt1.text = "(30)";
				}
				else
					if(in_txt == msgDynTxt)
					{	
						charLimit2 = 90;
						charLimitTxt2.text = "(90)";
					}
		}
		
		
		private function letterPressedHandler(event:TouchEvent):void
		{			
			var item:TextField = event.currentTarget as TextField;
			
			//touchX = e.touches[0].globalX;
			//touchY = e.touches[0].globalY;
			
			
			if ( event.touches[0].phase == TouchPhase.BEGAN) //on touch
			{
				item.text = "";
				currrentSelectedTextField = item;
				arrowImage.y = currrentSelectedTextField.y;
				resetCharLimitTxt(currrentSelectedTextField);
				
				Game.getInstance().wallOfLove.keyboard.toggleOnOffShift(true);
			}
			
			/*
			if ( e.touches[0].phase == TouchPhase.ENDED ) //on release
			{
			
			}*/
		}
		
		public function enterLetter(in_str:String):void
		{
			if(isFirstEntry && currrentSelectedTextField == fromDynTxt)
			{
				currrentSelectedTextField.text = ""; //blank it out
				isFirstEntry = false;
			}
			
			
			if(checkIsValidEntry())
				currrentSelectedTextField.text += in_str;
			
		}
		
		public function enterSpacebar():void
		{
			if(checkIsValidEntry())
				currrentSelectedTextField.text += " ";
		}
		
		public function backspacePressed():void
		{
			currrentSelectedTextField.text = currrentSelectedTextField.text.substring(0, currrentSelectedTextField.text.length -1);
		}
		
		private function checkIsValidEntry():Boolean
		{
			var valid:Boolean;
			
			if(currrentSelectedTextField == fromDynTxt)
			{
				charLimit0 --;
				if(charLimit0 >=0)
				{
					charLimitTxt0.text = "("+charLimit0 + ")";
					valid = true;
				}
				else
				{
					charLimit0 = 0;
				}
				
			}
			else
				if(currrentSelectedTextField == toDynTxt)
				{
					charLimit1 --;
					if(charLimit1 >= 0)
					{
						charLimitTxt1.text = "("+charLimit1 + ")";
						valid = true;
					}
					else
					{
						charLimit1 = 0;
					}
				}
				else
					if(currrentSelectedTextField == msgDynTxt)
					{
						charLimit2 --;
						if(charLimit2 >= 0)
						{
							charLimitTxt2.text = "("+charLimit2 + ")";
							valid = true;
						}
						else
						{
							charLimit2 = 0;
						}
						
					}	
			return valid;
		}
		
		private function btnPressedHandler(e:starling.events.Event):void
		{
			switch(e.target)
			{	
				case postBtn:
					if(Game.instance.userProfile.isCheating)
					{
						var cheatBtn:GlossyButton = new GlossyButton("rect", "Cheaters don't get to post.  They get ADS.",500,0xffffff,20,300);
						Game.getInstance().addChild(cheatBtn);
						valentinekitty.instance.showAdAt(200,200);
					}
					else
					{
						Game.getInstance().wallOfLove.postMsg(fromDynTxt.text, toDynTxt.text, msgDynTxt.text);
						Game.getInstance().wallOfLove.cancelPost();
						valentinekitty.instance.tools.slide(view, 0,0, 0, -500,1,0, "easeIn");
					}
					break;
				case cancleBtn:
					valentinekitty.instance.tools.slide(view, 0,0, 0, -500,1,0, "easeIn");
					Game.getInstance().wallOfLove.cancelPost();
					cleanUp();
					break;
				
			}
			Game.getInstance().gameSave.save();
		}
		
		private function enableListeners():void
		{
			
			if(fromDynTxt) fromDynTxt.addEventListener(TouchEvent.TOUCH, letterPressedHandler);			
			if(toDynTxt) toDynTxt.addEventListener(TouchEvent.TOUCH, letterPressedHandler);			
			if(msgDynTxt) msgDynTxt.addEventListener(TouchEvent.TOUCH, letterPressedHandler);	
			
			if(postBtn) postBtn.addEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
			if(cancleBtn) cancleBtn.addEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);	
			
			
			
		}
		
		private function disableListeners():void
		{
			if(fromDynTxt) fromDynTxt.removeEventListener(TouchEvent.TOUCH, letterPressedHandler);			
			if(toDynTxt) toDynTxt.removeEventListener(TouchEvent.TOUCH, letterPressedHandler);			
			if(msgDynTxt) msgDynTxt.removeEventListener(TouchEvent.TOUCH, letterPressedHandler);	
			
			if(postBtn) postBtn.removeEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
			if(cancleBtn) cancleBtn.removeEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);	
			
			
			
		}
		
		public function cleanUp():void
		{
			disableListeners();
		}
		
	}
}

