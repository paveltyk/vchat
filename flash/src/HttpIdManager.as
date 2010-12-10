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
 	import flash.utils.Timer;
 	import flash.events.TimerEvent;
 	import flash.events.Event;
 	import flash.net.NetConnection;
 	
 	import mx.rpc.events.FaultEvent;
 	import mx.rpc.events.ResultEvent;
 	import mx.rpc.http.HTTPService;
 	import mx.controls.Alert;
			
 	public class HttpIdManager extends AbstractIdManager
 	{	
 		private var mHttpService:HTTPService = null;
 		
 		//private const mWebServiceUrl:String = "http://10.1.2.117:3000/chatters";

 	 	private var mWebServiceUrl:String = "";
		
		private var mConnectionTimer:Timer;
		private var mId:String;
		private var mNc:NetConnection;
		
		
		override protected function doSetService(service:Object):void
		{
			mWebServiceUrl = service.url;
			mNc = service.nc;
			mId = service.nc.nearID;
			mHttpService = new HTTPService();
            mHttpService.url = mWebServiceUrl;
            mHttpService.addEventListener("result", httpResult);
            mHttpService.addEventListener("fault", httpFault);
		}
 		/*
 		override protected function doRegister(user:String, id:String):void
 		{
 			if (mWebServiceUrl.length == 0 || user.length == 0 || id.length == 0)
 			{
				var e:Event = new IdManagerError("registerFailure", "Empty web service URL, user, or id");
 				dispatchEvent(e);			
 			}
 			
 			mUser = user;
 			mId = id;
 			
 			// register the id to http service
            mHttpService = new HTTPService();
            mHttpService.url = mWebServiceUrl;
            mHttpService.addEventListener("result", httpResult);
            mHttpService.addEventListener("fault", httpFault);
                
            var request:Object = new Object();
            request.username = user;
            request.identity = id;
            
            mHttpService.cancel();
            mHttpService.method = "POST";
            mHttpService.send(request);
                
            // refresh registration with web service in every 30 minutes
			mConnectionTimer = new Timer(1000 * 60 * 30);
			mConnectionTimer.addEventListener(TimerEvent.TIMER, onConnectionTimer);
            mConnectionTimer.start();
 		}
 		*/
 		override protected function doLookupRandom():void
 		{
 			if (mHttpService)
 			{
 				var request:Object = new Object();
				// when making repeated calls to the same user, it seemed that
				// we recived cached result. So add time, to it to make it unique.
				var now:Date = new Date();
				request.time = now.getTime();
				request.chatter_identity = mId;
				mHttpService.url = mWebServiceUrl + "/lookup";
				mHttpService.cancel();
				mHttpService.method = "POST";
				mHttpService.send(request);
 			}
 			else
 			{
 				var e:Event = new IdManagerError("lookupRandomFailure", "HTTP service not created");
 				dispatchEvent(e);
 			}
 		}
 		/*
 		override protected function doUnregister():void
 		{
 			if (mHttpService)
			{
				var request:Object = new Object();
				request._method = "delete";
				mHttpService.url = mWebServiceUrl + "/" + mId;
				mHttpService.cancel();
				mHttpService.method = "POST";
				mHttpService.send(request);
			}
					
			if (mConnectionTimer)
			{
 				mConnectionTimer.stop();
 				mConnectionTimer = null;
 			}	
 		}
 		*/
 		// we need to refresh regsitration with web service periodically
 		/*
		private function onConnectionTimer(e:TimerEvent):void
		{		
			var request:Object = new Object();
            request.username = mUser;
           	request.identity = mId;
           	var now:Date = new Date();
			request.time = now.getTime();
            mHttpService.cancel();
            mHttpService.send(request);
		}
		*/
 		// process error from web service
		private function httpFault(e:FaultEvent):void
		{	
			var d:IdManagerError = new IdManagerError("idManagerError", "HTTP error: " + e.message.toString());
 			dispatchEvent(d);
		}
		
		// process successful response from web service		
		private function httpResult(e:ResultEvent):void
		{	
			var result:Object = e.result as Object;
			var remote:Object;
			var d:Event;
			if (result.hasOwnProperty('r_type'))
			{
				switch (result.r_type)
				{
					case "wait":
						var wait:IdManagerEvent = new IdManagerEvent("lookupWait", "", "");
						dispatchEvent(wait);
						break;
					case "found":
						var found:IdManagerEvent = new IdManagerEvent("lookupSuccess",result.identity, result.identity);
						dispatchEvent(found);
						break;
				}
			}
			/*
			if (result.hasOwnProperty("result"))
			{
				if (result.result.hasOwnProperty("update"))
				{
					// registration response
					if (result.result.update == true)
					{
						var d:Event = new Event("registerSuccess");
 						dispatchEvent(d);
					}
					else
					{
						d = new IdManagerError("registerFailure", "HTTP update error");
 						dispatchEvent(d);
					}
				}
				else if (result.result.hasOwnProperty("friend"))
				{
					// party query response
					remote = result.result.friend as Object;
					if (remote.hasOwnProperty("user") && remote.hasOwnProperty("identity"))
					{
						var identityString:String = remote.identity
						var userString:String = remote.user;
						
						var r:IdManagerEvent = new IdManagerEvent("lookupSuccess", userString, identityString);
						dispatchEvent(r);
					}
					else
					{
						d = new IdManagerError("lookupFailure", "HTTP response does not have user property");
 						dispatchEvent(d);
					}
				}
				else
				{
					d = new IdManagerError("idManagerError", "Unhandeled HTTP response");
 					dispatchEvent(d);
				}
			}*/
			else
			{
				d = new IdManagerError("idManagerError", "HTTP response has no r_type");
 				dispatchEvent(d);

			}
		}
 	}
 }
