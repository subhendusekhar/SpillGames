﻿package src.scenes {		import flash.display.MovieClip;	import src.game.SurgeryStep;			public class MC_15 extends SurgeryStep {						public function MC_15() {			stop();			scheduleForUpdate();		}				override public function update()		{			if(slider2.reachedXPortion >= 31)			{				unscheduleForUpdate();				slider2.unscheduleForUpdate();				this.removeChild(slider2);				this.play();			}		}	}	}