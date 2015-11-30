package com.vitapoly.features
{
	import com.vitapoly.utils.UUID;
	
	public class UserProfile {
		public var id:String = null;
	
		public var isCheating:Boolean = false;
		
		public var life:int = 3; //starts with 3 hearts
		
		public var hasGuitarUpgrade:Boolean = false;
		public var premium:Boolean = false; 

		public var totalRosesCollected:int =0;
		
		public var clickedAwayTutorial:Boolean = false;
		
		public var totalCoinsSpent:int=0;
		
		public var totalCurrency:Number = 0;   
		public var coinsCollected:Number =0;
		
		public var gameCenterId:String = "";
		public var notificationId:String = "";

		public var appVersion:String = Config.VERSION;
		public var version:Number = 0.1;
		
		private var i:int;
		
		public var lastSaveTime:Number = 0;
		
		public var progress:Object;
		public var stats:Object;
		
		
		public var levelsCompleted:Array = new Array();
		public var achievementList:Array = new Array();
		public var achievements:Object = new Object();
		
		public var appExitedGracefully:Boolean = true;
		
		public var launches:Array = new Array();
		public var crashCount:int = 0;
		
		public var isMusicOn:Boolean = true; //on by default
	
		public function UserProfile() {		
			
			id = UUID.createUUID(); // using the one in util
			
/*			if (DEFINE::WEB && Main.CONFIG.WEB_FB) {
				id = Main.instance.FACEBOOK_WEB.id;
			}
*/
			initStats();
			initProgress();	
			
			if (Config.PREMIUM)
				premium = true;
		}
		
		public function toggleMusic():void
		{
			isMusicOn = !isMusicOn;
		}
		
		// track launches and sessions
		public function onLaunch(isLaunch:Boolean):void {
			
			var lastLaunchTime:Date = new Date();
			var launch:Object = {
				launchTime: lastLaunchTime,
				lastUpdateTime: lastLaunchTime,
				sessionTime: 0
			};
			launches.push(launch);
			
			var firstLaunchTime:Date = launches[0].launchTime;			
			
		}
		
		public function updateSession():void 
		{
			try{
			launches[launches.length-1].lastUpdateTime = new Date();
			launches[launches.length-1].sessionTime = (launches[launches.length-1].lastUpdateTime.time - launches[launches.length-1].launchTime.time) / 1000 / 60;
			}catch(e:Error){};
		}
		
		public function onSuspend():void {
			
		}
		
		public function onCrashEarlier():void {
			
			crashCount++;
			
		}
		
		public function get launchCount():int {
			return launches.length;
		}
		
		
		public function initStats():void
		{
			stats = new Object();
			stats.totalPlayTime = 0;
		}
				
		public function initProgress():void
		{
			progress = new Object();
		}

		//false is returned when not enough cash so it won't show hints
		public function substractCurrency(in_payment:Number):Boolean
		{
			if(in_payment > this.totalCurrency)
			{	
				//opens up store cause not enough cash
				
				return false;
			}
			else
			{
				this.totalCurrency -= in_payment;
				return true;
			}
		}

		public function merge(oldUserProfile:Object):void
		{			
			try{
				this.id = oldUserProfile.id; // reuse the same id
				
				var i:uint, j:uint;
				
				// merge stats
				if ( (oldUserProfile.stats as Object) != null )
				{
					for (var key:String in oldUserProfile.stats)
					{
						if (this.stats[key] != undefined )
						{
							this.stats[key] = oldUserProfile.stats[key];
						}
					}
				}
				
								
			} catch(e:Error)
			{
			}
			
		}
		
	}
}


