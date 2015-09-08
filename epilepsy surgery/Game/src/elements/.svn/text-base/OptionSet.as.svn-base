package src.elements
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import src.GLP.GLPScene;
	import src.GLP.AnimationList;
	import src.game.GameLogic;
	import src.game.SurgeryStep;
	import src.GLP.GMGDebugger;
	import src.game.SoundManager;

	public class OptionSet extends GLPScene
	{
		private var m_inited:Boolean = false;
		private var m_delete:Boolean = false;
		private var m_loadComplete:Boolean = false;
		
		private var m_callingScene = "";

		public function OptionSet(callingScene:String)
		{
			stop();
			scheduleForUpdate();
			m_callingScene = callingScene;
		}

		override public function update()
		{
			if(!animate())
			{
				if(m_delete)
				{
					this.parent.removeChild(this);
					this.unscheduleForUpdate();
				}
				else
				{
					if (GameLogic.sharedGameLogic().getCurrentSceneName().indexOf(m_callingScene) < 0)
					{
						this.setAnimation(AnimationList.HIDE_TO_BOTTOM);

						this.mouseEnabled = false;
						this.mouseChildren = false;
						m_delete = true;
					}
				}
			}
			
			if(GameLogic.sharedGameLogic().getCurrentSceneName().indexOf(m_callingScene) > 0)
			{
				m_loadComplete = true;
			}
		}

		public function init(correctOption:String)
		{
			setAnimation(AnimationList.SHOW_FROM_BOTTOM);
			var randomOption:uint = int(Math.random() * 6);
			var alreadySelectedTools:Array = new Array();

			var optionClip = this.getChildByName("option_" + randomOption);
			var textClip = this.getChildByName("text_" + randomOption);
			
			textClip.gotoAndStop(correctOption);
			textClip.mouseEnabled = false;
			textClip.mouseChildren = false;
			optionClip.addEventListener(MouseEvent.CLICK, correctChoice);
			optionClip.addEventListener(MouseEvent.MOUSE_OVER, optionOver);

			alreadySelectedTools.push(textClip.currentFrame);

			for (var i:uint = 0; i < 6; i++)
			{
				if (i != randomOption)
				{
					optionClip = this.getChildByName("option_" + i);
					textClip = this.getChildByName("text_" + i);
					var randomTool:int = int(Math.random() * (textClip.totalFrames) + 1);
					while (alreadySelectedTools.indexOf(randomTool) != -1)
					{
						randomTool = int(Math.random() * (textClip.totalFrames) + 1);
					}
					alreadySelectedTools.push(randomTool);
					textClip.gotoAndStop(randomTool);
					textClip.mouseEnabled = false;
					textClip.mouseChildren = false;
					optionClip.addEventListener(MouseEvent.CLICK, wrongChoice);
					optionClip.addEventListener(MouseEvent.MOUSE_OVER, optionOver);
					optionClip.visible = !GMGDebugger.isDebugging();
				}
			}
		}

		public function correctChoice(ev:MouseEvent)
		{
			SoundManager.sharedManager().playSound(new SND_ClickOption());
			var scene:SurgeryStep = GameLogic.sharedGameLogic().getCurrentScene();
			if (scene != null)
			{
				GameLogic.sharedGameLogic().showSceneByName(scene.getProperties().nextSceneName);
			}
		}

		public function wrongChoice(ev:MouseEvent)
		{
			GameLogic.sharedGameLogic().punishPlayer();
			ev.target.visible = false;
			var targetName:String = ev.target.parent.name;
			targetName = targetName.replace("option", "text");
			MovieClip(ev.target.parent.parent.getChildByName(targetName)).tool.visible = false;
			ev.target.mouseEnabled = false;
			ev.target.mouseChildren = false;
		}

		public function optionOver(ev:MouseEvent)
		{
			SoundManager.sharedManager().playSound(new SND_OverOption());
		}
	}

}
