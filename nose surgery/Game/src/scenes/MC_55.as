﻿package src.scenes {		import flash.display.MovieClip;	import src.game.SurgeryStep;	import src.game.SoundManager;			public class MC_55 extends SurgeryStep {						public function MC_55() {			SoundManager.sharedManager().playSound(new SND_UseOsteotome());		}	}	}