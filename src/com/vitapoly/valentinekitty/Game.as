package com.vitapoly.valentinekitty
{
	import com.newgrounds.API;
	import com.vitapoly.features.UserProfile;
	import com.vitapoly.utils.GlossyButton;
	import com.vitapoly.utils.ProgressBar;
	import com.vitapoly.valentinekitty.controller.BackgroundManager;
	import com.vitapoly.valentinekitty.controller.ItemGenerator;
	import com.vitapoly.valentinekitty.controller.LevelManager;
	import com.vitapoly.valentinekitty.controller.ParticleManager;
	import com.vitapoly.valentinekitty.controller.SoundAndMusicManager;
	import com.vitapoly.valentinekitty.controller.TransitionManager;
	import com.vitapoly.valentinekitty.model.GameSave;
	import com.vitapoly.valentinekitty.view.CatHero;
	import com.vitapoly.valentinekitty.view.GameGUI;
	import com.vitapoly.valentinekitty.view.SpendCoins;
	import com.vitapoly.valentinekitty.view.WallOfLove;
	
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.utils.Timer;
	
	import citrus.core.CitrusEngine;
	import citrus.core.CitrusGroup;
	import citrus.core.starling.StarlingState;
	import citrus.input.controllers.Keyboard;
	import citrus.math.MathVector;
	import citrus.objects.platformer.nape.Platform;
	import citrus.physics.PhysicsCollisionCategories;
	import citrus.physics.nape.Nape;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	
	public class Game extends StarlingState
	{
		public static var instance:Game = null;
		private static var _ce:CitrusEngine;
		public static var sAssets:AssetManager;
		private var ready:Boolean;
		private var isLeft:Boolean;
		private var isRight:Boolean;
		private var moveDir:int=0, showAdCounter:int;
		private var walkSpeed:int = 6;		
		private var dangerContent:CitrusGroup;
		private var tools:Tools;
		private var lightsOnTimer:Timer, startPlayTitleMusicTimer:Timer, showAdRestartGameDelay:Timer;		
		private var physics:Nape;
		private var frameCount:int = 0;
		private var totalTime:Number = 0;		
		private var roseTouchHeroContact:Boolean = false;
		private var gameOverMsg:GlossyButton;
		private var cheatCheckTimer:Timer;
		private var prevRoses:Number;
		private var prevCoins:Number;
		
		public var isHurtThisSession:Boolean;
		
		public var hero:CatHero;
		public var touchX:Number, touchY:Number;		
		public var floor:Platform;
		public var currentGameLife:int, currentGameCoins:int, currentRosesCollected:int;

		public var particleManager:ParticleManager;
		public var itemGenerator:ItemGenerator;
		public var levelManager:LevelManager;
		public var backgroundManager:BackgroundManager;
		public var gameGUI:GameGUI;
		public var userProfile:UserProfile;
		public var gameSave:GameSave;
		public var transitionManager:TransitionManager;
		public var wallOfLove:WallOfLove;
		public var spendCoins:SpendCoins;
		public var soundAndMusicManager:SoundAndMusicManager;
		
		public var scaleableContent:Sprite;
		
		private var mLoadingProgress:ProgressBar;
		
		
		public function Game()
		{
			super();
			instance = this;
			_ce = CitrusEngine.getInstance();
			cheatCheckTimer = new Timer(1000, 0);
			cheatCheckTimer.addEventListener(TimerEvent.TIMER, cheatCheckTimerHandler);
			
		}
		
		public function start(assets:AssetManager):void
		{					
		
			sAssets = assets;
			
			//valentinekitty.instance.showAdAt(50, 250);
			
			mLoadingProgress = new ProgressBar(200, 20);
			mLoadingProgress.x =  250;
			mLoadingProgress.y =  150;
			
			addChild(mLoadingProgress);
			
			assets.loadQueue(function(ratio:Number):void
			{
				mLoadingProgress.ratio = ratio;
				
				// a progress bar should always show the 100% for a while,
				// so we show the main menu only after a short delay. 
				
				if (ratio == 1)
					Starling.juggler.delayCall(function():void
					{
						mLoadingProgress.removeFromParent(true);
						mLoadingProgress = null;
						loadReady();
					}, 0.15);
			});
			
			//addEventListener(Event.TRIGGERED, onButtonTriggered);
			//stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);
			
		}
		
		private function loadReady():void
		{
			valentinekitty.instance.removeAd();
			
			scaleableContent = new Sprite;
			tools = new Tools;
			particleManager = new ParticleManager;
			lightsOnTimer = new Timer(500,1);
			lightsOnTimer.addEventListener(TimerEvent.TIMER, turnOnLightsHandler);
			
			startPlayTitleMusicTimer = new Timer(500,1);
			startPlayTitleMusicTimer.addEventListener(TimerEvent.TIMER, startPlayTitleMusicTimerHandler);
			
			showAdRestartGameDelay = new Timer(2000,1);
			showAdRestartGameDelay.addEventListener(TimerEvent.TIMER, showAdRestartGameDelayHandler);
			soundAndMusicManager = new SoundAndMusicManager;
			
			itemGenerator = new ItemGenerator;
			levelManager = new LevelManager;
			gameGUI = new GameGUI;
			backgroundManager = new BackgroundManager;
			userProfile = new UserProfile();
			userProfile.version = 0.1;
			gameSave = new GameSave("com.vitapoly.valentinekitty");
			
			wallOfLove = new WallOfLove;			
			transitionManager = new TransitionManager;		
			spendCoins = new SpendCoins;
			
			Starling.current.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			
			prevRoses = Game.getInstance().userProfile.totalRosesCollected;
			prevCoins = Game.getInstance().userProfile.totalCurrency;
			
			
			
			currentGameLife = userProfile.life;
			currentGameCoins = 0;
			currentRosesCollected = 0; 
			super.initialize();
			valentinekitty.instance.removeLoadScreen();			
			gameOverMsg = new GlossyButton("long", "", 500, 0xFFCCFF)
			TextField.registerBitmapFont(new BitmapFont(Texture.fromBitmap(new EmbeddedAssetsNonManaged["MarkerFelt"], false), XML(new EmbeddedAssetsNonManaged["MarkerFelt_fnt"])));
			
			physics = new Nape("nape");
			//physics.visible = true;  //this is debug and won't show views
			add(physics); //adds physics to the state
			
			// additional collisions
			PhysicsCollisionCategories.Add("rose");
			
			//everything is referenced from the center
			floor = new Platform("floor", {x:600, y:1000, width:1200, height:10});
			//floor.view = new Quad(1200, 40, 0x333333);			
			add(floor);
			
			hero = new CatHero("hero", {x:700, y:700});	
			hero.init();
			
			wallOfLove.init();
			backgroundManager.init();
			spendCoins.init();
			
			lightsOnTimer.start();
			
			cheatCheckTimer.start();
		}
		
		
		
		public static function getInstance():Game
		{
			if (instance == null)
			{
				instance = new Game();
			}
			return instance;
		}
		/*
		override public function initialize():void
		{
			super.initialize();
			
		}*/
	
		public function heroLoadComplete():void
		{			

			add(hero);
			
			//left limit, upper limit, right limit, lower limit
			//view.setupCamera(hero, new MathVector(450, 0), new Rectangle(-200, -200, 1600, 1200), new MathVector(.25, .05));				
			view.camera.setUp(hero, new MathVector(450, 0), new Rectangle(-200, -200, 1600, 1200), new MathVector(.25, .05));	
		}
		
		public function startGame():void
		{
			isHurtThisSession = false;
			soundAndMusicManager.stopAllBGM();
			particleManager.cleanUp();
			this.gameGUI.showGameGUI(true);
			
			add(hero);
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
			levelManager.init();
			backgroundManager.setColor(0x000000);
			ready = true;
			
		}
		
		private function turnOnLightsHandler(e:flash.events.TimerEvent):void
		{
			soundAndMusicManager.lightOn_SFX.play();
			startPlayTitleMusicTimer.start();
			
			backgroundManager.showSpotLight();
			gameGUI.init();
		}
		
		private function startPlayTitleMusicTimerHandler(e:flash.events.TimerEvent):void
		{
			soundAndMusicManager.title1_BGM.play();
			particleManager.createParticleAt("rainbowMagicPex","rainbowMagicPNG", 0, 700);
		}
		
		
		
		private function onTouch(event:TouchEvent):void
		{
			
			var touches:Vector.<Touch> = event.getTouches(stage);
			
			for each (var touch:Touch in touches)
			{
				touchX = touch.globalX;
				touchY = touch.globalY;
				
				if ( touch.phase == TouchPhase.BEGAN) //on touch
				{				
					//if(touchX <= hero.x)
					if(touchX <= valentinekitty.instance.deviceWidth/2)
					{
					//trace("left touched");
						moveDir=-1;
						hero.updateBehavior(moveDir);
					}
					else
					{
					//	trace("right touched");
						moveDir=1;
						hero.updateBehavior(moveDir);
					}
				}
				
				//else if ( touch.phase == TouchPhase.MOVED )
				//{
				
				//}
				else 				
				if ( touch.phase == TouchPhase.ENDED ) //on release
				{
					moveDir=0;
					hero.updateBehavior(moveDir);
				}
			}
			
		}
		
		private function updateMove():void
		{
			switch(moveDir)
			{
				case 1:					
					hero.x += walkSpeed;
					
				break;
				case -1:
					hero.x -= walkSpeed;
					break;
			}
			
		}
		
		
		public function putParticlesOnTop():void
		{
			//trace("putting on top");
			addChild(particleManager);
			
		}
		
		override public function update(tick:Number):void
		{
		
			super.update(tick);	
			
			if(hero) hero.checkArmatureUpdate();
			
			if(ready)
			{
			
				
				updateMove();
				
				if( hero.rotation <= -70 || hero.rotation >= 80 || hero.y > 1500)
				{
					gameOver(true);
				}				
				
				totalTime += tick;
				if (++frameCount % 60 == 0)
				{
					//trace("fps: " + frameCount / totalTime);
					frameCount = totalTime = 0;
				}
				
				if(gameGUI)
					gameGUI.update(tick);
				
				
			}
			
		}
		
		private function onKeyUp(e:KeyboardEvent):void
		{
			moveDir=0;
			hero.updateBehavior(moveDir);
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			if(e.keyCode == Keyboard.LEFT || e.keyCode == (Keyboard.A))
			{
				moveDir=-1;
				
				hero.updateBehavior(moveDir);
			}
			else
				if(e.keyCode == (Keyboard.RIGHT) || e.keyCode == (Keyboard.D))
				{
					moveDir= 1;
					hero.updateBehavior(moveDir);
				}
			/*
				if(_ce.input.isDown(Keyboard.LEFT) || _ce.input.isDown(Keyboard.A))
				{
					moveDir=-1;
					hero.updateBehavior(moveDir);
				}
				else
					if(_ce.input.isDown(Keyboard.RIGHT) || _ce.input.isDown(Keyboard.D))
					{
						moveDir= 1;
						hero.updateBehavior(moveDir);
					}
				*/
		}
		
		

		public function showSpendCoins():void
		{
			spendCoins.showView();
			addToScaleable(spendCoins.view);
			soundAndMusicManager.popIn_SFX.play();
		}
		
		public function removeSpendCoins():void
		{
			scaleableContent.removeChild(spendCoins.view);
			soundAndMusicManager.popOut_SFX.play();
		}
		
		
		//called from dangeritem
		public function hurtPlayer(in_damage:int):void
		{
			if(Math.random() >= .5)
				soundAndMusicManager.playerGotHit0_SFX.play();			
			else
				soundAndMusicManager.playerGotHit1_SFX.play();
			
			particleManager.createParticleAt("starExplosionPex","starExplosionPNG", valentinekitty.instance.tools.randRange(450,550) ,500,1);
			
			this.gameGUI.removeHearts(in_damage);
			
			isHurtThisSession = true; 
		}
		
		public function coinTouched(in_amount:int =1):void
		{						
			soundAndMusicManager.chaching_SFX.play();
			currentGameCoins +=in_amount;
			Game.getInstance().userProfile.totalCurrency +=in_amount;
			Game.getInstance().userProfile.coinsCollected += in_amount;
			
			if(Game.getInstance().userProfile.coinsCollected >= 100)
			{
					valentinekitty.instance.showMedalAt( 50, 200);					
					API.unlockMedal("The Collector");
					
			}
			
			if(Game.getInstance().userProfile.coinsCollected >= 1000)
			{
					valentinekitty.instance.showMedalAt( 50, 200);					
					API.unlockMedal("Teasure Hunter");
			}
			
			if(Game.getInstance().userProfile.coinsCollected >= 5000)
			{
					valentinekitty.instance.showMedalAt( 50, 200);	
					API.unlockMedal("The Pirate");				
				
			}
			
			if(currentGameCoins == 100 && currentRosesCollected <= 50)
			{
				valentinekitty.instance.showMedalAt( 50, 200);					
				API.unlockMedal("The Bandit");
			}
		
		}
		
		//called from rose
		public function roseTouched():void
		{
			gameGUI.addHeart();
			particleManager.createParticleAt("heartsPex","heartsPNG", valentinekitty.instance.tools.randRange(450,550) ,500,1);
			currentRosesCollected++;
			Game.getInstance().userProfile.totalRosesCollected ++;
			
			switch(Game.getInstance().userProfile.totalRosesCollected)
			{
				case 50:
					valentinekitty.instance.showMedalAt( 50, 200);				
					API.unlockMedal("The Romantic");
					break;
				case 300:
					valentinekitty.instance.showMedalAt( 50, 200);				
					API.unlockMedal("The Lover");
					break;
				case 1000:
					valentinekitty.instance.showMedalAt( 50, 200);					
					API.unlockMedal("The Fool");
					break;
			}
				
		}
		
		public function checkNinjaAward(in_level:int):void
		{
			if( in_level == 3 && !isHurtThisSession)
			{
				valentinekitty.instance.showMedalAt( 50, 200);					
				API.unlockMedal("The Ninja");
			}
		}
		
		public function addToScaleable(in_DO:DisplayObject):void
		{
			scaleableContent.addChild(in_DO);
			
			if(!valentinekitty.instance.isIpadRetina && !valentinekitty.instance.isNook && !valentinekitty.instance.isAmazon) //already has global scale
			{
				scaleableContent.scaleX = valentinekitty.instance.scaleFactor;
				scaleableContent.scaleY = valentinekitty.instance.scaleFactor;
				centerItem(scaleableContent);
			}
			
					
		}
		
		public function putScaleableContentOnTop():void
		{
			addChild(scaleableContent);
		}
		
		
		
		public function unCenter(in_DO:starling.display.DisplayObject):void
		{
			in_DO.x -= Math.abs(Constants.GameWidth - valentinekitty.instance.deviceWidth)/2;
			in_DO.y -= Math.abs(Constants.GameHeight- valentinekitty.instance.deviceHeight)/2;
		}
		
		public function centerItem(in_DO:starling.display.DisplayObject):void
		{
			in_DO.x = Math.abs(Constants.GameWidth - valentinekitty.instance.deviceWidth)/2;
			in_DO.y = Math.abs(Constants.GameHeight- valentinekitty.instance.deviceHeight)/2;
		}
		
		public function stopGame():void
		{
			ready = false;
		}
		
		
		public function gameOver(in_isFall:Boolean):void
		{
			stopGame();
			this.levelManager.cleanUp();
			this.backgroundManager.cleanUp();
			this.transitionManager.fadeIn(0xffffff,.05);
			
			soundAndMusicManager.stopAllBGM();
			
			if(gameGUI.isLevelTypeHappy)
			{
				soundAndMusicManager.title1_BGM.play();
			}
			else
				soundAndMusicManager.title2_BGM.play();
			
			valentinekitty.instance.tools.slide(gameOverMsg, 250, 250, 200, -400, 1, 3, "easeOut");
			addChild(gameOverMsg);
			
			if(in_isFall)
			{
				gameOverMsg.text = "You have fallen...";
				
			}
			else
			{
				gameOverMsg.text = "You were hit one too many times...";
			}
			
			this.gameGUI.cleanUp();
			
			showAdRestartGameDelay.reset();
			showAdRestartGameDelay.start();
			
			Game.getInstance().userProfile.life = Constants.lifeNormal; //resets hearts
			Game.getInstance().userProfile.hasGuitarUpgrade = false;
			
			
			
			showAdCounter++;
			if(	showAdCounter == 3)
			{
				showAdCounter=0;
				valentinekitty.instance.showAdAt(275, 320);
			}
			
			
			
			
		}
	
		private function showAdRestartGameDelayHandler(e:TimerEvent):void
		{
			
			this.itemGenerator.cleanUp();
			
			hero.visible = false;
			hero.destroy();
			hero = new CatHero("hero", {x:700, y:700});	
			hero.init();
		
			gameGUI.restartGUI();
			this.backgroundManager.addSpotLightAgain();
			particleManager.cleanUp();
			particleManager.createParticleAt("rainbowMagicPex","rainbowMagicPNG", 0, 700);
			
		}
		
		private function cheatCheckTimerHandler(e:TimerEvent):void
		{
			if(prevRoses + 100 < Game.getInstance().userProfile.totalRosesCollected || prevCoins+100 < Game.getInstance().userProfile.totalCurrency )
			{
				userProfile.isCheating = true;
				var cheatBtn:GlossyButton = new GlossyButton("rect", "Cheating detected.  Punish with ADS.",500,0xffffff,20,20);
				addChild(cheatBtn);
				valentinekitty.instance.showAdAt(200,200);
			}
			//trace(prevRoses + " "  +Game.getInstance().userProfile.totalRosesCollected);
			//trace(prevCoins + " "  +Game.getInstance().userProfile.totalCurrency);
			
			prevRoses = Game.getInstance().userProfile.totalRosesCollected;
			prevCoins = Game.getInstance().userProfile.totalCurrency;
		}
		
		
		public function facebookBtnClicked():void
		{
			navigateToURL(new URLRequest("http://www.facebook.com"), "_self");
		}
		
		public function twitterBtnClicked():void
		{
			navigateToURL(new URLRequest("http://www.twitter.com"), "_self");
		}
		
		
		public function openVitapolyWebview():void
		{
			navigateToURL(new URLRequest("http://www.vitapoly.com"), "_self");
		}

		
	}
}


