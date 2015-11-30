
package
{
    public class EmbeddedAssetsNonManaged
    {
	
		//used in gamestate
		[Embed(source = "/embeddedassets/Cat.png",  mimeType = "application/octet-stream")]
		public static const catResourcesData:Class;		
		
		//bitmap fonts
		[Embed(source="/embeddedassets/fonts/MarkerFelt.fnt", mimeType="application/octet-stream")]
		public static const MarkerFelt_fnt:Class;
		
		[Embed(source = "/embeddedassets/fonts/MarkerFelt.png")]
		public static const MarkerFelt:Class; 
		
		
    }
}

