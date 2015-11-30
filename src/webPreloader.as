package 
{
	import com.newgrounds.API;
	import com.newgrounds.components.FlashAd;
	
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.media.SoundMixer;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.getDefinitionByName;
	
	import starling.utils.Color;
	
	// To show a Preloader while the SWF is being transferred from the server, 
	// set this class as your 'default application' and add the following 
	// compiler argument: '-frame StartupFrame cutecatgames'
	
	// [SWF(width="960", height="640", frameRate="60", backgroundColor="#4A901C")]
	[SWF(width="900", height="600", frameRate="60", backgroundColor="#ffffff")] //newgrounds max width is 942
	public class webPreloader extends MovieClip
	{
		private const STARTUP_CLASS:String = "valentinekitty";
		private var _mochiads_game_id:String = "6fdcc60d56ee4786";
		private var mProgressIndicator:Shape;
		private var mFrameCount:int = 0;
		private var flashAd:FlashAd;
		private var loadingText:TextField, titleTxt:TextField;
		private var circ:Shape=new Shape();
		
		public function webPreloader()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stop();
		}
		
		private function onAddedToStage(event:Event):void 
		{
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			stage.align = StageAlign.TOP_LEFT;
			createGradBG();
			createLoadingTextField();
			
			API.connect(stage, "30632:D7yxh6ke", "lJCqKOWhcIvfcgGXM0SFKqyRix8IQmZ3");
			/*
			flashAd = new FlashAd();
			flashAd.x = 50, flashAd.y = 250;
			addChild( flashAd);		
			*/
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onEnterFrame(event:Event):void 
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
					loadingText.text = "Downloading...   " + int(bytesLoaded/bytesTotal*100) +"%\n\n"+int(bytesLoaded/1000) +"KB / " + int(bytesTotal/1000)+ "KB" ;
					if (mFrameCount++ % 5 == 0)
						mProgressIndicator.rotation += 45;
				}
			}
		}
		
		private function createProgressIndicator(radius:Number=25, elements:int=8):Shape
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
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			removeChild(loadingText);
			removeChild(titleTxt);
			removeChild(circ);
			
			if (mProgressIndicator)
				removeChild(mProgressIndicator);
			
			mProgressIndicator = null;
			
			try{
				flashAd.removeAd();
				//API.disconnect();
				removeChild( flashAd);	}catch(e:Error){}
			
			SoundMixer.stopAll(); 
			
		}
		
		private function run():void 
		{
			nextFrame();
			
			var startupClass:Class = getDefinitionByName(STARTUP_CLASS) as Class;
			if (startupClass == null)
				throw new Error("Invalid Startup class in Preloader: " + STARTUP_CLASS);
			
			var startupObject:DisplayObject = new startupClass() as DisplayObject;
			if (startupObject == null)
				throw new Error("Startup class needs to inherit from Sprite or MovieClip.");
			
			addChildAt(startupObject, 0);
		}
		
		private function createGradBG():void
		{
			
			circ.x = stage.stageWidth  / 2;
			circ.y = stage.stageHeight / 2;
			var circRad:Number=600;
			
			var mat:Matrix;
			var colors:Array;
			var alphas:Array;
			var ratios:Array;
			mat= new Matrix();
			colors=[0xffffff,0xFFFFCC];
			alphas=[1,1];
			ratios=[0,255];
			mat.createGradientBox(2*circRad,2*circRad,0,-circRad,-circRad);
			circ.graphics.lineStyle();
			circ.graphics.beginGradientFill(GradientType.RADIAL,colors,alphas,ratios,mat);
			circ.graphics.drawCircle(0,0,circRad);
			circ.graphics.endFill();
			addChild(circ);
		}
		
		private function createLoadingTextField():void
		{
			var format:TextFormat = new TextFormat();
			var format2:TextFormat = new TextFormat();
			
			loadingText = new TextField();
			format.font = "verdana";
			format.size = 18;
			format.color = 0x333333;
			loadingText.selectable = false;			
			loadingText.autoSize = TextFieldAutoSize.LEFT;
			loadingText.defaultTextFormat = format;      
			loadingText.x =  stage.stageWidth / 2 + 150;
			loadingText.y = stage.stageHeight / 2 - 25;
			
			titleTxt = new TextField();
			format2.font = "verdana";
			format2.size = 50;
			format2.color = 0x333333;			
			titleTxt.autoSize = TextFieldAutoSize.CENTER;
			titleTxt.defaultTextFormat = format2;      
			titleTxt.x =  stage.stageWidth / 2 ;
			titleTxt.y = 50;
			titleTxt.text = "CuteCatGames.com";
			
			addChild(loadingText);
			addChild(titleTxt);
			
			
		}
		
	}
}

