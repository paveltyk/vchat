/**
 * ADOBE SYSTEMS INCORPORATED
 * Copyright 2008 Adobe Systems Incorporated
 * All Rights Reserved.
 *
 * NOTICE: Adobe permits you to use, modify, and distribute this file
 * in accordance with the terms of the license agreement accompanying it.
 * 
 * Author: Jozsef Vass
 */
package
{
	import flash.events.Event;

	public class IdManagerEvent extends Event
	{
		public var id:String;
		public var user:String;
		
		public function IdManagerEvent(type:String, user:String, id:String)
		{
			super(type);
			this.id = id;
			this.user = user;
		}
		
		override public function clone():Event
		{
			return new IdManagerEvent(type, user, id);
		}
	}
}