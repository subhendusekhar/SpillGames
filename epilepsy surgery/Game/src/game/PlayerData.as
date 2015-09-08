﻿package src.game
{
	import flash.net.SharedObject;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Stage;

	public class PlayerData
	{
		//Singleton
		private static var g_sharedData:PlayerData = null;
		// Current game sesion
		private var m_gameSesion:SharedObject;
		
		public static const HIGH_QUALITY:int = 0;
		public static const MED_QUALITY:int = 1;
		public static const LOW_QUALITY:int = 2;
		
		private var m_noBlood:Boolean = false;
		
		public function PlayerData()
		{			
		}
		
		public function setNoBlood(value:Boolean)
		{
			m_noBlood = value;
		}
		
		public function getNoBlood():Boolean
		{
			return m_noBlood;//m_gameSesion.data.noBloodMode;
		}
		
		public static function sharedData():PlayerData
		{
			if(g_sharedData == null)
			{
				g_sharedData = new PlayerData();
				g_sharedData.setGameSesion(SharedObject.getLocal("EpilepsySurgery"));
				SpilAPIManager.sharedSpilAPI();
			}
			return g_sharedData;
		}
		public function setGameSesion(sesion:SharedObject)
		{
			if(m_gameSesion != null)
			{
				m_gameSesion.data.active = false;
			}
			
			m_gameSesion = sesion;
			m_gameSesion.data.active = true;
			
			if(m_gameSesion.data.soundMute == null)
			{
				m_gameSesion.data.soundMute = false;
			}
			
			if(m_gameSesion.data.musicMute == null)
			{
				m_gameSesion.data.musicMute = false;
			}
			
			if(m_gameSesion.data.timesCompleted == null)
			{
				m_gameSesion.data.timesCompleted = 0;
			}
			
			if(m_gameSesion.data.noBloodMode == null)
			{
				m_gameSesion.data.noBloodMode = false;
			}
			
			if(m_gameSesion.data.qualityLevel == null)
			{
				m_gameSesion.data.qualityLevel = HIGH_QUALITY;
			}
			
			setSoundMute(m_gameSesion.data.soundMute);
			setMusicMute(m_gameSesion.data.musicMute);
		}
			
		public function getGameSesion():SharedObject
		{
			return m_gameSesion;
		}
		
		public function getSoundMute():Boolean
		{
			return m_gameSesion.data.soundMute;
		}
		
		public function getMusicMute():Boolean
		{
			return m_gameSesion.data.musicMute;
		}
		
		public function setSoundMute(mute:Boolean)
		{
			m_gameSesion.data.soundMute = mute;
			SoundManager.sharedManager().muteSound(mute);
		}
		
		public function setMusicMute(mute:Boolean)
		{
			m_gameSesion.data.musicMute = mute;
			SoundManager.sharedManager().muteMusic(mute);
		}
		
		public function getTimesCompleted():int
		{
			return m_gameSesion.data.timesCompleted;
		}
		
		public function addTimesCompleted(ammount:int = 1)
		{
			m_gameSesion.data.timesCompleted += ammount;
		}
		
		public function setStageQuality(stage:Stage, quality:int)
		{
			m_gameSesion.data.qualityLevel = quality;
			switch(quality)
			{
				case HIGH_QUALITY:
					stage.quality = "high";
					break;
				case MED_QUALITY:
					stage.quality = "medium";
					break;
				case LOW_QUALITY:
					stage.quality = "low";
					break;
			}
		}
		
		public function getQuality():int
		{
			return m_gameSesion.data.qualityLevel;
		}
		
		public function gotoNextQualityOnStage(stage:Stage)
		{
			switch(getQuality())
			{
				case HIGH_QUALITY:
					setStageQuality(stage, MED_QUALITY);
					break;
				case MED_QUALITY:
					setStageQuality(stage, LOW_QUALITY);
					break;
				case LOW_QUALITY:
					setStageQuality(stage, HIGH_QUALITY);
					break;
			}
		}
		
		public function isTest():Boolean
		{
			return false;
		}
		
		public function getGameVersion():String
		{
			return "v1.01";
		}
	}
}
