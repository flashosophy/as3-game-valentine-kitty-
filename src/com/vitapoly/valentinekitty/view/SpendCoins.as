package com.vitapoly.valentinekitty.view
{
	import com.vitapoly.utils.GlossyButton;
	import com.vitapoly.valentinekitty.Constants;
	import com.vitapoly.valentinekitty.Game;
	import com.newgrounds.API;
	import flash.display.BitmapData;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	public class SpendCoins extends Sprite
	{
		private const itemCost0:int = 150; //roses
		private const itemCost1:int = 200;
		private const itemCost2:int = 300;
		private const buyRoseAmount:int = 50;
		public var view:Sprite; 		
		private var i:int, totalCost:int;
		private var viewAdBtn:GlossyButton, closeBtn:GlossyButton;			
		private var profileImage:Image;
		private var instructionTxt:TextField, heartTotalTxt:TextField, catProfileText:TextField, itemTxt0:TextField, itemTxt1:TextField, itemTxt2:TextField,errorMsg:TextField;;
		private var item0Cost:TextField, item1Cost:TextField, item2Cost:TextField;
		private var ready:Boolean, hasEnoughCoins:Boolean;
		private var upgrade0Btn:GlossyButton, upgrade1Btn:GlossyButton, upgrade2Btn:GlossyButton,guiBG:GlossyButton;
		private var itemImage0:Image , itemImage1:Image , itemImage2:Image;
		private var blocker:Sprite;
		
		
		
		public function SpendCoins()
		{

		}
		
		public function init():void
		{	
			cleanUp();
			if(view)
				view.removeChildren();
			
			view = new Sprite();
			
			instructionTxt = new TextField(750, 50, "The Coins Store", Constants.mainFont, 25, 0x000000, true);
			catProfileText = new TextField(250, 150, "Name: Armastus\nAge: 1\nLikes: Music\nDislikes: Sharp Objects", Constants.mainFont, 30, 0x333333, true);
			//view.y += Game.instance.shiftUpOffset; //shoud be 0 unless amazon kindle or ratio 1.7+
			itemTxt0  = new TextField(150, 50, "50\nRoses", Constants.mainFont, 22, 0x0099FF, true);
			itemTxt1  = new TextField(150, 50, "Double\nLife", Constants.mainFont, 22, 0x0099FF, true);
			itemTxt2  = new TextField(150, 50, "Double\nRose Drop", Constants.mainFont, 22, 0x0099FF, true);
			
			
			errorMsg   = new TextField(450, 50, "", Constants.mainFont, 25, 0x990000, true);
			
			item0Cost  = new TextField(150, 40, itemCost0+" Coins", Constants.mainFont, 20, 0xFF9900, true);
			item1Cost  = new TextField(150, 40, itemCost1+" Coins", Constants.mainFont, 20, 0xFF9900, true);
			item2Cost  = new TextField(150, 40, itemCost2+" Coins", Constants.mainFont, 20, 0xFF9900, true);
			
			itemImage0= new Image( Game.sAssets.getTexture("itemImage0") );
			itemImage1 = new  Image( Game.sAssets.getTexture("itemImage1") );
			itemImage2 = new Image( Game.sAssets.getTexture("itemImage2") );
			
			
			guiBG = new GlossyButton("rect","", 750, 0xFFffff, 0,0,Constants.mainFont);
			//var guiBG:Image = new Image(Assets.getTextureAtlas("common").getTexture("btnrect") );;
			totalCost =0;
			hasEnoughCoins = false;
			guiBG.x = Constants.GameWidth/2 - guiBG.width/2 ;  guiBG.y = 70;  
			guiBG.touchable = false;
			instructionTxt.x = guiBG.x+50;   instructionTxt.y = guiBG.y + 15;   instructionTxt.vAlign = "top"; instructionTxt.hAlign ="left";
			
			profileImage = new Image(Game.sAssets.getTexture("portrait"));
			profileImage.x = instructionTxt.x; profileImage.y = guiBG.y + 50;
				
			catProfileText.x = profileImage.x,   catProfileText.y = profileImage.y + profileImage.height +10;   catProfileText.vAlign = "top"; catProfileText.hAlign ="left";
			

			upgrade0Btn = new GlossyButton("square", "", 150, 0xffffff, 340, 150);
			upgrade0Btn.addDO(itemImage0 , upgrade0Btn.width/2 - itemImage0.width/2, upgrade0Btn.height/2 - itemImage0.height/2);
			upgrade1Btn = new GlossyButton("square", "", 150, 0xffffff, 500, 150);
			upgrade1Btn.addDO(itemImage1 , upgrade0Btn.width/2 - itemImage1.width/2, upgrade0Btn.height/2 - itemImage1.height/2);
			upgrade2Btn = new GlossyButton("square", "", 150, 0xffffff, 660, 150);
			upgrade2Btn.addDO(itemImage2 , upgrade0Btn.width/2 - itemImage2.width/2, upgrade0Btn.height/2 - itemImage2.height/2);
			itemTxt0.x=  upgrade0Btn.x; itemTxt0.y = upgrade0Btn.y - 45;
			itemTxt1.x=  upgrade1Btn.x; itemTxt1.y = upgrade1Btn.y - 45;
			itemTxt2.x=  upgrade2Btn.x; itemTxt2.y = upgrade2Btn.y - 45;
			item0Cost.x=  upgrade0Btn.x; item0Cost.y = upgrade0Btn.y + upgrade0Btn.height - 30;
			item1Cost.x=  upgrade1Btn.x; item1Cost.y = upgrade1Btn.y + upgrade1Btn.height - 30;
			item2Cost.x=  upgrade2Btn.x; item2Cost.y = upgrade2Btn.y + upgrade2Btn.height - 30;
			errorMsg.x=  upgrade0Btn.x; errorMsg.y = upgrade0Btn.y + upgrade0Btn.height +20; errorMsg.vAlign = "top"; 
			
			viewAdBtn = new GlossyButton("rect", "View Ad\nGet 20 Coins", 150, 0xFFFF00, 670 ,400 );
			closeBtn= new GlossyButton("rect", "Close", 150, 0xffffff, 500 , 400);
			instructionTxt.color = 0xFF9900;
			
			
			blocker = new Sprite();
			blocker.addChild(new Image(Texture.fromBitmapData(new BitmapData(valentinekitty.instance.deviceWidth, valentinekitty.instance.deviceHeight,false,0x000000))));			
			blocker.touchable = false;
			blocker.alpha = .7;			

		}
						
		public function showView():void
		{			
			view.addChild(blocker);
			view.addChild(guiBG);
			view.addChild(instructionTxt);	
			view.addChild(catProfileText);
			view.addChild(profileImage);
			view.addChild(viewAdBtn);
			//view.addChild(playBtn);
			view.addChild(closeBtn);
			
			view.addChild(upgrade0Btn);
			view.addChild(upgrade1Btn);
			view.addChild(upgrade2Btn);
			view.addChild(itemTxt0);
			view.addChild(itemTxt1);
			view.addChild(itemTxt2);
			view.addChild(item0Cost);
			view.addChild(item1Cost);
			view.addChild(item2Cost);
			view.addChild(errorMsg);
			
			enableListeners();
		}
		
		private function btnPressedHandler(e:starling.events.Event):void
		{

			switch(e.target)
			{	
			
				case upgrade0Btn: 
					if(Game.getInstance().userProfile.totalCurrency < itemCost0)
					{
						errorMsg.text = "Not enough coins.\nYou currently have : " + Game.getInstance().userProfile.totalCurrency + " coins";
						Game.instance.soundAndMusicManager.error_SFX.play();
					}
					else
					{
						Game.getInstance().userProfile.totalCurrency  -= itemCost0;
						Game.getInstance().userProfile.totalRosesCollected += buyRoseAmount;
						Game.instance.soundAndMusicManager.chaching_SFX.play();
						Game.instance.userProfile.totalCoinsSpent += itemCost0;
					}
						
					break;
				case upgrade1Btn: 
					if(Game.getInstance().userProfile.totalCurrency < itemCost1)
					{
						errorMsg.text = "Not enough coins.\nYou currently have : " + Game.getInstance().userProfile.totalCurrency + " coins";
						Game.instance.soundAndMusicManager.error_SFX.play();
					}
					else
					{
						Game.getInstance().userProfile.totalCurrency  -= itemCost1;
						Game.getInstance().userProfile.life = Constants.lifeUpgrade;
						Game.instance.soundAndMusicManager.chaching_SFX.play();
						Game.getInstance().gameGUI.refreshHearts();	
						Game.instance.userProfile.totalCoinsSpent += itemCost1;
					}
					break;
				case upgrade2Btn: 
					if(Game.getInstance().userProfile.totalCurrency < itemCost2)
					{
						errorMsg.text = "Not enough coins.\nYou currently have : " + Game.getInstance().userProfile.totalCurrency + " coins";
						Game.instance.soundAndMusicManager.error_SFX.play();
						
					}
					else
					{
						Game.getInstance().userProfile.totalCurrency  -= itemCost2;
						Game.instance.soundAndMusicManager.chaching_SFX.play();
						Game.getInstance().hero.guitarUpgrade();
						Game.getInstance().userProfile.hasGuitarUpgrade = true;
						Game.instance.userProfile.totalCoinsSpent += itemCost2;
					}
					break;
				
				case viewAdBtn:
					//Game.getInstance().showStore();
					valentinekitty.instance.showAdAt(55, 340);
					viewAdBtn.visible = false;
					Game.instance.coinTouched(20);
					break;
				case closeBtn:	
					viewAdBtn.visible = true;
					Game.getInstance().removeSpendCoins();
					valentinekitty.instance.removeAd();
					break;
				
				
			}
			Game.getInstance().gameGUI.updateTitleRoseCoinsTxt();	
			Game.getInstance().gameSave.save();
			
			if(Game.instance.userProfile.totalCoinsSpent >= 10000)
			{
				valentinekitty.instance.showMedalAt( 50, 200);					
				API.unlockMedal("Shopaholic");
			}
		}
		
	
		
		private function enableListeners():void
		{
			
			if(upgrade0Btn) upgrade0Btn.addEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
			if(upgrade1Btn) upgrade1Btn.addEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
			if(upgrade2Btn) upgrade2Btn.addEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
			if(viewAdBtn) viewAdBtn.addEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
			if(closeBtn) closeBtn.addEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
			
		}
		
		private function disableListeners():void
		{
				
			if(upgrade0Btn) upgrade0Btn.removeEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
			if(upgrade1Btn) upgrade1Btn.removeEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
			if(upgrade2Btn) upgrade2Btn.removeEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
			if(viewAdBtn) viewAdBtn.removeEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
			if(closeBtn) closeBtn.removeEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
			
		}
		
		public function cleanUp():void
		{
			disableListeners();
		}
		
	}
}

