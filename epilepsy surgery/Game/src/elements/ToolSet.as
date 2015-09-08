package src.elements
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import src.game.SpilAPIManager;


	public class ToolSet extends MovieClip
	{
		public function ToolSet()
		{
			stop();
		}
		
		override public function gotoAndStop(frame:Object ,scene:String = null):void 
		{
			super.gotoAndStop(frame, scene);
			if(SpilAPIManager.sharedSpilAPI().isApiReady())
			{
				if(textBox1 != null)
				{
					SpilAPIManager.sharedSpilAPI().localizeTextField(textBox1);
				}
			}
		}
	}
}
