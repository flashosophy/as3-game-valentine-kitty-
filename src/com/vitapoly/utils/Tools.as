
package com.vitapoly.utils
{
  
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   
   import starling.display.*;
   import starling.events.*;

   public class Tools extends Sprite
   {
      //filter stuff
    
      public var tempMovie:Sprite;
	  public var tempImage:Image;
      private var tempMovieArr:Array = new Array();
      private var fadeInTimer:Timer = new Timer(30,15);
      private var fadeOutTimer:Timer = new Timer(30,15);
      private var fadeInTimerItem:Timer = new Timer(30,15);
      private var fadeOutTimerItem:Timer = new Timer(30,15);
	  private var screenShakeTimer:Timer = new Timer(50,5);
	  private var shakeCounter:int, i:int, j:int;
	  private var alreadyShaking:Boolean;
	  private var shakeItem:String;
	  private var tempDO:DisplayObject;
	  
      public function Tools()
      {
         super();
		
      }

      public function randRange(min:Number, max:Number):Number{
          var randomNum:Number = Math.floor(Math.random() * (max - min + 1)) + min
          return randomNum
      }

      //called to move 3d object to target
    //  public function moveHandler(in_3DOBJ, in_target, in_speed:Number):void{ in_3DOBJ.transform.matrix3D.interpolateTo(in_target.transform.matrix3D,in_speed) }

      public function moveTo2D(in_from:Sprite, in_to:Sprite, in_speed:Number):void{
         //multiply is more efficient than division
         in_from.x+=(in_to.x- in_from.x)*in_speed;
         in_from.y+=(in_to.y- in_from.y)*in_speed;
      }
      
	  public function moveTo2DXSprite(in_from:Sprite, in_to:Sprite, in_speed:Number):void{ in_from.x+=(in_to.x- in_from.x)*in_speed; }
	  public function moveTo2DYSprite(in_from:Sprite, in_to:Sprite, in_speed:Number):void{ in_from.y+=(in_to.y- in_from.y)*in_speed; }
	  public function moveTo2DYImage(in_from:Image, in_to:Sprite, in_speed:Number):void{ in_from.y+=(in_to.y- in_from.y)*in_speed; }
	  public function moveTo2DXImage(in_from:Image, in_to:Sprite, in_speed:Number):void{ in_from.x+=(in_to.x- in_from.x)*in_speed; }
      //moves away
      public function moveAway2D(in_from:Sprite, in_to:Sprite, in_speed:Number):void{
         in_from.x-=(in_to.x- in_from.x)*in_speed
         in_from.y-=(in_to.y- in_from.y)*in_speed
      }

      //returns the degrees
 //     public function getAngleMouse(in_name):Number{ return Math.round(Math.atan2((mouseY-in_name.y),(mouseX-in_name.x) )*180*.318)}

      public function getAngleRelative(in_name:Sprite, in_from:Sprite):Number{ return Math.round(Math.atan2((in_from.y-in_name.y),(in_from.x-in_name.x) )*180*.318)+90}

     //returns x speed of object
      public function getXSpeed(in_rotation:Number):Number{
      	return Math.sin(in_rotation*(3.14/180));
      }
      public function getYSpeed(in_rotation:Number):Number{
         return Math.cos(in_rotation*(3.14/180))*-1;
      }
   /// fader stuff ------------------------------------------------------------------------------------
     public function closeContent():void{
         fadeOutTimer = new Timer(30,15);
         fadeOutTimer.addEventListener("timer", fadeOutTimerHandler);
         fadeOutTimer.start();
      }     
      
      public function openContent():void{
         fadeInTimer = new Timer(30,15);
         fadeInTimer.addEventListener("timer", fadeInTimerHandler);
         fadeInTimer.start();
      }        
      
      private function fadeInTimerHandler(e:TimerEvent):void{               
          this.alpha += .1;
          if(this.alpha >= 1){
            this.alpha =1;
            this.visible =true;
            fadeInTimer.stop();
            fadeInTimer.addEventListener("timer", fadeInTimerHandler);
          }
      }  
      

      private function fadeOutTimerHandler(e:TimerEvent):void
	  {               
          this.alpha -= .1;
          if(this.alpha <= 0){
            this.alpha =0;
            this.visible =false;
            fadeOutTimer.stop();
            fadeOutTimer.addEventListener("timer", fadeInTimerHandler);
          }
      }
      
      // fades item in/out --------------------------------
      public function closeContentItem(in_mov:Sprite):void{
         tempMovie = in_mov;
         tempMovie.alpha =1;
         tempMovie.visible =true;

         fadeOutTimerItem = new Timer(30,15);
         fadeOutTimerItem.addEventListener("timer", fadeOutTimerHandlerItem);
         fadeOutTimerItem.start();
      }     
      
      public function openContentItem(in_mov:Sprite):void{
         tempMovie = in_mov;
         tempMovie.alpha =0;
         tempMovie.visible =true;

         fadeInTimerItem = new Timer(30,15);
         
         fadeInTimerItem.addEventListener("timer", fadeInTimerHandlerItem);
         fadeInTimerItem.start();
      }        
      
      private function fadeInTimerHandlerItem(e:TimerEvent):void{    
    
          tempMovie.alpha += .1;
          if(tempMovie.alpha >= 1){        
            tempMovie.alpha =1;
            tempMovie.visible =true;
            fadeInTimerItem.stop();
            fadeInTimerItem.removeEventListener("timer", fadeInTimerHandlerItem);
          }
      }  

      private function fadeOutTimerHandlerItem(e:TimerEvent):void{               
          tempMovie.alpha -= .1;
          if(tempMovie.alpha <= 0){
            tempMovie.alpha =0;
            tempMovie.visible =false;
            fadeOutTimerItem.stop();
            fadeOutTimerItem.removeEventListener("timer", fadeInTimerHandlerItem);
          }
      }  

	  public function shakeDO(in_mov:DisplayObject):void{
		  if(!alreadyShaking)
		  {
			  try{screenShakeTimer.removeEventListener("timer", shakeTimerHandler);}catch(e:Error){};
			  screenShakeTimer.addEventListener("timer", shakeTimerHandler);
			  screenShakeTimer.reset();
			  tempDO = in_mov;
			  shakeCounter=0;
			  screenShakeTimer.start();
		  }
	  }
	  
	  
	  public function generateUniqueArr(in_size:int, in_min:int, in_max:int):Array
	  {
		  var arr:Array = new Array();
		  var tempNum:int;
		  var dupTestCounter:int;
		  
		  //check in case infinite loop
		  if(in_size-1 > Math.abs(in_min - in_max))
			  return null;
		  
		  for( i=0; i < in_size; i++)
		  {
			  arr[i] = randRange(in_min,in_max);
		  }
		  
		  while(dupTestCounter < 30)
		  {
			  for(i=0; i < in_size; i++)
			  {
				  for( j=0; j < in_size; j++)
				  {
					  if( i != j) //don't check itself
					  {
						  if(arr[i] == arr[j]) //if duplicate is detected, create a new random number
						  {
							  //trace("dup detected and fixed")
							  arr[i] = randRange(in_min,in_max);
							  break;
						  }
					  }
				  }
				  
			  }
			  dupTestCounter++;
		  }
		  return arr;
	  }
	  
	  
	  //these are all helper stuff for the above public functions ------------------------------------------------------------------
	  
	  private function shakeTimerHandler(e:TimerEvent):void
	  {
		  alreadyShaking = true;
		  switch(shakeCounter)
		  {
			  case 0:
				  
				  tempDO.x += 2;
				  
				  break;
			  case 1:
				 
					  tempDO.x -= 3;
					  tempDO.y += 1;
				  
				  break;
			  case 2:
				 
					  tempDO.y -= 3;
				  break;
			  case 3:
				  
					  tempDO.x += 2;
					  tempDO.y += 3;
				  
				  break;
			  case 4:
				  
					  tempDO.x -= 1;
					  tempDO.y -= 1;
				  
			       alreadyShaking = false;
				  shakeCounter=0;
				  try{screenShakeTimer.removeEventListener("timer", shakeTimerHandler);}catch(e:Error){};
				  break;
		  }
		  shakeCounter++;
	  }
	  
   }//end class
}//end




