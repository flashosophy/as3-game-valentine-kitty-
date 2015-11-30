package com.vitapoly.valentinekitty.view
{
	import com.vitapoly.utils.ViewUtils;
	import com.vitapoly.utils.GlossyButton;
	import com.vitapoly.valentinekitty.Constants;
	import com.vitapoly.valentinekitty.Game;
	import com.vitapoly.valentinekitty.Tools;

	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;

	public class GameGUI 
	{
		private const coinImageLimit:int = 5;
		private var i:int, levelNum:int, coinImageIndex:int;
		private var tools:Tools;
		private var lifeHearts:Array, heartsImgeArr:Array;
		private var happyBtn:Button, sadBtn:Button, instructionsBtn:Button, spendBtn:Button, buyCoinsBtn:Button, viewLoveWallBtn:Button;
		private var moreGamesBtn:GlossyButton;
		private var cashAndRoseTxt:TextField;
		private const scoreIncreaseAmount:int = 1;
		private var ready:Boolean;
		private var laggingGameScore:int=0;
		private var view:Sprite;
		private var levelUpImage:Image;
		private var moveLevelUpImageAwayTimer:Timer;
		public var isLevelTypeHappy:Boolean;
		
		
		public function GameGUI()
		{
			tools = new Tools;
			
		}
	
		
		public function init():void
		{		
			
			moveLevelUpImageAwayTimer = new Timer(2000,1);
			moveLevelUpImageAwayTimer.addEventListener("timer", moveLevelUpImageAwayTimerHandler);
			
			levelNum =0;
			levelUpImage = new Image(Game.sAssets.getTexture("levelup"));
			levelUpImage.visible = false;
			
			happyBtn = new Button(Game.sAssets.getTexture("modeHappy"));			
			sadBtn = new Button(Game.sAssets.getTexture("modeSad"));
			spendBtn = new Button(Game.sAssets.getTexture("spendBtn"));
			//buyCoinsBtn = new Button(Texture.fromBitmap(Game.sAssets.getTexture("buyCoinsBtn"]));
			viewLoveWallBtn = new Button(Game.sAssets.getTexture("wallOfLoveBtn"));
			moreGamesBtn = new GlossyButton("rect", "More Cute Games", 150, 0xFFCCFF);
			
			slideInGUIBtns();
			
			instructionsBtn= new Button(Game.sAssets.getTexture("longBtn"),"Touch Left Or");
			instructionsBtn.enabled = false;
			
			cashAndRoseTxt = new TextField(450,90,"",Constants.mainFont,30,0xFFffff);
			cashAndRoseTxt.touchable = false;
			cashAndRoseTxt.hAlign = "right"; cashAndRoseTxt.vAlign = "top";
			cashAndRoseTxt.x = 440; cashAndRoseTxt.y = 10;
			
			updateTitleRoseCoinsTxt();
			
			refreshHearts();
			Game.getInstance().addToScaleable(happyBtn);
			Game.getInstance().addToScaleable(sadBtn);
			Game.getInstance().addToScaleable(cashAndRoseTxt);
			Game.getInstance().addToScaleable(spendBtn);
			//Game.getInstance().addToScaleable(buyCoinsBtn);
			Game.getInstance().addToScaleable(viewLoveWallBtn);
			Game.getInstance().addToScaleable(moreGamesBtn);
			Game.getInstance().putScaleableContentOnTop();
			enableListeners();
			
		}
		
		public function refreshHearts():void
		{
			//first removes any existing hearts
			if(heartsImgeArr)
			{
				var heartLength:int = heartsImgeArr.length;
				for(i=0; i < heartLength; i++)
				{
					lifeHearts.pop();
					
					Game.getInstance().removeChild(heartsImgeArr.pop());
				}
			}
			
			
			//then add new set of hearts
			lifeHearts = new Array();
			heartsImgeArr = new Array();
			var tempHeart:Image;
			for(i=0; i < Game.getInstance().userProfile.life; i++)
			{
				tempHeart = new Image(Game.sAssets.getTexture("heart50"));
				
				tools.slide(tempHeart, i*60 +10, i*60 +10, -100, 10,2,.5,"easeOut");
				Game.getInstance().addChild(tempHeart);
				lifeHearts.push(tempHeart); //pops when lose
				heartsImgeArr.push(tempHeart); //never pops, used to refill
			}
			
		}
		
		public function restartGUI():void
		{
			slideInGUIBtns();
			updateTitleRoseCoinsTxt();
			refreshHearts();
			
		}
		
		//only for title screen
		public function updateTitleRoseCoinsTxt():void
		{
			cashAndRoseTxt.text = "Total Roses: " + Game.getInstance().userProfile.totalRosesCollected + "\nTotal Coins: " + Game.getInstance().userProfile.totalCurrency;
			
		}
		
		private function btnPressedHandler(e:starling.events.Event):void
		{
			var currentBtn:Button = e.target as Button;
			
			switch(currentBtn)
			{
				case happyBtn:
					Game.getInstance().hero.changeFace(1);
					Game.getInstance().backgroundManager.createHappyBackground();
					isLevelTypeHappy = true;
					Game.getInstance().itemGenerator.dropItem("rose",Game.getInstance().hero.x - 200, 0);	
					Game.getInstance().startGame();
					slideAwayGUIBtns();					
					Game.getInstance().particleManager.createParticleAt("blossom","flowerPNG", 1200, 500);
					
					Game.instance.soundAndMusicManager.happy_BGM.play();
					break;
				
				case sadBtn:
					Game.getInstance().hero.changeFace(0);
					Game.getInstance().backgroundManager.createSadBackground();
					isLevelTypeHappy = false;
					Game.getInstance().itemGenerator.dropItem("rose",Game.getInstance().hero.x + 200, 0);					
					Game.getInstance().startGame();
					slideAwayGUIBtns();					
					Game.getInstance().particleManager.createParticleAt("rainBlueFadePex","rainBlueFadePNG", 0, 0);	
					
					Game.instance.soundAndMusicManager.sad_BGM.play();
					break;
				
				
				case viewLoveWallBtn:
					
					Game.getInstance().wallOfLove.scrollGUIIn();
					break;
				
				case buyCoinsBtn:
					//Game.getInstance().showStore();					
					break;
				
				case spendBtn:
					
					Game.getInstance().showSpendCoins();
					break;
			
				case moreGamesBtn:					
					navigateToURL(new URLRequest("http://cutecatgames.com") );
					break;
			}
			valentinekitty.instance.removeAd();
			
		}
		
		private function slideInGUIBtns():void
		{
			tools.slide(sadBtn, valentinekitty.instance.deviceWidth, 550, 75,75,1,1,"easeOut");
			tools.slide(happyBtn, -500, 175, 75,75,1,1,"easeOut");			
			tools.slide(viewLoveWallBtn, -500, 75, 315,315,1,1.1,"easeOut");			
			
			tools.slide(spendBtn, valentinekitty.instance.deviceWidth, 645, 350,350,1,1.2,"easeOut");
			//tools.slide(buyCoinsBtn, valentinekitty.instance.deviceWidth, 645, 500,500,1,1.3,"easeOut");
			
			tools.slide(moreGamesBtn, valentinekitty.instance.deviceWidth, 700, 500,500,1,1.3,"easeOut");		
			
			Game.getInstance().gameSave.save();
		}
		
		private function slideAwayGUIBtns():void
		{
			tools.slide(sadBtn, 550 ,valentinekitty.instance.deviceWidth , 75,75,1,0,"easeIn");
			tools.slide(happyBtn,175,  -500, 75,75,1,0,"easeIn");			
			tools.slide(viewLoveWallBtn,75 ,  -500, 315,315,1,0.1,"easeIn");			
			
			tools.slide(spendBtn,645,valentinekitty.instance.deviceWidth , 350,350,1,0.2,"easeIn");
			//tools.slide(buyCoinsBtn,645 ,  valentinekitty.instance.deviceWidth, 500,500,1,0.3,"easeIn");
			
			tools.slide(moreGamesBtn,700 ,  valentinekitty.instance.deviceWidth, 500,500,1,0.3,"easeIn");
		}
		
		
		public function showGameGUI(in_boo:Boolean):void
		{
			laggingGameScore=0;		
			
			Game.getInstance().addChild(cashAndRoseTxt);
			
			ready = true;
			
			
			
		}
		
		public function removeHearts(in_num:int):void
		{
			var tempHeart:Image;
			
			if(Game.getInstance().currentGameLife <= in_num)
			{
				Game.getInstance().gameOver(false);
				Game.getInstance().currentGameLife =0;
				var length:int = lifeHearts.length;
				
				for(i=0; i < length; i++)
				{
					tempHeart = lifeHearts.pop();
					tools.slide(tempHeart, tempHeart.x, tempHeart.x, tempHeart.y, -100,1,0,"easeIn");
					
				}
			}
			else
			{
				for(i=0; i < in_num; i++)
				{
					tempHeart = lifeHearts.pop();
					tools.slide(tempHeart, tempHeart.x, tempHeart.x, tempHeart.y, -100,1,0,"easeIn");
					Game.getInstance().currentGameLife --;
				}
			}
		}
		
		//called when rose is hit
		public function addHeart():void
		{
			
			
			if(Game.getInstance().currentGameLife < Game.getInstance().userProfile.life)
			{
				Game.getInstance().currentGameLife ++;
				
				var heartIndex:int = Game.getInstance().currentGameLife -1;
				var tempHeart:Image = heartsImgeArr[heartIndex];
				lifeHearts.push(tempHeart);
				
				
				tools.slide(tempHeart, heartIndex*60 +10, heartIndex*60 +10, -100, 10,2,.5,"easeOut");
			}
			else
			{
				Game.getInstance().currentGameLife = Game.getInstance().userProfile.life;

			}
			
		}		
		
		public function update(tick:int):void
		{
			if(ready)
			{
								
				if(laggingGameScore+scoreIncreaseAmount <  Game.getInstance().currentGameCoins)
				{
					laggingGameScore += scoreIncreaseAmount;
				}
				else
				{
					laggingGameScore = Game.getInstance().currentGameCoins;
				}
				cashAndRoseTxt.text = "Level: "+ levelNum+"\nRoses: " + Game.getInstance().currentRosesCollected + "\nCoins: $" + laggingGameScore;
			}
			
		}
				
		public function showlevelUp(in_level:int):void
		{
			levelNum = in_level;
			Game.instance.soundAndMusicManager.stars_SFX.play();
			levelUpImage.visible = true;
			Game.getInstance().addChild(levelUpImage);
			ViewUtils.slide(levelUpImage, -levelUpImage.width, 500 ,200 , 200, 1, 0, "easeOut");
			moveLevelUpImageAwayTimer.reset();
			moveLevelUpImageAwayTimer.start();
			Game.getInstance().particleManager.createParticleAt("starExplosionPex","starExplosionPNG", 500 ,200,1);
			Game.instance.checkNinjaAward(levelNum);
		}
		
		private function moveLevelUpImageAwayTimerHandler(e:TimerEvent):void
		{
			ViewUtils.slide(levelUpImage,500, 1500, 200 , 200, 1, 0, "easeIn");
			
			Game.instance.soundAndMusicManager.swooshIn_SFX.play();
		}
		
		private function enableListeners():void
		{
			
			if(happyBtn) happyBtn.addEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
			if(sadBtn) sadBtn.addEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
			if(spendBtn) spendBtn.addEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
			if(buyCoinsBtn) buyCoinsBtn.addEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
			if(viewLoveWallBtn) viewLoveWallBtn.addEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
			if(moreGamesBtn) moreGamesBtn.addEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
			
		}
		
		private function disableListeners():void
		{
			if(happyBtn) happyBtn.removeEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
			if(sadBtn) sadBtn.removeEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
			if(spendBtn) spendBtn.removeEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
			if(buyCoinsBtn) buyCoinsBtn.removeEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
			if(viewLoveWallBtn) viewLoveWallBtn.removeEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
			if(moreGamesBtn) moreGamesBtn.removeEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
			
		}
		
		public function cleanUp():void
		{
			//if(moveLevelUpImageAwayTimer)moveLevelUpImageAwayTimer.removeEventListener("timer", moveLevelUpImageAwayTimerHandler);
			//disableListeners();
			
		}
		
	}
}



