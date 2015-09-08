package src.game
{
	import flash.media.SoundTransform;
	import flash.media.SoundChannel;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import src.GLP.GMGDebugger;
	import flash.media.Sound;
	import flash.events.Event;

	public class SoundManager
	{
		// Singleton variable
		private static var g_sharedManager = null;

		private var m_soundPlayList:Array = new Array();
		private var m_musicPlayList:Array = new Array();

		// Volume temp var
		private var m_musicVolumeTemp:Number = 1;
		private var m_soundVolumeTemp:Number = 1;

		// Sound player status
		private var m_musicMuted:Boolean = false;
		private var m_soundMuted:Boolean = false;

		// Sound transform
		private var m_musicTransformer:SoundTransform = new SoundTransform();
		private var m_soundTransformer:SoundTransform = new SoundTransform();

		// Sound transform
		private var m_musicChannel:SoundChannel = new SoundChannel();
		private var m_soundChannel:SoundChannel = new SoundChannel();
		
		private var m_currentMusic:String = "";

		public function SoundManager()
		{
		}

		public static function sharedManager():SoundManager
		{
			if (g_sharedManager == null)
			{
				g_sharedManager = new SoundManager();
			}
			return g_sharedManager;
		}

		// Sound control
		public function playSound(sound:GMGSound, loops:int = 0):SoundChannel
		{
			var soundChannel = sound.play(0,loops,m_soundTransformer);
			soundChannel.addEventListener(Event.SOUND_COMPLETE, soundCleanup);
			m_soundPlayList.push(soundChannel);
			return soundChannel;
		}
		
		public function stopSound(sound:SoundChannel)
		{
			for(var i:int = 0; i < m_soundPlayList.length; i++)
			{
				if(m_soundPlayList[i] == sound)
				{
					m_soundPlayList[i].stop();
					m_soundPlayList.splice(i, 1);
				}
			}
		}
		
		public function soundCleanup(ev:Event)
		{
			stopSound(SoundChannel(ev.target));
		}

		// Music control
		public function playMusic(music:GMGSound, loops:int = int.MAX_VALUE)
		{
			if (m_musicPlayList.length == 1)
			{
				if (m_currentMusic == getQualifiedClassName(music))
				{
					//GMGDebugger.traceString("Music track " + getQualifiedClassName(music) + " is already playing.");
					return;
				}
				m_musicPlayList[0].stop();
				m_musicPlayList.pop();
			}
			else if (m_musicPlayList.length > 1)
			{
				GMGDebugger.traceString("Something's wrong. There shouldn't be more than 1 music files in the playlist.");
			}
			
			m_currentMusic = getQualifiedClassName(music);
			
			var musicChannel = music.play(0,loops,m_musicTransformer);
			m_musicPlayList.push(musicChannel);
		}
		
		public function stopMusic()
		{
			if (m_musicPlayList.length == 1)
			{
				m_musicPlayList[0].stop();
				m_musicPlayList.pop();
			}
			else if(m_musicPlayList.length > 1)
			{
				GMGDebugger.traceString("Something's wrong. There shouldn't be more than 1 music files in the playlist.");
			}
			else
			{
				GMGDebugger.traceString("No music to stop.");
			}
		}

		// Music volume control
		public function setMusicVolume(volumePercent:Number)
		{
			m_musicMuted = false;
			if (volumePercent <= 0)
			{
				muteMusic(true);
			}
			else
			{
				m_musicTransformer.volume = volumePercent;
				updateAllMusic();
			}
		}

		public function muteMusic(mute:Boolean)
		{
			m_musicMuted = mute;
			if (m_musicMuted)
			{
				m_musicVolumeTemp = m_musicTransformer.volume;
				m_musicTransformer.volume = 0;
				m_musicMuted = true;
			}
			else
			{
				m_musicTransformer.volume = m_musicVolumeTemp;
				m_musicMuted = false;
			}

			updateAllMusic();
		}

		private function updateAllMusic()
		{
			for (var i:int = 0; i < m_musicPlayList.length; i++)
			{
				if (m_musicPlayList[i] != null)
				{
					m_musicPlayList[i].soundTransform = m_musicTransformer;
				}
			}
		}

		// Sound volume control
		public function setSoundVolume(volumePercent:Number)
		{
			m_soundMuted = false;
			if (volumePercent <= 0)
			{
				muteSound(true);
			}
			else
			{
				m_soundTransformer.volume = volumePercent;
				updateAllSounds();
			}
		}

		public function muteSound(mute:Boolean)
		{
			m_soundMuted = mute;
			if (m_soundMuted)
			{
				m_soundVolumeTemp = m_soundTransformer.volume;
				m_soundTransformer.volume = 0;
				m_soundMuted = true;
			}
			else
			{
				m_soundTransformer.volume = m_soundVolumeTemp;
				m_soundMuted = false;
			}

			updateAllSounds();
		}
		private function updateAllSounds()
		{
			for (var i:int = 0; i < m_soundPlayList.length; i++)
			{
				if (m_soundPlayList[i] != null)
				{
					m_soundPlayList[i].soundTransform = m_soundTransformer;
				}
			}
		}
	}
}
