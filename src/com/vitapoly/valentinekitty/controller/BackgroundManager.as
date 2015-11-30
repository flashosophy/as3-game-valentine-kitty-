package com.vitapoly.valentinekitty.controller
{
	import com.vitapoly.valentinekitty.Game;
	import com.vitapoly.valentinekitty.Tools;
	
	import citrus.objects.CitrusSprite;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.textures.Texture;
	
	public class BackgroundManager
	{
		private var bgQuad:Quad = new Quad(1600,1000,0x000000);
		private var tools:Tools;
		private var beachBGSprite:CitrusSprite,plamTreeSprite:CitrusSprite,sadBGSprite:CitrusSprite ,spotLightSprite:CitrusSprite,leftPitArrow:CitrusSprite , rightPitArrow:CitrusSprite  ;		
		private var spotLightImage:Image, palmTreeImage:Image, beachBGImage:Image, sadBGImage:Image;
		private var moneyArrow0:Image,moneyArrow1:Image;
		
		public function BackgroundManager()
		{
			tools = new Tools;
		}
		
		public function init():void
		{			
			var bottomColor:uint = 0x000000; 
			var topColor:uint    = 0x333333; 
			
			bgQuad.setVertexColor(0, topColor);
			bgQuad.setVertexColor(1, topColor);
			bgQuad.setVertexColor(2, bottomColor);
			bgQuad.setVertexColor(3, bottomColor)
				
			var blackBG:CitrusSprite = new CitrusSprite("blackBG", {view:bgQuad}); 
			Game.getInstance().add(blackBG); //black bg
			blackBG.x -= 200;
			
			spotLightSprite = new CitrusSprite("spotLight");
			beachBGSprite = new CitrusSprite("beachBGSprite");	
			plamTreeSprite = new CitrusSprite("plamTreeSprite");	
			sadBGSprite = new CitrusSprite("sadBGSprite");	
				
			spotLightImage= new Image( Game.sAssets.getTexture("spotLight") );					
			spotLightImage.scaleX *= 2;
			spotLightImage.scaleY *= 2.5;
			
			palmTreeImage= new Image( Game.sAssets.getTexture("palmTree" ) );			
			beachBGImage = new Image( Game.sAssets.getTexture("beachGameBackground" ) );
			sadBGImage = new Image(Game.sAssets.getTexture("gamebackground"));	
			
			moneyArrow0 = new Image( Game.sAssets.getTexture("moneyArrow"));
			moneyArrow1 = new Image( Game.sAssets.getTexture("moneyArrow"));	
			leftPitArrow = new CitrusSprite("leftPitArrow");
			rightPitArrow = new CitrusSprite("rightPitArrow");
		}
		
		public function setColor(in_color:uint):void
		{
			bgQuad.setVertexColor(0, in_color); //converts quad back to black
			bgQuad.setVertexColor(1, in_color);
			bgQuad.setVertexColor(2, in_color);
			bgQuad.setVertexColor(3, in_color);
		}
		
		public function showSpotLight():void
		{			
			spotLightSprite.view = spotLightImage;				
			spotLightSprite.x = Game.getInstance().hero.x - spotLightImage.width/2;
			spotLightSprite.y = Game.getInstance().hero.y - spotLightImage.height/2;
			Game.getInstance().add(spotLightSprite);
			
		}
		
		public function addSpotLightAgain():void
		{
			spotLightSprite.visible = true;
			Game.getInstance().add(spotLightSprite);
		}
		
		
		public function createSadBackground():void
		{
			sadBGSprite.visible = true;
			sadBGSprite.x =0;
			sadBGSprite.y =400;			
			sadBGSprite.view = sadBGImage;	
			
			leftPitArrow.view = moneyArrow0;  leftPitArrow.x =-200;   leftPitArrow.y = 960;
			rightPitArrow.view = moneyArrow1;  rightPitArrow.x = 1200; rightPitArrow.y = 960; 
		
			Game.getInstance().add(sadBGSprite);
			Game.getInstance().add(leftPitArrow);
			Game.getInstance().add(rightPitArrow);
		}
		
		
		public function createHappyBackground():void
		{
			beachBGSprite.view = beachBGImage;// Game.sAssets.getTexture(["blueSky"];					
			beachBGSprite.x =-200;
			beachBGSprite.y =400;
			//beachBGSprite.parallax = 1;
			beachBGSprite.visible = true;
											
			plamTreeSprite.view = palmTreeImage;				
			plamTreeSprite.x =1200;
			plamTreeSprite.y =500;
			plamTreeSprite.parallax = 1.3;
			plamTreeSprite.visible = true;
			
			Game.getInstance().add(beachBGSprite);
			Game.getInstance().add(plamTreeSprite);
			
			leftPitArrow.view = moneyArrow0;  leftPitArrow.x =-200;   leftPitArrow.y = 960;
			rightPitArrow.view = moneyArrow1; rightPitArrow.x = 1200; rightPitArrow.y = 960; 
			Game.getInstance().add(leftPitArrow);
			Game.getInstance().add(rightPitArrow);
			
			if(valentinekitty.instance.isIpadRetina)
			{
				plamTreeSprite.y =275;
			}
		}

		public function cleanUp():void
		{
			beachBGSprite.visible = false;
			plamTreeSprite.visible = false;
			sadBGSprite.visible = false;
			spotLightSprite.visible = false;
		}
	}//end class
}

