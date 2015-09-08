package src.scenes {
	
	import flash.display.MovieClip;
	import src.game.SpilAPIManager;
	import src.game.SurgeryStep;
	
	
	public class MC_001 extends SurgeryStep {
		
		
		public function MC_001() {
			SpilAPIManager.sharedSpilAPI().localizeTextField(storyText);
		}
	}
	
}
