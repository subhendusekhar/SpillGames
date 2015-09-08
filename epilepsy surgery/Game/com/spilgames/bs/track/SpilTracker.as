package com.spilgames.bs.track
{
	/**
	 * This class provides developers with access to the Spil Event Tracker system for in game events. It is a
	 * singular interface for each of the standard Spil events and for the custom event.
	 * 
	 * <p>Developers can use this class to track in game events and get insight about players behaviour
	 * during the game play.</p>
	 */ 
	public class SpilTracker
	{	
		
		/**
		 * Gameplay events allow the developer to track specific in game behaviour from the players.
		 */
		public static function get gameplay():GameplayTracker
		{
			return  GameplayTracker.getInstance();
		}
		
		/**
		 * This function allows the developer to track some pre-defined kind of in-game events
		 */
		public static function get user():UserTracker
		{
			return  UserTracker.getInstance();
		}
		
		/**
		 * This function allows the developer to track some pre-defined kind of in-game events
		 */
		public static function get bussiness():BussinessTracker
		{
			return  BussinessTracker.getInstance();
		}
		
		/**
		 * This function allows the developer to track some pre-defined kind of in-game events
		 */
		public static function get quality():QualityTracker
		{
			return  QualityTracker.getInstance();
		}
		
		/**
		 * This function allows the developer to track custom in-game events
		 * 
		 */
		public static function trackCustomEvent():void
		{
			
		} 
	}
}