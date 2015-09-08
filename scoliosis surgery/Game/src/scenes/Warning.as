package src.scenes {
	
	import flash.display.MovieClip;
	import src.game.GameLogic;
	import src.game.SurgeryStep;
	import src.GLP.GMGDebugger;
	import src.game.SoundManager;
	import src.game.SpilAPIManager;
	import flash.text.TextFormat;
	import flash.text.TextField;
	import src.game.PlayerData;
	
	public class Warning extends SurgeryStep {
		
		private var m_counter:Number = 0;
		
		public function Warning() {
			scheduleForUpdate();
			
			SpilAPIManager.sharedSpilAPI().localizeTextField(doNotTryText);
			SpilAPIManager.sharedSpilAPI().localizeTextField(warningText);
		}
		
		override public function update()
		{
			m_counter++;
			if(m_counter == 90)
			{
				GameLogic.sharedGameLogic().showSceneByName(getProperties().nextSceneName);
				SoundManager.sharedManager().playSound(new SND_Warning());
			}
		}
	}
}
