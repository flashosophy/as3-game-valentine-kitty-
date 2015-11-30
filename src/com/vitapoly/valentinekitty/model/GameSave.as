package com.vitapoly.valentinekitty.model
{
	import com.vitapoly.features.*;
	import com.vitapoly.valentinekitty.Game;
	
	import flash.net.registerClassAlias;
	
	public class GameSave extends GenericGameSave
	{
		
		public function GameSave(id:String)
		{
			registerClassAlias("UserProfile", UserProfile);
			
			super(id);

			init();
		}
		

		
		public override function init():void
		{
			super.init();
			
			// init classes
			if ( so.data.userProfile != undefined )
			{
				// check if the object was not saved as UserProfile class
				var oldUserProfile:UserProfile = so.data.userProfile as UserProfile;
				if (oldUserProfile == null) {
					oldUserProfile = new UserProfile();
					for (var key:String in so.data.userProfile) {
						oldUserProfile[key] = so.data.userProfile[key];
					}
				}
				
				// check for version
				if ( Game.getInstance().userProfile.version > oldUserProfile.version ) {
					Game.getInstance().userProfile.merge(oldUserProfile);
				} else {
					Game.getInstance().userProfile = oldUserProfile;
				}
			}
			else
			{
				// first time, use default values
				so.data.userProfile = Game.getInstance().userProfile;
			}
			
			flush();
		}
		
		
		public override function save():void
		{
			super.save();
			
			Game.getInstance().userProfile.updateSession();
			so.data.userProfile = Game.getInstance().userProfile;
			
			flush();
		}
		
	}
}

