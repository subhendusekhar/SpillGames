﻿package src.scenes {		import flash.display.MovieClip;	import src.game.SurgeryStep;	import src.game.SoundManager;			public class MC_22C extends SurgeryStep {						public function MC_22C() {			SoundManager.sharedManager().playSound(new SND_UseCauterizer());		}	}	}