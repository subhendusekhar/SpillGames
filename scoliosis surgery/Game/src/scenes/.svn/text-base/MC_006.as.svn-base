package src.scenes {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import src.game.GameLogic;
	import src.game.SurgeryStep;
	
	public class MC_006 extends SurgeryStep {
		
		public function MC_006() {
			doora0.button.addEventListener(MouseEvent.CLICK, wrongAnswer);
			doora1.button.addEventListener(MouseEvent.CLICK, wrongAnswer);
			doora2.button.addEventListener(MouseEvent.CLICK, correctAnswer);
			wrong0.mouseEnabled = false;
			wrong0.mouseChildren = false;
			wrong0.visible = false;
			wrong1.mouseEnabled = false;
			wrong1.mouseChildren = false;
			wrong1.visible = false;
			stop();
		}
		
		private function wrongAnswer(ev:MouseEvent)
		{
			GameLogic.sharedGameLogic().punishPlayer();
			if(ev.target == doora0.button)
			{
				wrong0.visible = true;
				doora0.removeEventListener(MouseEvent.CLICK, wrongAnswer);
				doora0.mouseEnabled = false;
				doora0.mouseChildren = false;
			}
			if(ev.target == doora1.button)
			{
				wrong1.visible = true;
				doora1.removeEventListener(MouseEvent.CLICK, wrongAnswer);
				doora1.mouseEnabled = false;
				doora1.mouseChildren = false;
			}
		}
		
		private function correctAnswer(ev:MouseEvent)
		{
			ev.target.removeEventListener(MouseEvent.CLICK, correctAnswer);
			GameLogic.sharedGameLogic().showSceneByName(getProperties().nextSceneName);
			doora2.mouseEnabled = false;
			doora2.mouseChildren = false;
		}
	}
	
}
