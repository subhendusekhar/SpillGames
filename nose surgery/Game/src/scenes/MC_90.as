﻿package src.scenes {		import flash.display.MovieClip;	import src.game.SoundManager;	import src.game.SurgeryStep;			public class MC_90 extends SurgeryStep {						public function MC_90() {			SoundManager.sharedManager().playSound(new SND_UseBandage());		}	}	}