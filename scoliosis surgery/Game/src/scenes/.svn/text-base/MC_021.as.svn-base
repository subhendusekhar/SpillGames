package src.scenes {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import src.game.GameLogic;
	import src.game.SurgeryStep;
	
	
	public class MC_021 extends SurgeryStep {
		
		private var touched1:Boolean = false;
		private var touched2:Boolean = false;
		private var touched3:Boolean = false;
		
		public function MC_021() {
			touch1A.addEventListener(MouseEvent.MOUSE_MOVE, touchArea1);
			touch2B.addEventListener(MouseEvent.MOUSE_MOVE, touchArea2);
			touch3C.addEventListener(MouseEvent.MOUSE_MOVE, touchArea3);
			tongsWithWetCotton.mouseEnabled = false;
			tongsWithWetCotton.mouseChildren = false;
			scheduleForUpdate();
		}
		
		private function touchArea1(ev:MouseEvent)
		{
			if(!touched1)
			{
				touched1 = true;
				wipe1A.play();
			}
		}
		
		private function touchArea2(ev:MouseEvent)
		{
			if(!touched2)
			{
				touched2 = true;
				wipe2B.play();
			}
		}
		
		private function touchArea3(ev:MouseEvent)
		{
			if(!touched3)
			{
				touched3 = true;
				wipe3C.play();
			}
		}
		
		override public function update()
		{
			this.stop();
			if(wipe1A.currentFrame == wipe1A.totalFrames &&
			   wipe2B.currentFrame == wipe2B.totalFrames &&
			   wipe3C.currentFrame == wipe3C.totalFrames )
			{
				GameLogic.sharedGameLogic().showSceneByName(getProperties().nextSceneName);
			}
		}
	}
	
}