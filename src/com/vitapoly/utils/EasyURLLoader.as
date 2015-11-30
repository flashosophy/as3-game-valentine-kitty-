package com.vitapoly.utils
{
	import flash.events.*;
	import flash.net.*;

	public class EasyURLLoader
	{
		public var url:String;
		public var completeFunc:Function;
		public var errorFunc:Function;
		public var isBinary:Boolean;
		public var urlLoader:URLLoader;
		
		public function EasyURLLoader(url:String, completeFunc:Function, errorFunc:Function, isBinary:Boolean = false)
		{
			this.url = url;
			this.completeFunc = completeFunc;
			this.errorFunc = errorFunc;
			this.isBinary = isBinary;
		}
		
		private function init():void {
			if (urlLoader)
				urlLoader.close();
			
			urlLoader = new URLLoader();

			if (isBinary)
				urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			
			if (errorFunc != null)
				urlLoader.addEventListener(IOErrorEvent.IO_ERROR, errorFunc);
				
			if (completeFunc != null) {
				urlLoader.addEventListener(Event.COMPLETE, function(e:Event):void {
					completeFunc((e.target as URLLoader).data);
				});
			}
		}
		
		public function get():void {
			init();
			var request:URLRequest = new URLRequest(url);
			urlLoader.load(request);
		}
		
		public function post(obj:Object):void {
			init();
			var request:URLRequest = new URLRequest(url);
			request.method = URLRequestMethod.POST;
			
			if (obj) {
				var variables:URLVariables = new URLVariables();
				
				for (var key:String in obj) {
					variables[key] = obj[key];
				}

				request.data = variables;
			}
			
			urlLoader.load(request);
		}
		
		public function stop():void {
			if (urlLoader)
				urlLoader.close();
		}
	}
}