package com.vitapoly.utils
{
	public class StringUtils
	{
		public static function getFileName(path:String):String {
			var index:int = path.lastIndexOf("/");
			if (index >= 0)
				return path.substr(index + 1);
			
			index = path.lastIndexOf("\\");
			if (index >= 0)
				return path.substr(index + 1);
			
			return path;
		}
	}
}