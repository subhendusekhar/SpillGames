﻿package src.scenes {
	
	import flash.display.MovieClip;
	import src.game.SurgeryStep;
	import src.game.GameLogic;
	
	public class MC_016 extends SurgeryStep
	{
		var contador:Number;
		public function MC_016() {
			contador = 0;
			
			if(GameLogic.sharedGameLogic().isHardMode())
			{
				scheduleForUpdate();
			}
		}
		
		override public function update()
		{
			contador = contador + 1;
			if(contador == 60)
			{
				//pasa a siguiente escena
				GameLogic.sharedGameLogic().showSceneByName(getProperties().nextSceneName);
			}
		}
	}
}