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
		private var m_start:Boolean = false;
		private var m_showAd:Boolean = true;
		private var m_sMute:Boolean = false;
		private var m_mMute:Boolean = false;
		
		public function Warning() {
			scheduleForUpdate();
			
			SpilAPIManager.sharedSpilAPI().localizeTextField(doNotTryText);
			SpilAPIManager.sharedSpilAPI().localizeTextField(warningText);
		}
		
		override public function update()
		{
			
			GameLogic.sharedGameLogic().showSceneByName(getProperties().nextSceneName);
			return;
			if(m_showAd)
			{
				SpilAPIManager.sharedSpilAPI().navigateToOnGameAd();
				m_showAd = false;
			}
			else if(m_start)
			{
				m_counter++;
				if(m_counter == 90)
				{
					GameLogic.sharedGameLogic().showSceneByName(getProperties().nextSceneName);
				}
			}
		}
		
		override public function pauseScene():void
		{
			m_start = false;
			m_sMute = PlayerData.sharedData().getSoundMute();
			m_mMute = PlayerData.sharedData().getMusicMute();
			
			if(!m_sMute)
			{
				PlayerData.sharedData().setSoundMute(true);
			}
			if(!m_mMute)
			{
				PlayerData.sharedData().setMusicMute(true);
			}
		}
		
		override public function continueScene():void
		{
			m_start = true;
			if(m_sMute != PlayerData.sharedData().getSoundMute())
			{
				PlayerData.sharedData().setSoundMute(m_sMute);
			}
			if(m_mMute != PlayerData.sharedData().getMusicMute())
			{
				PlayerData.sharedData().setMusicMute(m_mMute);
			}
		}
	}
}