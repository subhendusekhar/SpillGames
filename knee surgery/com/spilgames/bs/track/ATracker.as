package com.spilgames.bs.track
{
	import com.spilgames.bs.BrandingManager;

	public class ATracker
	{
		protected var eventType:String = "custom";
		
		public function custom(event:String, obj:Object):void {
			call(eventType +"." +event, obj);
		}
		
		protected function call(event:String, params:Object = null, forceCall:Boolean = false):void {
			
			BrandingManager.getInstance().trackEvent(event, eventType, params, forceCall);
		}
	}
}