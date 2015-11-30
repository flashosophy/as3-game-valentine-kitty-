
package
{
    public class EmbeddedAssets
    {
		/** ATTENTION: Naming conventions!
		 *  
		 *  - Classes for embedded IMAGES should have the exact same name as the file,
		 *    without extension. This is required so that references from XMLs (atlas, bitmap font)
		 *    won't break.
		 *    
		 *  - Atlas and Font XML files can have an arbitrary name, since they are never
		 *    referenced by file name.
		 * 
		 */
		
		
		//gui
		[Embed(source = "/embeddedassets/gui/modeHappy.png")]
		public static const  modeHappy:Class;
		[Embed(source = "/embeddedassets/gui/modeSad.png")]
		public static const  modeSad:Class;		
		[Embed(source = "/embeddedassets/gui/spotLight.png")]
		public static const  spotLight:Class;
		[Embed(source = "/embeddedassets/gui/heart50.png")]
		public static const  heart50:Class;
		[Embed(source = "/embeddedassets/gui/levelup.png")]
		public static const  levelup:Class;
		[Embed(source = "/embeddedassets/gui/spendBtn.png")]
		public static const  spendBtn:Class;
		
		[Embed(source = "/embeddedassets/gui/wallOfLoveBtn.png")]
		public static const  wallOfLoveBtn:Class;
		[Embed(source = "/embeddedassets/gui/scrollBG.png")]
		public static const  scrollBG:Class;
		[Embed(source = "/embeddedassets/gui/arrow.png")]
		public static const  arrow:Class;
		
		[Embed(source = "/embeddedassets/gui/itemImage0.png")]
		public static const  itemImage0:Class;
		[Embed(source = "/embeddedassets/gui/itemImage1.png")]
		public static const  itemImage1:Class;
		[Embed(source = "/embeddedassets/gui/itemImage2.png")]
		public static const  itemImage2:Class;
		[Embed(source = "/embeddedassets/gui/portrait.png")]
		public static const  portrait:Class;
		[Embed(source = "/embeddedassets/gui/moneyArrow.png")]
		public static const  moneyArrow:Class;
		
		[Embed(source = "/embeddedassets/gui/facebook.png")]
		public static const  facebook:Class;
		[Embed(source = "/embeddedassets/gui/twitter.png")]
		public static const  twitter:Class;
		[Embed(source = "/embeddedassets/gui/email.png")]
		public static const  email:Class;
		
		
		//particles
		[Embed(source="/embeddedassets/particles/rainBlueFade.pex", mimeType="application/octet-stream")]
		public static const rainBlueFadePex:Class;
		[Embed(source = "/embeddedassets/particles/rainBlueFade.png")]
		public static const rainBlueFadePNG:Class;
		
		[Embed(source="/embeddedassets/particles/blossom.pex", mimeType="application/octet-stream")]
		public static const blossom:Class;
		[Embed(source = "/embeddedassets/particles/flower.png")]
		public static const flowerPNG:Class;
		
		[Embed(source="/embeddedassets/particles/rainbowMagic.pex", mimeType="application/octet-stream")]
		public static const rainbowMagicPex:Class;
		[Embed(source = "/embeddedassets/particles/rainbowMagic.png")]
		public static const rainbowMagicPNG:Class;
		
		[Embed(source="/embeddedassets/particles/hearts.pex", mimeType="application/octet-stream")]
		public static const heartsPex:Class;
		[Embed(source = "/embeddedassets/particles/hearts.png")]
		public static const heartsPNG:Class;
		
		[Embed(source="/embeddedassets/particles/starExplosion.pex", mimeType="application/octet-stream")]
		public static const starExplosionPex:Class;
		[Embed(source = "/embeddedassets/particles/starExplosion.png")]
		public static const starExplosionPNG:Class;
		
		[Embed(source="/embeddedassets/particles/stars.pex", mimeType="application/octet-stream")]
		public static const starsPex:Class;
		[Embed(source = "/embeddedassets/particles/stars.png")]
		public static const starsPNG:Class;
		
		
		//used in gamestate
		[Embed(source = "/embeddedassets/backgrounds/beachGameBackground.jpg")]
		public static const  beachGameBackground:Class;
		
		[Embed(source = "/embeddedassets/backgrounds/gamebackground.jpg")]
		public static const  gamebackground:Class;
		[Embed(source = "/embeddedassets/backgrounds/palmTree.png")]
		public static const  palmTree:Class;
		
		//common btns
		[Embed(source = "/embeddedassets/btns/longBtn.png")]
		public static const  longBtn:Class;
		[Embed(source = "/embeddedassets/btns/squareBtn.png")]
		public static const  squareBtn:Class;
		[Embed(source = "/embeddedassets/btns/rectBtn.png")]
		public static const  rectBtn:Class;
		[Embed(source = "/embeddedassets/btns/spaceBtn.png")]
		public static const  spaceBtn:Class;
		
		
		
		
		//itemns
		[Embed(source = "/embeddedassets/items/rose.png")]
		public static const rose:Class;
		
		[Embed(source = "/embeddedassets/items/boot.png")]
		public static const boot:Class;
		[Embed(source = "/embeddedassets/items/tv.png")]
		public static const tv:Class;
		[Embed(source = "/embeddedassets/items/bottle.png")]
		public static const bottle:Class;
		[Embed(source = "/embeddedassets/items/alarm.png")]
		public static const alarm:Class;
		[Embed(source = "/embeddedassets/items/plant.png")]
		public static const plant:Class;
		[Embed(source = "/embeddedassets/items/fryingpan.png")]
		public static const fryingpan:Class;
		[Embed(source = "/embeddedassets/items/teddy.png")]
		public static const teddy:Class;
		[Embed(source = "/embeddedassets/items/anvil.png")]
		public static const anvil:Class;
		
		[Embed(source = "/embeddedassets/items/beachball.png")]
		public static const beachball:Class;
		[Embed(source = "/embeddedassets/items/coconut.png")]
		public static const coconut:Class;
		[Embed(source = "/embeddedassets/items/umbrella.png")]
		public static const umbrella:Class;
		[Embed(source = "/embeddedassets/items/frisbee.png")]
		public static const frisbee:Class;
		[Embed(source = "/embeddedassets/items/snorkle.png")]
		public static const snorkle:Class;
		[Embed(source = "/embeddedassets/items/shovel.png")]
		public static const shovel:Class;
		[Embed(source = "/embeddedassets/items/toyboat.png")]
		public static const toyboat:Class;
		[Embed(source = "/embeddedassets/items/rock.png")]
		public static const rock:Class;
		[Embed(source = "/embeddedassets/items/coin.png")]
		public static const  coin:Class;
		
		
		
		
		
		//sounds effects
		[Embed(source="/embeddedassets/sounds/lightOn.mp3")]	public static const lightOn:Class;
		[Embed(source="/embeddedassets/sounds/hearts.mp3")]	public static const hearts:Class;
		[Embed(source="/embeddedassets/sounds/playerGotHit0.mp3")]	public static const playerGotHit0:Class;
		[Embed(source="/embeddedassets/sounds/playerGotHit1.mp3")]	public static const playerGotHit1:Class;
		[Embed(source="/embeddedassets/sounds/chaching.mp3")]	public static const chaching:Class;
		[Embed(source="/embeddedassets/sounds/swooshIn.mp3")]	public static const swooshIn:Class;
		[Embed(source="/embeddedassets/sounds/stars.mp3")]	public static const stars:Class;
		[Embed(source="/embeddedassets/sounds/land0.mp3")]	public static const land0:Class;
		[Embed(source="/embeddedassets/sounds/land1.mp3")]	public static const land1:Class;
		[Embed(source="/embeddedassets/sounds/error.mp3")]	public static const error:Class;
		[Embed(source="/embeddedassets/sounds/popIn.mp3")]	public static const popIn:Class;
		[Embed(source="/embeddedassets/sounds/popOut.mp3")]	public static const popOut:Class;
		[Embed(source="/embeddedassets/sounds/coinLand.mp3")]	public static const coinLand:Class;
		
		
		//music
		[Embed(source="/embeddedassets/sounds/For_Naama_Loop_A.mp3")]		public static const title1:Class;
		[Embed(source="/embeddedassets/sounds/Fall_to_Earth_Loop_B.mp3")]		public static const title2:Class;
		[Embed(source="/embeddedassets/sounds/Montuno_Full_Track.mp3")]		public static const happy:Class;
		[Embed(source="/embeddedassets/sounds/Mexican_Guitar_Full_Track.mp3")]		public static const sad:Class;
		
    }
}

