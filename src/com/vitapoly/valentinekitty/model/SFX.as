package com.vitapoly.valentinekitty.model
{

   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.net.URLRequest;

   public class SFX
   {
      private var gameSFX :Sound;
      private var bgChannel:SoundChannel;
      private var bgTransform:SoundTransform;
      private var sdVolume:int = 1;
      private var sdVolMax:int = 1;

      public function SFX()
	  {
		  gameSFX = new Sound();
	  }

		public function load(in_str:String):void
		{
			gameSFX = new Sound();
			gameSFX.load(new URLRequest(in_str));
		}
		
		public function loadSound(in_sd:Sound):void
		{
			gameSFX = in_sd;
		}
		
      public function stop():void
      {
         try{bgChannel.stop();}catch(e:Error){};
      }
 
     
      public function play():void
      {
	  	
	        if(bgChannel != null)
	           bgChannel.stop();
	        
	        bgChannel = gameSFX.play();
	        bgTransform= bgChannel.soundTransform;
	        sdVolume=sdVolMax;
	        bgTransform.volume = sdVolume;
	        bgChannel.soundTransform = bgTransform;
         
      }
      
      
   }//end class
}