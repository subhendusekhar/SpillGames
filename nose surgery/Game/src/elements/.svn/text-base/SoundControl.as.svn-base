package src.elements
{

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import src.game.SoundManager;
	import src.game.PlayerData;

	public class SoundControl extends MovieClip
	{
		public function SoundControl()
		{
			buttonMusic.addEventListener(MouseEvent.CLICK, musicCycle);
			buttonSound.addEventListener(MouseEvent.CLICK, soundCycle);
			buttonMusic.addEventListener(MouseEvent.MOUSE_OVER, mOver);
			buttonSound.addEventListener(MouseEvent.MOUSE_OVER, mOver);
			
			mcMusic.mouseEnabled = false;
			mcSound.mouseEnabled = false;
			
			if (PlayerData.sharedData().getMusicMute())
			{
				mcMusic.gotoAndStop(2);
			}
			else
			{
				mcMusic.gotoAndStop(1);
			}

			if (PlayerData.sharedData().getSoundMute())
			{
				mcSound.gotoAndStop(2);
			}
			else
			{
				mcSound.gotoAndStop(1);
			}
		}
		public function musicCycle(e:MouseEvent):void
		{
			SoundManager.sharedManager().playSound(new SND_ClickOption());
			if (PlayerData.sharedData().getMusicMute())
			{
				PlayerData.sharedData().setMusicMute(false);
				mcMusic.gotoAndStop(1);
			}
			else
			{
				PlayerData.sharedData().setMusicMute(true);
				mcMusic.gotoAndStop(2);
			}
		}
		public function soundCycle(e:MouseEvent):void
		{
			SoundManager.sharedManager().playSound(new SND_ClickOption());
			if (PlayerData.sharedData().getSoundMute())
			{
				PlayerData.sharedData().setSoundMute(false);
				mcSound.gotoAndStop(1);
			}
			else
			{
				PlayerData.sharedData().setSoundMute(true);
				mcSound.gotoAndStop(2);
			}
		}
		
		public function mOver(ev:MouseEvent)
		{
			SoundManager.sharedManager().playSound(new SND_OverOption());
		}
		public function updateStatus():void
		{
			if (PlayerData.sharedData().getSoundMute())
			{
				mcSound.gotoAndStop(2);
			}
			else
			{
				mcSound.gotoAndStop(1);
			}
			
			if (PlayerData.sharedData().getMusicMute())
			{
				mcMusic.gotoAndStop(2);
			}
			else
			{
				mcMusic.gotoAndStop(1);
			}
		}
	}
}
