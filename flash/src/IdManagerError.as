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
	
	public class IdManagerError extends Event
	{
		public var description:String;
		
		public function IdManagerError(type:String, desc:String)
		{
			super(type);
			this.description = desc;
		}
		
		override public function clone():Event
		{
			return new IdManagerError(type, description);
		}
	}
}