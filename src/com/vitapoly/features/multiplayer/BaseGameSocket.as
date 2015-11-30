package com.vitapoly.features.multiplayer
{
	import com.vitapoly.features.multiplayer.events.CustomEvent;
	import com.vitapoly.features.multiplayer.events.ErrorEvent;
	import com.vitapoly.features.multiplayer.events.SessionEvent;
	import com.vitapoly.features.multiplayer.events.UsersEvent;
	
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	
	public class BaseGameSocket extends Socket
	{
		public var id:int;
		protected var bConnected:Boolean = false;
		
		public function BaseGameSocket(host:String=null, port:int=0)
		{
			super(host, port);
				
			//this.addEventListener(DataEvent.DATA, onData);
			this.addEventListener(flash.events.ProgressEvent.SOCKET_DATA, onData);
		}
		
		public function isConnected():Boolean
		{
			return bConnected;
		}
		
		
		private var HEADER:uint = 0x001;
		private var PAYLOAD:uint = 0x002;
		private var PROCESS_COMMAND:uint = 0x003;
		private var state:uint = HEADER;
		
		private var version:int =  -1;
		private var cmd:int = -1;
		private var length:int = -1;
		private var payload:ByteArray = new ByteArray();
		private var HEADER_LENGTH:uint = 5; // 5 byte header
		protected function onData(e:ProgressEvent):void
		{
			try {
				while(this.connected && this.bytesAvailable)
				{
					if ( state == HEADER )
					{
						if ( HEADER_LENGTH > this.bytesAvailable )
						{
							trace("not enough bytes for header, want: " + HEADER_LENGTH + " got " + this.bytesAvailable);
							break;
						}
						else
						{
							version = this.readShort();
							cmd = this.readByte()  & 0x0000FF;	// stupid flash only has ints, so let's modify it
							length = this.readShort();
							
							state = PAYLOAD;
						}
					}
					
					if ( state == PAYLOAD )
					{
						if ( length > this.bytesAvailable )
						{
							trace("not enough bytes, waiting for more, want: " +  length + " got " + this.bytesAvailable);
							break;
						}
						else
						{
							this.readBytes(payload, 0, length);		// read all of it
							state = PROCESS_COMMAND;

						}
					}

			
					if ( state == PROCESS_COMMAND )
					{						
						switch(cmd)
						{
							case Constants.ID:
								this.id = payload.readInt();
								trace("SET ID: " + this.id);
								bConnected = true;
								trace("set connected: " + bConnected);
								
								// acknowledge
								var tmp:ByteArray = new ByteArray();
								tmp.writeByte(0xFF);
								raiseEvent(-1, Constants.READY,tmp);
								
								break;
							
							case Constants.JOIN:
								var joinedID:int = payload.readInt();
								dispatchEvent(new SessionEvent(joinedID, SessionEvent.JOIN_EVENT));
								break;
							
							case Constants.LEAVE:
								dispatchEvent(new SessionEvent(payload.readInt(), SessionEvent.LEAVE_EVENT));
								break;
							
							case Constants.USERS:
								var usersCount:int = payload.readInt();
								var users:Array = new Array(usersCount);
								for(var i:int=0; i<usersCount; i++)
								{
									users[i] = payload.readInt();
								}
								dispatchEvent(new UsersEvent(users));
								break;
							
							case Constants.MISMATCH_VERSION:
								dispatchEvent(new ErrorEvent("Mismatched Versions"));
								this.close();
								break;
							
							case Constants.ROOM_FILLED:
								dispatchEvent(new SessionEvent(payload.readInt(), SessionEvent.ROOM_FILLED));
								break;
							
							default:
								onCustomEvent(version, cmd, payload);
								break;
						}
						
						state = HEADER;
						// clear for next command
						payload.clear();
						length = -1;
						cmd = -1;
						version = -1;
						
						
					}
				}
			}  
			catch (e:Error) {  
				trace('error:' + e.getStackTrace());  
			} 					
		}
		
		public function raiseEvent(version:int, customEvent:int, data:ByteArray=null):void
		{						
			if ( !this.connected )
				return;
			var payload:ByteArray = new ByteArray();
			payload.writeShort(version);
			payload.writeByte(customEvent & 0x0000FF);
			
			var payload_length:int = (data!=null)?data.length + 4:4;
			
			payload.writeShort(payload_length); // 4 bytes for the id added as well
			payload.writeInt(id);

			if ( data!=null && data.length > 0 )
				payload.writeBytes(data);

			// send it off to the server
			this.writeBytes(payload);
			this.flush();
			
		}
		
		public function onCustomEvent(version:int, cmd:int, data:ByteArray):void
		{
			trace("YOU NEED TO OVERRIDE THIS FUNCTION AND HANDLE THIS EVENT");
			trace("Custom Event Recieved: " + data);
			var socketID:int = data.readInt();
			var message:ByteArray = new ByteArray();
			data.readBytes(message);
			dispatchEvent(new CustomEvent(cmd, socketID, message));
		}
	}
}

