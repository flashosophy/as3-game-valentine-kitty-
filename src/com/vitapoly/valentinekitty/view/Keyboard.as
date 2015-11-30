package com.vitapoly.valentinekitty.view
{
	import com.vitapoly.utils.GlossyButton;
	import com.vitapoly.utils.SpaceButton;
	import com.vitapoly.valentinekitty.Game;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Keyboard
	{
		
		private var i:int;
		public var view:Sprite;
		private var blockerQuad:Quad;
		private var row0LetterArr:Array = new Array("Q","W","E","R","T","Y","U","I","O","P");
		private var row1LetterArr:Array = new Array("A","S","D","F","G","H","J","K","L","\'","!");
		private var row2LetterArr:Array = new Array("Z","X","C","V","B","N","M",",",".","?");
		private var letterArr:Array;
		private var spaceBar:SpaceButton;
		private var shiftBtn:GlossyButton;
		private var isShiftOn:Boolean;
		private var backSpaceBtn:GlossyButton;
		
		public function Keyboard()
		{
						
			view = new Sprite();
			letterArr = new Array();
			
			blockerQuad = new Quad(1280,600,0xFFFFCC);
			blockerQuad.x = -200;
			blockerQuad.y = -10;
			shiftBtn = new GlossyButton("rect", "Shift", 120,0x00FF99,20,250);
			spaceBar = new SpaceButton("", 600,0xffffff,180,240);
			spaceBar.height = 80;
			backSpaceBtn= new GlossyButton("rect", "Backspace", 135,0xffffff,750,2);
		}
		
		//adds the keys and puts it in right location
		public function init():void
		{	
			view.addChild(blockerQuad);
			var tempLetter:LetterBtn;
			//create first line of letterse, qwertyuiop
			for(i=0; i < row0LetterArr.length; i++)
			{
				tempLetter = new LetterBtn(70, 0xffffff, i*75, 0, row0LetterArr[i]);
				view.addChild(tempLetter);
				tempLetter.addEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
				letterArr.push(tempLetter);
			}
			
			for(i=0; i < row1LetterArr.length; i++)
			{
				tempLetter = new LetterBtn(70, 0xffffff, i*75+40, 80, row1LetterArr[i]);				
				view.addChild(tempLetter);
				tempLetter.addEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
				letterArr.push(tempLetter);
			}
			
			for(i=0; i < row2LetterArr.length; i++)
			{
				tempLetter = new LetterBtn(70, 0xffffff, i*75+75, 160, row2LetterArr[i]);
				view.addChild(tempLetter);
				tempLetter.addEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
				letterArr.push(tempLetter);
			}
			
			
			
			isShiftOn = true; //default first letter is caps
			
			view.addChild(spaceBar);
			view.addChild(shiftBtn);
			view.addChild(backSpaceBtn);
			
		}
		
		public function show():void
		{
			
			cleanUp();
			
			if(valentinekitty.instance.isIpadRetina)
			{
				//view.x = 50;
				//view.y = 350
				valentinekitty.instance.tools.slide(view, 50,50, 1000, 325,1,0, "easeOut");
					
			}
			else
			{
				valentinekitty.instance.tools.slide(view,15+ valentinekitty.instance.xDiff,15+valentinekitty.instance.xDiff, 1000+valentinekitty.instance.yDiff, 280+valentinekitty.instance.yDiff,1,0, "easeOut");
				
			}
			enableListeners();
			
		}
		
		private function btnPressedHandler(e:starling.events.Event):void
		{
			//var currentLetter:Letter= Letter(e.target);
			if(e.currentTarget is LetterBtn)
			{
				var tempLetter:LetterBtn = LetterBtn(e.currentTarget);
				Game.getInstance().wallOfLove.letterPressed(tempLetter.letter);
				toggleOnOffShift(false);
			}
			else
			if(e.currentTarget is SpaceButton)
			{
				Game.getInstance().wallOfLove.spacebarPressed();
			}
			else
			if(e.currentTarget == shiftBtn)
			{
				isShiftOn = !isShiftOn;
				
				toggleOnOffShift(isShiftOn);
				
			}
			else
				if(e.currentTarget ==  backSpaceBtn)					
				{
					Game.getInstance().wallOfLove.backspacePressed();
				}
			
		}
		
		//also toggled from submit post when a new section is pressed
		public function toggleOnOffShift(in_boo:Boolean):void
		{
			if(in_boo)
			{
				isShiftOn = true; //always makes shift off when a letter is pressed
				shiftBtn.mBackground.color = 0x00FF99;
				setLettersUpperCase(true);
			}
			else
			{
				isShiftOn = false; //always makes shift off when a letter is pressed
				shiftBtn.mBackground.color = 0xffffff;
				setLettersUpperCase(false);
			}
		}
		
		private function setLettersUpperCase(in_boo:Boolean):void
		{
			var tempLetter:LetterBtn;
			var arrLength:int = letterArr.length;
			
			for(i=0; i < arrLength; i++)
			{
				tempLetter = letterArr[i];
				tempLetter.setLetterUpperCase(in_boo);
			}
			
		}
		
		
		public function retract():void
		{
			if(valentinekitty.instance.isIpadRetina)
			{
				valentinekitty.instance.tools.slide(view, 50,50, 325, 1000,1,0, "easeIn");
				
			}
			else
			{
				valentinekitty.instance.tools.slide(view,15+valentinekitty.instance.xDiff,15+valentinekitty.instance.xDiff,280+valentinekitty.instance.yDiff ,  1000+valentinekitty.instance.yDiff,1,0, "easeIn");
			}
		}
		
		private function enableListeners():void
		{
			
			spaceBar.addEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
			shiftBtn.addEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
			backSpaceBtn.addEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
		}
		
		private function disableListeners():void
		{
			
			//if(playBtn) playBtn.removeEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);			
			var viewNum:int = view.numChildren;
			var tempLetterBtn:LetterBtn;
			
			for(i=0; i < view; i++)
			{
				tempLetterBtn = view.getChildAt(i) as LetterBtn;
				tempLetterBtn.removeEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
			}
			if(spaceBar)spaceBar.removeEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
			if(shiftBtn)shiftBtn.removeEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
			if(backSpaceBtn)backSpaceBtn.addEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
		}
		
		public function cleanUp():void
		{
			disableListeners();
		}
		
	}
}

