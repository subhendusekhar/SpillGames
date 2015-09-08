package com.spilgames.bs.track
{
	/**
	 * This event category is designed for tracking data related to bussiness and revenue such as in game
	 * purchases.
	 * 
	 * <p>This class should help you sent these events to the Spil Tracking System.</p>
	 */
	public class BussinessTracker extends ATracker
	{
		private static var _instance:BussinessTracker;
		
		public function BussinessTracker(priv:Private) 
		{
			eventType = "bussiness";
		}
		
		public static function getInstance():BussinessTracker {
			if (!_instance) _instance = new BussinessTracker(new Private());
			return _instance;
		}
		
		
		public function storeEntered():void {
			call(SpilTrackEvent.BUSSINESS_STORE_ENTERED);
		}
		
		public function storeClosed():void {
			call(SpilTrackEvent.BUSSINESS_STORE_CLOSED);
		}
		
		/**
		 * 
		 * @param	item		The name or ID of the item
		 */
		public function itemSelected(item:String):void {
			call(
				SpilTrackEvent.BUSSINESS_ITEM_SELECTED,
				{
					item:item
				}
			);
		}
		
		/**
		 * 
		 * @param	item		The name or ID of the item
		 */
		public function itemCancelled(item:String):void {
			call(
				SpilTrackEvent.BUSSINESS_ITEM_CANCELLED,
				{
					item:item
				}
			);
		}
		
		/**
		 * 
		 * @param	item		The name or ID of the item
		 */
		public function itemSuccessful(item:String):void {
			call(
				SpilTrackEvent.BUSSINESS_ITEM_SUCCESSFUL,
				{
					item:item
				}
			);
		}
		
		/**
		 * 
		 * @param	item		The name or ID of the item
		 */
		public function itemFailed(item:String):void {
			call(
				SpilTrackEvent.BUSSINESS_ITEM_FAILED,
				{
					item:item
				}
			);
		}
		
		
		
		
		/**
		 * 
		 * @param	obj
		 */
		public function __custom(obj:Object):void {
			call(SpilTrackEvent.BUSSINESS_CUSTOM, obj);
		}
	}
}

/**
 * This class reinforces the Singleton Pattern
 */ 
internal class Private{}