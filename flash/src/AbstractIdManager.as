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
 	import flash.events.EventDispatcher;
 	
 	public class AbstractIdManager extends EventDispatcher
 	{
 		
 		//[Event(name="lookupRandomSuccess", type="IdManagerEvent")]
 		//[Event(name="lookupRandomWait", type="IdManagerEvent")]
 		//[Event(name="lookupRandomFailure", type="IdManagerError")]
 		[Event(name="lookupSuccess", type="IdManagerEvent")]
 		[Event(name="lookupWait", type="IdManagerEvent")]
 		/**
 		 * Error during user lookup.
 		 */
 		[Event(name="idManagerError", type="IdManagerError")]
 		
 		/**
 		 * Lookup remote user id.
 		 */
 		public function lookupRandom():void
 		{
 			doLookupRandom();
 		}
 		
 		 /**
 		  * Configure service information 
 		  */
 		 public function set service(service:Object):void
 		 {
 		 	doSetService(service);
 		 }
 		
 		 protected function doLookupRandom():void
 		 {
 		 	// MUST override, failure by default
 			var e:Event = new Event("lookupRandomFailure");
 			dispatchEvent(e);
 		 }
 		 
 		 protected function doSetService(service:Object):void
 		 {
 		 	// MUST override
 		 }
 	}
 }
