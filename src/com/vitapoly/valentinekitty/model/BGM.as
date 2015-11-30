package com.vitapoly.valentinekitty.model
{
   import flash.events.*;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.net.URLRequest;
   import flash.utils.Timer;
   
   public class BGM
   {
      private var gameBGM:Sound;
      private var bgChannel:SoundChannel;
      private var bgTransform:SoundTransform;
      private var sdVolume:Number =.7;
      private var sdVolMax:Number =.7;     
      private var fadeTimer:Timer = new Timer(200,10);
      
		public function load(in_str:String):void
		{
			gameBGM = new Sound();
			gameBGM.load(new URLRequest(in_str));
		}
		
		public function loadSound(in_sd:Sound):void
		{
			gameBGM = in_sd;
		}
		

		
      public function stopBGMImmediate():void
      {

         try{bgChannel.stop();
         	fadeTimer.removeEventListener("timer", soundFadeOut);
         }catch(e:Error){}
		 
      }
      
      //ellegantly fade out music
 	  public function stopBGM():void
      {
           sdVolume=sdVolMax;
           fadeTimer.addEventListener("timer", soundFadeOut);
           fadeTimer.start();
		   
      }
      
      public function play():void
      {
         if(bgChannel != null)
            bgChannel.stop();

        //  if(Main.instance.gameOptions.musicOn)
          {
            //no fadeIn cause music already sorts of does that
            bgChannel = gameBGM.play();
            bgChannel.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
          
            bgTransform= bgChannel.soundTransform;
            sdVolume=sdVolMax;
            bgTransform.volume = sdVolume;
            bgChannel.soundTransform = bgTransform;
              
         }
      }
      
      //loops
      public function soundCompleteHandler(e:Event):void
      {
		  play();
      }
      
      public function soundFadeOut(e:Event):void
      {
		  //crashes
		  
         if(sdVolume > 0)
         {
               bgTransform.volume = sdVolume;
               bgChannel.soundTransform = bgTransform;
               sdVolume -=.1;
         }
         else
         {
               sdVolume=sdVolMax;
               bgChannel.stop();
               fadeTimer.removeEventListener("timer", soundFadeOut);
         }
		 
      }
           
      
   }//end class
}