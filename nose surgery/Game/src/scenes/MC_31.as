﻿package src.scenes {		import flash.display.MovieClip;	import src.game.SoundManager;	import src.game.SurgeryStep;			public class MC_31 extends SurgeryStep {				public function MC_31() {			SoundManager.sharedManager().playSound(new SND_UseTweezers());		}	}	}