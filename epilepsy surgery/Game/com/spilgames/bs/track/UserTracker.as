package com.spilgames.bs.track
{
	/**
	 * This event category is designed for tracking user data such as demographic information.
	 * 
	 * <p>This class should help you sent these events to the Spil Tracking System.</p>
	 */
	public class UserTracker extends ATracker
	{
		private static var _instance:UserTracker;
		
		public function UserTracker(priv:Private) 
		{
			eventType = "user";
		}
		
		public static function getInstance():UserTracker {
			if (!_instance) _instance = new UserTracker(new Private());
			return _instance;
		}
		
		
		/**
		 * 
		 * @param	userID
		 */
		public function id(userID:String):void {
			call(
				SpilTrackEvent.USER_ID,
				{
					userID:userID
				}
			);
		}
		
		
		public function name(value:String):void {
			call(
				SpilTrackEvent.USER_NAME,
				{
					value:value
				}
			);
		}
		
		/**
		 * 
		 * @param	firstName
		 */
		public function firstName(firstName:String):void {
			call(
				SpilTrackEvent.USER_FIRST_NAME,
				{
					firstname:firstName
				}
			);
		}
		
		public function middleName(value:String):void {
			call(
				SpilTrackEvent.USER_MIDDLE_NAME,
				{
					value:value
				}
			);
		}
		
		public function lastName(value:String):void {
			call(
				SpilTrackEvent.USER_LAST_NAME,
				{
					value:value
				}
			);
		}
		
		public function gender(value:String):void {
			call(
				SpilTrackEvent.USER_GENDER,
				{
					value:value
				}
			);
		}
		
		public function locale(value:String):void {
			call(
				SpilTrackEvent.USER_LOCALE,
				{
					value:value
				}
			);
		}
		
		
		/**
		 * 
		 * @param	obj
		 */
		public function __custom(obj:Object):void {
			call(SpilTrackEvent.USER_CUSTOM, obj);
		}
	}
}

/**
 * This class reinforces the Singleton Pattern
 */ 
internal class Private{}