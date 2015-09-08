package src.elements
{

	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import src.GLP.GLPScene;
	import flash.text.TextField;
	import src.game.GameLogic;
	import src.game.GMGSound;
	import src.game.SoundManager;
	import flash.media.SoundChannel;


	public class HeartRateMonitor extends GLPScene
	{
		private var m_healStateCounter:uint;
		private var m_counting:Boolean;
		private var m_seconds:uint;
		private var m_minutes:uint;
		private var m_frameCounter:uint;
		private var m_canContinue:Boolean;
		private var m_started:Boolean;
		private var m_reachedStates:Array = [true, false, false, false];
		private var m_currentSound1:SoundChannel = null;
		private var m_currentSound2:SoundChannel = null;
		private var m_currentSound3:SoundChannel = null;
		
		public function HeartRateMonitor()
		{
			m_counting = false;
			m_seconds = 0;
			m_minutes = 0;
			m_frameCounter = 0;
			m_canContinue = false;
			m_started = false;
			scheduleForUpdate();
			stop();
		}

		public function startCountdown(minutes:uint,seconds:uint)
		{
			m_minutes = minutes;
			m_seconds = seconds;
			m_counting = true;
			m_started = true;
			this.visible = true;
			
			setState(1);
			
			if (m_minutes < 10)
			{
				TextField(getChildByName("time")).text = "0" + m_minutes + ":";
			}
			else
			{
				TextField(getChildByName("time")).text = m_minutes + ":";
			}

			if (m_seconds < 10)
			{
				TextField(getChildByName("time")).appendText("0" + m_seconds);
			}
			else
			{
				TextField(getChildByName("time")).appendText("" + m_seconds);
			}
			//MovieClip(getChildByName("addScore")).gotoAndStop(MovieClip(getChildByName("addScore")).totalFrames);
		}
		public function pauseCountdown()
		{
			this.stop();
			m_counting = false;
			this.visible = false;
		}
		public function continueCountdown()
		{
			this.play();
			m_counting = true;
			this.visible = true;
		}
		override public function update()
		{
			//TextField(getChildByName("score")).text = "" + GameLogic.sharedGameLogic().getScore();
			if (m_counting && m_frameCounter == 30)
			{
				if (this.currentFrame != 4)
				{
					if (m_seconds == 0 && m_minutes == 0)
					{
						m_counting = false;
						m_canContinue = false;
						GameLogic.sharedGameLogic().gameOver();
						GameLogic.sharedGameLogic().setOverByTime(true);
					}
					else
					{
						if (this.currentFrame > 1)
						{
							if (m_healStateCounter > 0)
							{
								m_healStateCounter--;
							}
							else
							{
								setState(this.currentFrame - 1);
								m_healStateCounter = 10;
							}
						}
						if ((m_seconds - 1) < 0)
						{
							m_seconds = 59;
							m_minutes--;
						}
						else
						{
							m_seconds--;
						}
						if (m_minutes < 10)
						{
							TextField(getChildByName("time")).text = "0" + m_minutes + ":";
						}
						else
						{
							TextField(getChildByName("time")).text = m_minutes + ":";
						}

						if (m_seconds < 10)
						{
							TextField(getChildByName("time")).appendText("0" + m_seconds);
						}
						else
						{
							TextField(getChildByName("time")).appendText("" + m_seconds);
						}
					}
				}
			}
			if(m_frameCounter == 30)
			{
				m_frameCounter = 0;
			}
			else
			{
				m_frameCounter++;
			}
		}
		
		public function isCounting():Boolean
		{
			return m_counting;
		}
		
		public function isStarted():Boolean
		{
			return m_started;
		}
		
		public function setState(state:uint)
		{
			stopSounds();
			
			switch(state)
			{
				case 1:
					if(m_currentSound1 == null)
					{
						m_currentSound1 = SoundManager.sharedManager().playSound(new SND_HRM_Normal, int.MAX_VALUE);
					}
					break;
				case 2:
					if(m_currentSound2 == null)
					{
						m_currentSound2 = SoundManager.sharedManager().playSound(new SND_HRM_Sick, int.MAX_VALUE);
					}
					break;
				case 3:
					if(m_currentSound3 == null)
					{
						m_currentSound3 = SoundManager.sharedManager().playSound(new SND_HRM_Danger, int.MAX_VALUE);
					}
					break;
				case 4:
					break;
			}
			
			gotoAndStop(state);
			m_reachedStates[state] = true;
			m_healStateCounter = 10;
		}
		
		public function getState()
		{
			return this.currentFrame;
		}
		
		public function gotoNextState()
		{
			if(m_started)
			{
				if(this.currentFrame + 1 <= this.totalFrames)
				{
					setState(this.currentFrame + 1);
					if(this.currentFrame == 4)
					{
						m_canContinue = false;
						m_counting = false;
					}
				}
			}
		}
		
		public function getMinutes():uint
		{
			return m_minutes;
		}
		
		public function getSeconds():uint
		{
			return m_seconds;
		}
		
		public function addTime(minutes:uint,seconds:uint)
		{
			m_minutes +=  minutes;
			m_seconds +=  seconds;
		}
		
		public function canContinue():Boolean
		{
			return m_canContinue;
		}
		
		public function restart()
		{
			this.visible = false;
			m_counting = false;
			m_started = false;
			m_seconds = 0;
			m_minutes = 0;
			m_frameCounter = 0;
			m_canContinue = true;
			gotoAndStop(1);
			
			m_reachedStates[0] = true;
			m_reachedStates[1] = false;
			m_reachedStates[2] = false;
			m_reachedStates[3] = false;
			
			stopSounds();
		}
		
		public function stopSounds()
		{
			if(m_currentSound1 != null)
			{
				SoundManager.sharedManager().stopSound(m_currentSound1);
				m_currentSound1 = null;
			}
			if(m_currentSound2 != null)
			{
				SoundManager.sharedManager().stopSound(m_currentSound2);
				m_currentSound2 = null;
			}
			if(m_currentSound3 != null)
			{
				SoundManager.sharedManager().stopSound(m_currentSound3);
				m_currentSound3 = null;
			}
		}
		
		//public function showScoreAnimation()
		//{
			//MovieClip(getChildByName("addScore")).gotoAndPlay(1);
		//}
		
		public function isStateReached(state:int):Boolean
		{
			return m_reachedStates[state];
		}
		
		public function setCanContinue(value:Boolean)
		{
			m_canContinue = value;
		}
	}

}
