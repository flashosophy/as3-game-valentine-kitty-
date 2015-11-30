package com.vitapoly.valentinekitty.view
{
	import com.vitapoly.utils.GlossyButton;
	import com.vitapoly.valentinekitty.Constants;
	import com.vitapoly.valentinekitty.Game;
	import com.vitapoly.valentinekitty.Tools;
	import com.newgrounds.API;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	
	public class WallOfLove extends Sprite
	{
		
		private var i:int, pageIndex:int;
		private const pageLimit:int = 10;
		private var closeBtn:GlossyButton ,postBtn:GlossyButton, nextBtn:GlossyButton, prevBtn:GlossyButton, notEnoughRosesBtn:GlossyButton;
		private var tools:Tools;
		private var dataTxt:TextField;
		private var scrollBGImage:Image;
		private var faceBookBtn:Button,twitterBtn:Button, emailBtn:Button;
		private var dataObject:Object;
		private var errorMsgArr:Array;		
		private var submitPost:SubmitPost;
		public var keyboard:Keyboard;
		public var top10RoseNum:int;
		
		public function WallOfLove()
		{
			tools = new Tools;
			
		}
		
		public function init():void
		{
			
			scrollBGImage = new Image(Game.sAssets.getTexture("scrollBG"));

			pageIndex=0;				
			
			dataTxt = new TextField(700, 600, "", Constants.mainFont, 20, 0x663300, true);
			dataTxt.touchable = false;
			dataTxt.vAlign = "top";	dataTxt.hAlign = "left";
			
						
			postBtn = new GlossyButton("rect", "Post", 150,0xFFCCFF);
			nextBtn = new GlossyButton("rect", "Next", 150,0xfffffF);
			prevBtn = new GlossyButton("rect", "Prev", 150,0xfffffF);
			closeBtn = new GlossyButton("rect", "Close", 150,0xFF0000);
			
			faceBookBtn = new Button( Game.sAssets.getTexture("facebook" ) );
			twitterBtn = new Button( Game.sAssets.getTexture("twitter" ) );
			emailBtn = new Button( Game.sAssets.getTexture("email") );
			
			addChild(scrollBGImage);
			addChild(dataTxt);	
			addChild(postBtn);	
			addChild(nextBtn);	
			addChild(prevBtn);	
			addChild(closeBtn);	
			
			addChild(faceBookBtn);	
			addChild(twitterBtn);	
			//addChild(emailBtn);	
			
			
			errorMsgArr = new Array();
			
			keyboard = new Keyboard;
			submitPost = new SubmitPost;
			
			submitPost.init();
			keyboard.init();
			
			//for(i=0; i < 110; i++)
			//	updateGlobalStats(2,"empty", "empty", "empty");
			
		}
		
		public function scrollGUIIn():void
		{
			enableListeners();
			Game.getInstance().addChild(this);
			Game.instance.soundAndMusicManager.swooshIn_SFX.play();
			tools.slide(postBtn, -300, 20, 150,150,1,0,"easeOut");
			tools.slide(nextBtn, -300, 20, 275,275,1,.1,"easeOut");
			tools.slide(prevBtn, -300, 20, 375,375,1,.2,"easeOut");
			tools.slide(closeBtn, -300, 20, 515,515,1,.3,"easeOut");			
			tools.slide(scrollBGImage, valentinekitty.instance.deviceWidth, 0, -25,-25,1,0,"easeOut");
			tools.slide(dataTxt, 1500, 250, 15,15,1,0,"easeOut");
						
			tools.slide(faceBookBtn, 1500, valentinekitty.instance.deviceWidth - 80 , 200,300,1,0,"easeOut");
			tools.slide(twitterBtn, 1500, valentinekitty.instance.deviceWidth - 80 , 280,380,1,0,"easeOut");
			tools.slide(emailBtn, 1500, valentinekitty.instance.deviceWidth - 80 , 360,460,1,0,"easeOut");
						
			//reads the data and display the first ten
			getGlobalStats(
				function(obj:Object):void
				{			
					dataTxt.text = "Fetching Love Data...";
					dataObject = obj;
					readDataOnCurrentPage();					
				}
			);
			
		}
		
		public function scrollGUIOut():void
		{
			
			cleanUp();
			tools.slide(postBtn,20 , -300, 150,150,1,.3,"easeOut");
			tools.slide(nextBtn, -20, -300, 275,275,1,.2,"easeOut");
			tools.slide(prevBtn, -20, -300, 375,375,1,.1,"easeOut");
			tools.slide(closeBtn, -20, -300, 515,515,1,0,"easeOut");			
			tools.slide(scrollBGImage, 0, valentinekitty.instance.deviceWidth, -25,-25,1,0,"easeOut");
			tools.slide(dataTxt,250 ,1500 , 15,15,1,0,"easeOut");
			tools.slide(faceBookBtn,valentinekitty.instance.deviceWidth - 80 , 1500 , 200,300,1,0,"easeOut");
			tools.slide(twitterBtn,valentinekitty.instance.deviceWidth - 80, 1500, 280,380,1,0,"easeOut");
			tools.slide(emailBtn, valentinekitty.instance.deviceWidth - 80,1500, 360,460,1,0,"easeOut");
			
		}
		
		private function readDataOnCurrentPage():void
		{
			dataTxt.text ="";
			var startIndex:int;
			
			for(i=0; i < 10; i++)
			{
				startIndex  = pageIndex*10 + i;
				
				try{
					dataTxt.text += "From: " +  dataObject[startIndex].fromName + "      To: "+dataObject[startIndex].toName + "      Roses: " + dataObject[startIndex].comparator;
					dataTxt.text += "\n";
					dataTxt.text += "Message: " +  dataObject[startIndex].msg;
					dataTxt.text += "\n\n";
				}catch(e:Error){};
			}
			
		}
		
		public function updateGlobalStats(in_totalRoses:Number,  in_fromName:String, in_toName:String, in_msg:String):void
		{	
			var obj:Object = new Object();
			obj.bundleid = Config.APP_ID;	 // required
			obj.comparator = in_totalRoses;	 // required, only the top 100 will be stored
			obj.fromName = in_fromName;	 // as many as you want
			obj.toName = in_toName; // then you can store whatever you wants			
			obj.msg = in_msg;	 // as many as you want
				
			// the url, note that it passes a JSON string with a post var "data"
			var urlRequest:URLRequest=new URLRequest("http://apps.vitapoly.com/apps/scoreboard/customdata/put.php");
			urlRequest.method = URLRequestMethod.POST;
			var variables:URLVariables = new URLVariables();
			variables.data = JSON.stringify(obj);
			urlRequest.data = variables;
			
			// the usual
			var urlLoader:URLLoader=new URLLoader();
			urlLoader.dataFormat=URLLoaderDataFormat.TEXT;
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, function(e:flash.events.ErrorEvent):void{
				trace("error: " + e.errorID);
			});
			urlLoader.addEventListener(flash.events.Event.COMPLETE, function(e:flash.events.Event):void
			{
			//	trace("done: "+ e.target.data);
				getGlobalStats(
					function(obj:Object):void
					{			
						dataTxt.text = "Fetching Love Data...";
						dataObject = obj;
						readDataOnCurrentPage();					
					}
				);
			});
			
			urlLoader.load(urlRequest);
			
		}
		
		public function getGlobalStats(callback:Function):void
		{
			var obj:Object = new Object();
			obj.bundleid = Config.APP_ID;	 // REQUIRED
			
			var urlRequest:URLRequest=new URLRequest("http://apps.vitapoly.com/apps/scoreboard/customdata/get.php");
			urlRequest.method = URLRequestMethod.POST;
			var variables:URLVariables = new URLVariables();
			variables.data = JSON.stringify(obj);
			urlRequest.data = variables;
			
			var urlLoader:URLLoader=new URLLoader();
			urlLoader.dataFormat=URLLoaderDataFormat.TEXT;
			urlLoader.addEventListener(flash.events.Event.COMPLETE, function(e:flash.events.Event):void
			{
				try{
					//trace("data from database: " + e.target.data);
					callback(JSON.parse(e.target.data));
				} catch(e:Error)
				{
					trace(e.getStackTrace());
					dataTxt.text = "No internet connection detected.  Please connect to the web and try again~ ^_^";
					//trace("GlobalStats Error");
				}
				
			});
			
			urlLoader.load(urlRequest);		
		}
		
		private function btnPressedHandler(e:starling.events.Event):void
		{

			switch(e.target)
			{	
				case postBtn:
					
					//if can post, post
					if( Game.instance.userProfile.totalRosesCollected > dataObject[99].comparator)
					{
						Game.instance.soundAndMusicManager.popIn_SFX.play();
						addChild(submitPost.view);						
						addChild(keyboard.view);
						
						submitPost.show();
						keyboard.show();
						
						top10RoseNum = dataObject[9].comparator;
					}
					else
					{					
												
						notEnoughRosesBtn = new GlossyButton("long", "Sorry, you need more roses to be on the wall of love top 100.", 500);
						notEnoughRosesBtn.touchable = false;
						addChild(notEnoughRosesBtn);
						tools.slide(notEnoughRosesBtn, 250 , 250, 150,-500,1,5,"easeIn");//slide away
					
						Game.instance.soundAndMusicManager.error_SFX.play();
						errorMsgArr.push(notEnoughRosesBtn);
					}
					
					break;
				case nextBtn:
					pageIndex ++;
					if(pageIndex >= pageLimit)
					{
						pageIndex = pageLimit -1; // 9 should be max
					}
					readDataOnCurrentPage();
					
					break;
				case prevBtn:
					pageIndex --;
					nextBtn.visible = true;
					if(pageIndex <= 0 )
					{
						pageIndex=0;
					}
					readDataOnCurrentPage();
					
					break;					
				case closeBtn:
				
					
						//Ads.showFullScreenAd("main_menu");
					valentinekitty.instance.showAdAt(275, 320);
					scrollGUIOut();
					break;
				
				case faceBookBtn:
					Game.getInstance().facebookBtnClicked();
					break;				
				
				case twitterBtn:
					Game.getInstance().twitterBtnClicked();
					break;				
			
				
			}

		}
		
		public function cancelPost():void
		{
			keyboard.retract();
			Game.instance.soundAndMusicManager.popOut_SFX.play();
		}
		
		public function letterPressed(in_string:String):void
		{
			submitPost.enterLetter(in_string);
		}
		
		public function spacebarPressed():void
		{
			submitPost.enterSpacebar();
		}
		
		public function backspacePressed():void
		{
			submitPost.backspacePressed();
		}
		
		public function postMsg(in_from:String, in_to:String, in_msg:String):void
		{
			API.unlockMedal("Wall Of Love Silver");
			
			if(Game.getInstance().userProfile.totalRosesCollected > top10RoseNum)
			{
				valentinekitty.instance.showMedalAt( 50, 200);					
				API.unlockMedal("Wall Of Love Gold");
			}
				
				
				
			updateGlobalStats(Game.getInstance().userProfile.totalRosesCollected,in_from, in_to, in_msg);
			cancelPost();
			//all roses are now gone
			Game.getInstance().userProfile.totalRosesCollected = 0;
			Game.getInstance().gameSave.save();
			Game.getInstance().gameGUI.updateTitleRoseCoinsTxt();
		}
		
		private function enableListeners():void
		{
			
			if(postBtn) postBtn.addEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
			if(nextBtn)  nextBtn.addEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
			if(faceBookBtn) faceBookBtn.addEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);		
			if(prevBtn) prevBtn.addEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
			if(closeBtn) closeBtn.addEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
			if(twitterBtn) twitterBtn.addEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
			if(emailBtn) emailBtn.addEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
			
		}
		
		private function disableListeners():void
		{
			
			if(postBtn) postBtn.removeEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
			if(nextBtn) nextBtn.removeEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
			if(faceBookBtn) faceBookBtn.removeEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);		
			if(prevBtn) prevBtn.removeEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
			if(closeBtn) closeBtn.removeEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
			if(twitterBtn) twitterBtn.removeEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
			if(emailBtn) emailBtn.removeEventListener(starling.events.Event.TRIGGERED, btnPressedHandler);
			
		}
		
		private function cleanUp():void
		{
			var errorMsgLength:int = errorMsgArr.length;
			var tempBtn:GlossyButton;
			for(i=0; i < errorMsgLength; i++)
			{
				tempBtn = errorMsgArr.pop();				
				tempBtn.visible = false;
				tempBtn.dispose();
			}
			
			
			disableListeners();
		}
		
	}
}

