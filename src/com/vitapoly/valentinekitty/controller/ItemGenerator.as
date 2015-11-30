package com.vitapoly.valentinekitty.controller
{
	import com.vitapoly.valentinekitty.Game;
	import com.vitapoly.valentinekitty.Tools;
	import com.vitapoly.valentinekitty.view.CatHero;
	import com.vitapoly.valentinekitty.view.CoinBling;
	import com.vitapoly.valentinekitty.view.DangerItem;
	import com.vitapoly.valentinekitty.view.Rose;
	
	import nape.geom.Vec2;
	
	import starling.display.Image;
	
	public class ItemGenerator
	{
		private var happyItemArr:Array, sadItemArr:Array;
		private var i:int, dropSpeed:int;
		private var tools:Tools;
		private const leftLimit:int= 300;
		private const rightLimit:int = 1000;
		private var allItemArr:Array;
		
		public function ItemGenerator()
		{
			tools = new Tools;
			happyItemArr = new Array("coconut","frisbee","snorkle","beachball","toyboat","shovel","umbrella","rock");
			sadItemArr = new Array("bottle","boot","alarm","teddy","plant","fryingpan","tv","anvil");
			allItemArr = new Array();
		}
		
		public function generateUpToLevel(in_num:int):void
		{			
			if(Game.getInstance().gameGUI.isLevelTypeHappy)				
			{
				dropItem(happyItemArr[tools.randRange(0,in_num)] , tools.randRange(leftLimit, rightLimit),0);
			}
			else
			{
				dropItem(sadItemArr[tools.randRange(0,in_num)] , tools.randRange(leftLimit, rightLimit),0);
			}
		}
		
		public function generateRose():void
		{		
			//drop another one if have upgrade
			if(Game.getInstance().userProfile.hasGuitarUpgrade )
			{
				dropItem("rose", tools.randRange(leftLimit,rightLimit ), 0);
			}
			dropItem("rose", tools.randRange(leftLimit,rightLimit ), 0);
		}
		
		public function generateCoin():void
		{
			dropItem("coin", tools.randRange(leftLimit,rightLimit ), 0);
		}
		
		
		public function dropItem(in_name:String, in_x, in_y):void
		{	
			var tempItem:DangerItem;
			var roseItem:Rose;
			var coinItem:CoinBling;
			var hero:CatHero = Game.getInstance().hero;
			var itemImage:Image = new Image(Game.sAssets.getTexture(in_name));
			//tempRose.body.gravMass = in_mass;
			switch(in_name)
			{
				case "rose":
					roseItem = new Rose(in_name,hero ,{view:itemImage, x:in_x, y:in_y});					
					roseItem.body.angularVel = tools.randRange(-3, 3);					
					roseItem.body.velocity = new Vec2(tools.randRange(-100, 100), 0);
					break;	
				
				case "coin":
					coinItem = new CoinBling(in_name,hero ,{view:itemImage, x:in_x, y:in_y});					
					coinItem.body.angularVel = tools.randRange(-3, 3);					
					coinItem.body.velocity = new Vec2(tools.randRange(-100, 100), 0);
					break;	
				
				case "bottle":
					tempItem = new DangerItem(in_name,hero ,{view:itemImage, x:in_x, y:in_y});
					tempItem.body.angularVel = tools.randRange(-3, 3);					
					tempItem.body.velocity = new Vec2(tools.randRange(-100, 100), 0);
					tempItem.coinsValue = 1;
					tempItem.damage = 1;
					break;	
				
				case "boot":
					tempItem = new DangerItem(in_name,hero ,{view:itemImage, x:in_x, y:in_y});
					tempItem.body.angularVel = tools.randRange(-3, 3);					
					tempItem.body.velocity = new Vec2(tools.randRange(-100, 100), 0);
					tempItem.coinsValue = 3;
					tempItem.damage = 1;
					break;
				case "alarm":
					tempItem = new DangerItem(in_name,hero ,{view:itemImage, x:in_x, y:in_y});
					tempItem.body.angularVel = tools.randRange(-3, 3);					
					tempItem.body.velocity = new Vec2(tools.randRange(-100, 100), 0);
					tempItem.coinsValue = 5;
					tempItem.damage = 2;
					break;
				case "teddy":
					tempItem = new DangerItem(in_name,hero ,{view:itemImage, x:in_x, y:in_y});
					tempItem.body.angularVel = tools.randRange(-2, 2);					
					tempItem.body.velocity = new Vec2(tools.randRange(-100, 100), 0);
					tempItem.coinsValue = 7;
					tempItem.damage = 0;
					break;	
				case "plant":
					tempItem = new DangerItem(in_name,hero ,{view:itemImage, x:in_x, y:in_y});
					tempItem.body.angularVel = tools.randRange(-3, 3);					
					tempItem.body.velocity = new Vec2(tools.randRange(-100, 100), 0);
					tempItem.coinsValue = 9;
					tempItem.damage = 2;
					break;		
				case "fryingpan":
					tempItem = new DangerItem(in_name,hero ,{view:itemImage, x:in_x, y:in_y});
					tempItem.body.angularVel = tools.randRange(-3, 3);					
					tempItem.body.velocity = new Vec2(tools.randRange(-100, 100), 0);
					tempItem.coinsValue = 11;
					tempItem.damage = 3;
					break;			
				case "tv":
					tempItem = new DangerItem(in_name,hero ,{view:itemImage, x:in_x, y:in_y});
					tempItem.body.angularVel = tools.randRange(-1, 1);					
					tempItem.body.velocity = new Vec2(tools.randRange(-100, 100), 0);
					tempItem.coinsValue = 15;
					tempItem.damage = 3;
					break;	
				case "anvil":
					tempItem = new DangerItem(in_name,hero ,{view:itemImage, x:in_x, y:in_y});
					//tempItem.body.angularVel = tools.randRange(-3, 3);					
					//tempItem.body.velocity = new Vec2(tools.randRange(-100, 100), 0);
					tempItem.coinsValue = 25;
					tempItem.damage = 5;
					break;
				
				
				case "frisbee":
					tempItem = new DangerItem(in_name,hero ,{view:itemImage, x:in_x, y:in_y});
					//tempItem.body.angularVel = tools.randRange(-3, 3);					
					tempItem.body.velocity = new Vec2(tools.randRange(-300, 300), 0);
					tempItem.coinsValue = 1;
					tempItem.damage = 1;
					break;
				case "coconut":
					tempItem = new DangerItem(in_name,hero ,{view:itemImage, x:in_x, y:in_y});
					tempItem.body.angularVel = tools.randRange(-3, 3);					
					tempItem.body.velocity = new Vec2(tools.randRange(-100, 100), 0);
					tempItem.coinsValue = 3;
					tempItem.damage = 1;
					break;
				case "snorkle":
					tempItem = new DangerItem(in_name,hero ,{view:itemImage, x:in_x, y:in_y});
					tempItem.body.angularVel = tools.randRange(-3, 3);					
					tempItem.body.velocity = new Vec2(tools.randRange(-100, 100), 0);
					tempItem.coinsValue = 5;
					tempItem.damage = 2;
					break;
				case "beachball":
					tempItem = new DangerItem(in_name,hero ,{view:itemImage, x:in_x, y:in_y});
					tempItem.body.angularVel = tools.randRange(-5, 5);					
					tempItem.body.velocity = new Vec2(tools.randRange(-100, 100), 0);
					tempItem.coinsValue = 7;
					tempItem.damage = 0;
					break;				
				case "toyboat":
					tempItem = new DangerItem(in_name,hero ,{view:itemImage, x:in_x, y:in_y});
					tempItem.body.angularVel = tools.randRange(-3, 3);					
					tempItem.body.velocity = new Vec2(tools.randRange(-100, 100), 0);
					tempItem.coinsValue = 9;
					tempItem.damage = 2;
					break;
				case "shovel":
					tempItem = new DangerItem(in_name,hero ,{view:itemImage, x:in_x, y:in_y});
					tempItem.body.angularVel = tools.randRange(-3, 3);					
					tempItem.body.velocity = new Vec2(tools.randRange(-100, 100), 0);
					tempItem.coinsValue = 11;
					tempItem.damage = 3;
					break;
				case "umbrella":
					tempItem = new DangerItem(in_name,hero ,{view:itemImage, x:in_x, y:in_y});
					tempItem.body.angularVel = tools.randRange(-1, 1);					
					tempItem.body.velocity = new Vec2(tools.randRange(-100, 100), 0);
					tempItem.coinsValue = 15;
					tempItem.damage = 3;
					break;
				case "rock":
					tempItem = new DangerItem(in_name,hero ,{view:itemImage, x:in_x, y:in_y});
					//tempItem.body.angularVel = tools.randRange(-3, 3);					
					//tempItem.body.velocity = new Vec2(tools.randRange(-100, 100), 0);
					tempItem.coinsValue = 25;
					tempItem.damage = 5;
					break;
				
			}
			
			if(roseItem)
				Game.getInstance().add(roseItem);
			
			else
				if(coinItem)
				Game.getInstance().add(coinItem);
			
			else
			if(tempItem)
			{
				
				allItemArr.push(tempItem);
				Game.getInstance().add(tempItem);
			}
			
			
		}
		
		public function cleanUp():void
		{
			var arrLength:int = allItemArr.length;
			var dangerItem:DangerItem;
			
			for(i=0; i < arrLength; i++)
			{
				dangerItem = 	allItemArr.pop();
				dangerItem.cleanUp();
			}
		}
		
	}
}



