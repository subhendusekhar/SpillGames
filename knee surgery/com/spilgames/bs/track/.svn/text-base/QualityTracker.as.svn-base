package com.spilgames.bs.track
{
	/**
	 * This event category is designed for tracking the performance of the product.
	 * 
	 * <p>This class should help you sent these events to the Spil Tracking System.</p>
	 */
	public class QualityTracker extends ATracker
	{
		private static var _instance:QualityTracker;
		
		public function QualityTracker(priv:Private)
		{
			eventType = "quality";
		}
		
		public static function getInstance():QualityTracker {
			if (!_instance) _instance = new QualityTracker(new Private());
			return _instance;
		}
		
		
		/**
		 * 
		 * @param	errorMessage
		 */
		public function performance(performanceMessage:String):void {
			call(
				SpilTrackEvent.QUALITY_PERFORMANCE,
				{
					msg:performanceMessage
				}
			);
		}
		
		/**
		 * 
		 * @param	errorMessage
		 */
		public function debug(debugMessage:String):void {
			call(
				SpilTrackEvent.QUALITY_DEBUG,
				{
					msg:debugMessage
				}
			);
		}
		
		/**
		 * 
		 * @param	errorMessage
		 */
		public function error(errorMessage:String):void {
			call(
				SpilTrackEvent.QUALITY_ERROR,
				{
					msg:errorMessage
				}
			);
		}
		
		
		/**
		 * 
		 * @param	obj
		 */
		public function __custom(obj:Object):void {
			call(SpilTrackEvent.QUALITY_CUSTOM, obj);
		}
	}
}

/**
 * This class reinforces the Singleton Pattern
*/
internal class Private{}