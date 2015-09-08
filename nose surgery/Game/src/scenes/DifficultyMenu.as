package src.scenes {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import src.game.PlayerData;
	import src.game.GameLogic;
	import src.game.SurgeryStep;
	import src.game.SpilAPIManager;
	
	
	public class DifficultyMenu extends SurgeryStep {
		
		public function DifficultyMenu() 
		{
			playInternDesc.mouseEnabled = false;
			playSpecialistDesc.mouseEnabled = false;
			unlockAvatar.mouseEnabled = false;
			
			SpilAPIManager.sharedSpilAPI().localizeTextField(playInternDesc);
			SpilAPIManager.sharedSpilAPI().localizeTextField(playSpecialistDesc);
			SpilAPIManager.sharedSpilAPI().localizeTextField(unlockAvatar);
			
			playInternBox.addEventListener(MouseEvent.CLICK, playAsIntern);
			playSpecialistBox.addEventListener(MouseEvent.CLICK, playAsSpecialist);
		}
		
		private function playAsIntern(ev:MouseEvent)
		{
			GameLogic.sharedGameLogic().startGame(false, PlayerData.sharedData().getNoBlood());
			ev.target.removeEventListener(MouseEvent.CLICK, playAsIntern);
		}
		
		private function playAsSpecialist(ev:MouseEvent)
		{
			GameLogic.sharedGameLogic().startGame(true, PlayerData.sharedData().getNoBlood());
			ev.target.removeEventListener(MouseEvent.CLICK, playAsSpecialist);
		}
	}
	
}
