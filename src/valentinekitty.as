package
{
	import com.newgrounds.components.FlashAd;
	import com.newgrounds.components.MedalPopup;
	import com.vitapoly.utils.ProgressBar;
	import com.vitapoly.valentinekitty.Constants;
	import com.vitapoly.valentinekitty.Game;
	import com.vitapoly.valentinekitty.Tools;
	
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.media.SoundMixer;
	
	import citrus.core.starling.StarlingCitrusEngine;
	
	import starling.core.Starling;
	import starling.events.Event;
	import starling.utils.AssetManager;
	import starling.utils.Color;
	
	//[SWF(width = "900", height = "600", frameRate = "60", backgroundColor="#ffffff")]
	
	public class valentinekitty extends StarlingCitrusEngine
	{
		[Embed(source = "/embeddedassets/startup.jpg")]
		private var Background:Class;
		
		public static var instance:valentinekitty = null;	
		public var isIpadRetina:Boolean, isNook:Boolean, isAmazon:Boolean;
		private var loadScreenImage:Bitmap;
		public var tools:Tools;
		public var deviceWidth:int, deviceHeight:int;
		public var scaleFactor:Number;
		public var xDiff:int;
		public var yDiff:int;
		public var assets:AssetManager;
		private var mLoadingProgress:ProgressBar;
		private var game:Game;
		
		//new grounds stuff;
		public var flashAd:FlashAd;
		public var medalPopup:MedalPopup;
		
		//preloader stuff
		private var mProgressIndicator:Shape;
		private var mFrameCount:int = 0;
	
		public function valentinekitty()			
		{
			addEventListener(flash.events.Event.ADDED_TO_STAGE, onAddedToStage);
			super();

		}
		
		private function onAddedToStage(event:flash.events.Event):void 
		{
			// support autoOrients
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			stage.align = StageAlign.TOP_LEFT;
			
			instance = this;
			tools = new Tools;
			loadScreenImage = new Background;//new AssetEmbeds["loadScreen"];
			
			addEventListener(flash.events.Event.ENTER_FRAME, onEnterFrame);
						
			//API.addEventListener(APIEvent.API_CONNECTED, adsReadyHandler);
			
			addChild(loadScreenImage);
						
			deviceWidth = Constants.GameWidth//this.stage.fullScreenWidth			
			deviceHeight = Constants.GameHeight//this.stage.fullScreenHeight;
			
			scaleFactor = 1;
			
			setUpStarling(false, 0, new Rectangle(0,0,deviceWidth, deviceHeight));			
			_starling.addEventListener(starling.events.Event.ROOT_CREATED, onRootCreated);
			xDiff = Math.abs(Constants.GameWidth - valentinekitty.instance.deviceWidth)/2;
			yDiff = Math.abs(Constants.GameHeight- valentinekitty.instance.deviceHeight)/2;
			
			removeEventListener(flash.events.Event.ADDED_TO_STAGE, onAddedToStage);
			
		}
		
		private function onRootCreated(event:starling.events.Event):void
		{
			// set framerate to 30 in software mode
			if (_starling.context.driverInfo.toLowerCase().indexOf("software") != -1)
				_starling.nativeStage.frameRate = 30;
			
			// define which resources to load
			assets = new AssetManager();
			//assets.verbose = Capabilities.isDebugger;
			assets.enqueue(EmbeddedAssets);
						
			//showAdAt(50, 250);
			
			game = new Game();
			game.start(assets);
			
			
		}
	
		
		private function onEnterFrame(event:flash.events.Event):void 
		{
			var bytesLoaded:int = root.loaderInfo.bytesLoaded;
			var bytesTotal:int  = root.loaderInfo.bytesTotal;
			
			if (bytesLoaded >= bytesTotal)
			{
				dispose();
				run();
			}
			else
			{
				if (mProgressIndicator == null)
				{
										
					mProgressIndicator = createProgressIndicator();
					mProgressIndicator.x = stage.stageWidth  / 2;
					mProgressIndicator.y = stage.stageHeight / 2;
					addChild(mProgressIndicator);
				}
				else
				{
					if (mFrameCount++ % 5 == 0)
					{
						mProgressIndicator.rotation += 45;
					}
				}
			}
		}
		
		private function createProgressIndicator(radius:Number=12, elements:int=8):Shape
		{
			var shape:Shape = new Shape();
			var angleDelta:Number = Math.PI * 2 / elements;
			var x:Number, y:Number;
			var innerRadius:Number = radius / 4;
			var color:uint;
			
			for (var i:int=0; i<elements; ++i)
			{
				x = Math.cos(angleDelta * i) * radius;
				y = Math.sin(angleDelta * i) * radius;
				color = (i+1) / elements * 255;
				
				shape.graphics.beginFill(Color.rgb(color, color, color));
				shape.graphics.drawCircle(x, y, innerRadius);
				shape.graphics.endFill();
			}
			
			return shape;
		}
		
		private function dispose():void 
		{
			removeEventListener(flash.events.Event.ENTER_FRAME, onEnterFrame);
			
			if (mProgressIndicator)
				removeChild(mProgressIndicator);
			
			mProgressIndicator = null;
		
		}
		
		private function run():void 
		{
			SoundMixer.stopAll(); 
			nextFrame();
			state =game;
		}
		
		
		public function removeLoadScreen():void
		{
			removeChild(loadScreenImage);

		}
		
		public function showAdAt(in_x:int, in_y:int, in_type:String="NG"):void
		{
			
			if(in_type == "NG")
			{
				flashAd = new FlashAd();			
				flashAd.x = in_x;
				flashAd.y = in_y;	
				//flashAd.adType = "Simple";
				
				Starling.current.nativeOverlay.addChild(flashAd);
			}
		}
		
		public function removeAd(in_type:String = "NG"):void
		{
			if(in_type == "NG" && flashAd)
			{
				//API.disconnect();
				
				try{flashAd.removeAd();
					Starling.current.nativeOverlay.removeChild(flashAd);}catch(e:Error){};
				
			}
		}
		
		
		public function showMedalAt(in_x:int, in_y:int):void
		{
			medalPopup = new MedalPopup;
			medalPopup.x = in_x;
			medalPopup.y = in_y;
			Starling.current.nativeOverlay.addChild(medalPopup);
		}
		
		
		public function removeMedal():void
		{
			Starling.current.nativeOverlay.removeChild(medalPopup);
		}
		
		public function changeStateTo(in_str:String):void
		{
			
		}
		

		
	}
}







