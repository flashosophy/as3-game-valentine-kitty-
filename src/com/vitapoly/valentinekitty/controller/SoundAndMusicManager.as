package com.vitapoly.valentinekitty.controller
{
	import com.vitapoly.utils.Tools;
	import com.vitapoly.valentinekitty.Game;
	import com.vitapoly.valentinekitty.model.BGM;
	import com.vitapoly.valentinekitty.model.SFX;
	
	import flash.media.Sound;
	
	public class SoundAndMusicManager
	{
		private var tools:Tools = new Tools();
		public var currentBGM:BGM;
		
		//player SFX
		public var currentSFX:SFX;
		
		//BGM
		public var happy_BGM:BGM = new BGM;
		public var sad_BGM:BGM = new BGM;
		public var title1_BGM:BGM = new BGM;
		public var title2_BGM:BGM = new BGM;
		
		
		//SFX interface
		public var lightOn_SFX:SFX = new SFX;
		public var hearts_SFX:SFX = new SFX;		
		public var playerGotHit0_SFX:SFX = new SFX;	
		public var playerGotHit1_SFX:SFX = new SFX;	
		public var chaching_SFX:SFX = new SFX;
		public var swooshIn_SFX:SFX = new SFX;
		public var stars_SFX:SFX = new SFX;		
		public var land0_SFX:SFX = new SFX;
		public var land1_SFX:SFX = new SFX;		
		public var error_SFX:SFX = new SFX;
		public var popIn_SFX:SFX = new SFX;
		public var popOut_SFX:SFX = new SFX;
		public var coinLand_SFX:SFX = new SFX;
	
		
		public function SoundAndMusicManager()
		{ 
			//BGM
			happy_BGM.loadSound(Game.sAssets.getSound("happy") ); //during game music
			sad_BGM.loadSound(Game.sAssets.getSound("sad")  ); //game end music
			title1_BGM.loadSound(Game.sAssets.getSound("title1")  ); 
			title2_BGM.loadSound(Game.sAssets.getSound("title2")  ); 
			
			
			//SFX
			lightOn_SFX.loadSound(Game.sAssets.getSound("lightOn")  );
			hearts_SFX.loadSound(Game.sAssets.getSound("hearts") );
			playerGotHit0_SFX.loadSound(Game.sAssets.getSound("playerGotHit0")  );
			playerGotHit1_SFX.loadSound(Game.sAssets.getSound("playerGotHit1")  );
			chaching_SFX.loadSound(Game.sAssets.getSound("chaching")  );
			swooshIn_SFX.loadSound(Game.sAssets.getSound("swooshIn"));
			stars_SFX.loadSound(Game.sAssets.getSound("stars") );
			land0_SFX.loadSound(Game.sAssets.getSound("land0") );
			land1_SFX.loadSound(Game.sAssets.getSound("land1") );
			error_SFX.loadSound(Game.sAssets.getSound("error") );
			popIn_SFX.loadSound(Game.sAssets.getSound("popIn") );
			popOut_SFX.loadSound(Game.sAssets.getSound("popOut")  );
			coinLand_SFX.loadSound(Game.sAssets.getSound("coinLand")  );
			
			
			
		};
		
		
		public function stopAllBGM():void
		{		
			happy_BGM.stopBGMImmediate();
			sad_BGM.stopBGMImmediate();
			title1_BGM.stopBGMImmediate();
			title2_BGM.stopBGMImmediate();
			
			
		}
			
	}//end class
}


