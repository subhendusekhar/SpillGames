﻿package src.GLP{	//import com.google.analytics.AnalyticsTracker;	//import com.google.analytics.GATracker;	import flash.display.*;	import com.google.analytics.GATracker;	import com.google.analytics.AnalyticsTracker;	import src.game.PlayerData;	public class Analytics	{		private static var tracker:AnalyticsTracker;		private static var account:String = "UA-6695967-1";		private static var gameName:String = PlayerData.GOOGLE_ANALYTICS_GAME_NAME;				public static function initialize(object:DisplayObject, debug:Boolean = false)		{			// Google Analytics initialization			tracker = new GATracker(object,account,"AS3", debug);			//tracker.debug.traceOutput = true;			//tracker.config.bucketCapacity = 100;			//tracker.config.tokenCliff = 100;			//tracker.config.tokenRate = 0.5;			//tracker.debug.showWarnings = true;			//tracker.debug.showInfos = true;						// Playtomic initialization			//Log.View(982786, "a47787a81ed74342", "235315ef19c144dcb86c3c9c1e26c0", object.loaderInfo);		}		public static function CustomMetric(string:String, group:String = null)		{			if (group == null)			{				// GA report				tracker.trackEvent(gameName, string, "per session", 0);								// Playtomic report;				//Log.CustomMetric(string);			}			else			{				// GA report				tracker.trackEvent(gameName, string, "per session", 0);								// Playtomic report				//Log.CustomMetric(string, group);			}		}		public static function LevelCounterMetric(group:String, metric:String)		{			trace("LevelMetric: " + metric);			// GA level counter			tracker.trackEvent(gameName, metric, "per session", 0);			// PlayTomic level counter			//Log.LevelCounterMetric(group, metric);		}		public static function Play()		{			// GA start game			//tracker.trackEvent(gameName, "StartGame", "per session", 0);			//Playtomic start game			//Log.Play();		}	}}