package com.vitapoly.features
{
	import flash.net.SharedObject;
	
	public class GenericGameSave
	{
		public var so:SharedObject;
		/*
		DEFINE::IOS
		{
		private var iCloud:iCloudANE = null;
		}*/
		public function GenericGameSave(id:String)
		{
			so = SharedObject.getLocal(id);
			/*DEFINE::IOS
			{
				iCloud = new iCloudANE();
			}*/
		}

		public  function clear():void
		{
			so.clear();
			flush();
			
		}
		public function flush():void
		{
			
				so.flush();
		
		}
		/*
		public function isNewerSaveExist():Boolean
		{
			DEFINE::IOS
			{
				if (!Config.DEVICE)
					return false;
				
				return isiCloudSaveNewer();
			}
			
			return false;
		}
		
		protected function isiCloudSaveNewer():Boolean
		{ 
			DEFINE::IOS
			{			
				try{
					if (!Config.DEVICE)
						return false;
					
					var iCloudSave:String = iCloud.getStringForKey("save");
					if ( iCloudSave == null )
						return false;
					
					var iCloudJSON:Object = JSON.parse(iCloudSave);
					if ( iCloudJSON.lastSaveTime == undefined )
						return false;
					
					if ( iCloudJSON.lastSaveTime <= so.data.lastSaveTime )
						return false;
					else
						return true;
					
				} catch(e:Error)
				{
					return false;
				}
			}			
			return false;
		}		
		
		
		public function restore():void
		{
			DEFINE::IOS
			{
				if (Config.DEVICE)
					restoreFromiCloud();
			}
		}*/
		
		public function init():void
		{			
			so.data.lastSaveTime = (so.data.lastSaveTime != undefined) ? so.data.lastSaveTime : 0;
			so.data.launchCount = (so.data.launchCount != undefined) ? so.data.launchCount : 0;
			so.data.never_show_rated = (so.data.never_show_rated != undefined) ? so.data.never_show_rated : false;
			so.data.rated = (so.data.rated != undefined) ? so.data.rated : false;

		}
		
		public function save():void
		{
			so.data.lastSaveTime = new Date().time;

			/*
			if (DEFINE::IOS && Config.DEVICE )
			{
				// check cloud before allowing to save
				if ( isiCloudSaveNewer() )
				{
					// prompt to overwrite
					com.vitapoly.features.Alert.show( "A newer save is found on iCloud, restore it?" , "Restore from iCloud?" , "Yes" , "No" ,
						function(event:NativeDialogEvent):void{
							if ( event.index == "0")
							{
								if ( restoreFromiCloud() )
									return;
							}
						}
					);
				}				
			}*/
		}
		/*
		protected function saveToiCloud():void
		{	
			DEFINE::IOS
			{
				if (iCloud && Config.DEVICE)
					iCloud.store("save", JSON.stringify(so.data));	
			}
		}
		
		protected function restoreFromiCloud():Boolean
		{
			DEFINE::IOS
			{			
				if (!Config.DEVICE)
					return false;
				
				var iCloudSave:String = iCloud.getStringForKey("save");
				var iCloudJSON:Object = JSON.parse(iCloudSave);
				
				mergeiCloud(iCloudJSON);
				
				saveToiCloud();
			}			
			return true;
		}
		
		protected function mergeiCloud(data:Object):Boolean
		{
			//sets default values on new game
			for(var key:* in data)
			{
				this.so.data[key] = data[key];
			}
			return true;
		}		*/
	}
}