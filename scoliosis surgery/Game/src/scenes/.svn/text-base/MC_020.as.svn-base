package src.scenes {
	
	import flash.display.MovieClip;
	import src.game.SurgeryStep;
	import flash.events.MouseEvent;
	
	public class MC_020 extends SurgeryStep {
		
		private var startDip = true;
		private var waitForDip = true;
		
		private var playingDip = false;
		
		public function MC_020() {
			(getChildByName("tongsWithCotton") as MovieClip).gotoAndStop(2);
			scheduleForUpdate();
			tongsWithCotton.mouseEnabled = false;
			tongsWithCotton.mouseChildren = false;
		}
		
		override public function update()
		{
			if(currentFrame == 27)
			{
				if(startDip)
				{
					startDip = false;
					playingDip = false;
					poteConLiquido.addEventListener(MouseEvent.MOUSE_MOVE, dipOver);
					poteConLiquido.addEventListener(MouseEvent.MOUSE_OUT, dipOut);
					stop();
				}
				else
				{
					if(waitForDip)
					{
						if(tongsWithCotton.currentFrame == tongsWithCotton.totalFrames)
						{
							waitForDip = false;
							this.play();
						}
					}
				}
			}
		}
		
		private function dipOver(ev:MouseEvent)
		{
			if(!playingDip)
			{
				playingDip = true;
				tongsWithCotton.play();
			}
		}
		
		private function dipOut(ev:MouseEvent)
		{
			if(playingDip)
			{
				tongsWithCotton.stop();
				playingDip = false;
			}
		}
	}
	
}
