package src.game
{
	import src.GLP.AnimationList;
	import src.elements.SoundControl;
	import src.GLP.GLPScene;
	import flash.utils.getDefinitionByName;
	import flash.geom.Rectangle;
	import src.elements.OptionSet;
	import src.elements.NurseMessages;
	import src.elements.HeartRateMonitor;
	import src.GLP.GLPDirector;
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import src.elements.PointerButton;
	import flash.utils.getQualifiedClassName;
	import src.GLP.GMGDebugger;
	import src.elements.PunishMessage;

	import src.GLP.Analytics;
	import com.spilgames.bs.BrandingManager;
	import src.scenes.GameOverMenu;

	public class GameLogic
	{
		public static const SURGERY_DURATION_MINUTES:uint = 5;
		public static const SURGERY_DURATION_SECONDS:uint = 0;

		private static var g_gameLogic;

		private var m_gameContainer:GLPScene;

		private var m_playing:Boolean;
		private var m_started:Boolean;

		private var m_hardMode:Boolean;
		private var m_noBloodMode:Boolean;

		private var m_currentScene:SurgeryStep;
		private var m_currentSceneName:String;
		private var m_nextScene:SurgeryStep;

		private var m_reviveScene:String;
		private var m_canRevive:Boolean;

		private var m_mistakes:int;

		private var m_alreadyCalled:Boolean;

		private var m_timesCompleted:int;

		private static var g_sharedMessageBox:NurseMessages = null;
		private static var g_sharedHRM:HeartRateMonitor = null;

		private var m_overByTime:Boolean;

		public function GameLogic()
		{
			m_timesCompleted = 0;
			g_gameLogic = null;
			m_gameContainer = null;
			m_playing = true;
			m_started = false;
			m_currentScene = null;
			m_nextScene = null;
			m_overByTime = false;

			m_hardMode = false;
			m_noBloodMode = false;

			m_alreadyCalled = false;

			g_sharedMessageBox = new NurseMessages();
			g_sharedHRM = new HeartRateMonitor();
		}

		public function getCurrentSceneName():String
		{
			return m_currentSceneName;
		}

		public function getNextScene():GLPScene
		{
			return m_nextScene;
		}

		public static function sharedGameLogic():GameLogic
		{
			if (g_gameLogic == null)
			{
				g_gameLogic = new GameLogic();
			}
			return g_gameLogic;
		}

		public function setContainer(container:GLPScene)
		{
			m_gameContainer = container;
		}

		public function getContainer():GLPScene
		{
			return m_gameContainer;
		}

		public function startGame(hardMode:Boolean, noBloodMode:Boolean)
		{
			m_mistakes = 0;
			m_started = true;
			m_hardMode = hardMode;
			m_noBloodMode = noBloodMode;
			m_canRevive = true;
			g_sharedHRM.restart();
			showSceneByName("src.scenes.Warning");
		}
		
		public function restart()
		{
			g_sharedHRM.restart();
		}

		public function revive()
		{
			if (m_canRevive)
			{
				m_canRevive = false;
				g_sharedHRM.setState(1);
				g_sharedHRM.setCanContinue(true);
				g_sharedHRM.continueCountdown();
			}
		}

		public function getReviveSceneName():String
		{
			return m_reviveScene;
		}

		public function continueGame()
		{
			g_sharedHRM.continueCountdown();
		}

		public function pauseGame()
		{
			g_sharedHRM.pauseCountdown();
		}

		public function endGame()
		{
			if (m_started)
			{
				if(m_hardMode)
				{
					Analytics.CustomMetric("hard mode completed");
				}
				else
				{
					Analytics.CustomMetric("normal mode completed");
				}
				m_started = false;
				m_timesCompleted++;
				PlayerData.sharedData().addTimesCompleted();
				g_sharedHRM.pauseCountdown();
				g_sharedHRM.stopSounds();
				SoundManager.sharedManager().playSound(new MUS_Complete());
				//SoundManager.sharedManager().playSound(new SND_Success());
			}
		}

		public function update()
		{
			if (m_playing)
			{
				var animating:Boolean = false;
				// Check if current scene is being animated
				if (m_currentScene != null)
				{
					if (m_currentScene.animate())
					{
						animating = true;
						if (! m_gameContainer.contains(m_currentScene))
						{
							m_gameContainer.addChild(m_currentScene);
							m_currentScene.onEnter();
						}
					}
				}
				// Check if next scene is animating
				if (m_nextScene != null)
				{
					if (m_nextScene.animate())
					{
						animating = true;
						if (! m_gameContainer.contains(m_nextScene))
						{
							m_gameContainer.addChild(m_nextScene);
							m_nextScene.onEnter();
							m_nextScene.scrollRect = new Rectangle(0,0,700,510);
						}
					}
				}

				// Change current scene to next scene only if neither of them is being animated
				if (m_nextScene != null && ! animating)
				{
					if (m_currentScene != null)
					{
						if (m_gameContainer.contains(m_currentScene))
						{
							m_gameContainer.removeChild(m_currentScene);
							m_currentScene.unscheduleForUpdate();
							m_currentScene.onExit();
						}
					}

					if (! m_gameContainer.contains(m_nextScene))
					{
						m_gameContainer.addChild(m_nextScene);
						m_nextScene.onEnter();
						m_nextScene.scrollRect = new Rectangle(0,0,700,510);
					}
					addMantainedElement(m_nextScene);
					if(m_currentScene != null)
					{
						SpilAPIManager.sharedSpilAPI().removeOnLocaleChangedEvent(m_nextScene.updateTexts);
					}
					m_currentScene = m_nextScene;
					SpilAPIManager.sharedSpilAPI().addOnLocaleChangedEvent(m_currentScene.updateTexts);
					m_nextScene = null;
					m_alreadyCalled = false;
				}

				if (m_currentScene != null
				   && m_currentScene.totalFrames > 1 
				   && m_currentScene.currentFrame == m_currentScene.totalFrames
				   && !m_alreadyCalled)
				{
					m_currentScene.stop();
					m_alreadyCalled = true;
					g_sharedMessageBox.setContinueButtonVisible(false);
					if (m_currentScene.getProperties().gotoNextOnLastFrame)
					{
						showSceneByName(m_currentScene.getProperties().nextSceneName);
					}
					else if (m_currentScene.getProperties().forceContinueButtonVisible)
					{
						g_sharedMessageBox.setContinueButtonVisible(true);
					}
				}
			}
			if(m_currentScene != null)
			{
				m_currentScene.updateSounds();
			}
		}

		public function showSceneByName(sceneName:String, forceTransition:Boolean = false)
		{
			if (sceneName == null)
			{
				GMGDebugger.traceString("Scene called at " + getQualifiedClassName(m_currentScene) + " can't be null.");
				return;
			}
			if (sceneName == "")
			{
				GMGDebugger.traceString("Scene name at " + getQualifiedClassName(m_currentScene) + " field can't be empty.");
				return;
			}

			var ClassReference:Class;
			try
			{
				ClassReference = getDefinitionByName(sceneName) as Class;
			}
			catch (err:Error)
			{
				GMGDebugger.traceString("Symbol of name " + sceneName + " called at " + getQualifiedClassName(m_currentScene) + " does not exist.");
				return;
			}
			var object:Object = new ClassReference();

			if (object is SurgeryStep)
			{
				var scene:SurgeryStep = SurgeryStep(object);
				if (m_nextScene == null)
				{
					m_nextScene = getValidScene(scene);
					setSceneTransition(m_nextScene, forceTransition);
					setSceneOptions(m_nextScene);
					setSceneTextBox(m_nextScene);
					setSceneHRM(m_nextScene);
					setSceneDrag(m_nextScene);
					setSceneMusic(m_nextScene);
					hideNoBloodElements(m_nextScene);

					m_currentSceneName = getQualifiedClassName(m_nextScene);
				}
				else
				{
					GMGDebugger.traceString("Scene " + getQualifiedClassName(m_nextScene) + " is waiting to be loaded. Can't load another one.");
				}
			}
			else
			{
				GMGDebugger.traceString("Scene " + sceneName + " MUST be of SurgeryStep type. Extend it from it instead of MovieClip.");
			}
		}

		private function getValidScene(scene:SurgeryStep):SurgeryStep
		{
			var validScene:SurgeryStep = scene;
			var shouldCheck;
			var hasTransition:Boolean = false;
			if (scene.getProperties().hasTransition)
			{
				hasTransition = true;
			}

			do
			{
				shouldCheck = false;
				if ((m_hardMode && validScene.getProperties().skipOnHardMode) || (m_noBloodMode && validScene.getProperties().skipOnNoBlood))
				{
					var ClassReference:Class;
					try
					{
						ClassReference = getDefinitionByName(validScene.getProperties().nextSceneName) as Class;
						var scene = new ClassReference();
						if (scene is SurgeryStep)
						{
							shouldCheck = true;
							validScene = scene;
							if (scene.getProperties().hasTransition)
							{
								hasTransition = true;
							}
						}
						else
						{
							GMGDebugger.traceString("Scene " + getQualifiedClassName(scene) + " MUST be of SurgeryStep type. Extend it from it instead of MovieClip.");
						}
					}
					catch (err:Error)
					{
						GMGDebugger.traceString("Symbol of name " + validScene.getProperties().nextSceneName + " called at " + getQualifiedClassName(validScene) + " does not exist.");
					}
				}
			} while (shouldCheck);
			scene.getProperties().hasTransition = hasTransition;
			return scene;
		}

		public function setSceneTransition(scene:SurgeryStep, forceTransition:Boolean = false)
		{
			if (! forceTransition)
			{
				var hasTransition = false;
				if (scene != null)
				{
					hasTransition = scene.getProperties().hasTransition;
				}

				if (hasTransition)
				{
					SoundManager.sharedManager().playSound(new interlude());
					scene.setAnimation(AnimationList.getAnimationByName("SHOW_FROM_RIGHT"));
					if (m_currentScene != null)
					{
						m_currentScene.setAnimation(AnimationList.getAnimationByName("HIDE_TO_LEFT"));
					}
				}
			}
			else
			{
				SoundManager.sharedManager().playSound(new interlude());
				scene.setAnimation(AnimationList.getAnimationByName("SHOW_FROM_RIGHT"));
				if (m_currentScene != null)
				{
					m_currentScene.setAnimation(AnimationList.getAnimationByName("HIDE_TO_LEFT"));
				}
			}
		}
		private function setSceneOptions(scene:SurgeryStep)
		{
			if (scene.getProperties().hasOptions)
			{
				var optionSet:OptionSet = new OptionSet(getQualifiedClassName(scene).split("::")[1]);

				m_gameContainer.parent.addChild(optionSet);

				optionSet.init(scene.getProperties().correctAnswer);
			}
		}
		private function setSceneTextBox(scene:SurgeryStep)
		{
			if (scene.getProperties().hasText)
			{
				if (scene.getProperties().text == "")
				{
					scene.getProperties().text = "{" + getQualifiedClassName(scene).split("::")[1] + "}";
				}
				
				
				if(scene.getProperties().startHRM)
				{
					if(scene.getProperties().hasOptions || scene.getProperties().forceMessageOnTop)
					{
						g_sharedMessageBox.setWidth(380);
						g_sharedMessageBox.x = 350;
					}
					else
					{
						g_sharedMessageBox.setWidth(520);
						g_sharedMessageBox.x = 200;
					}
				}
				else
				{
					g_sharedMessageBox.setWidth(520);
					g_sharedMessageBox.x = 200;
				}
				
				g_sharedMessageBox.visible = true;
				showMessageBox(scene.getProperties().text);
				
				if (isHardMode() && ! scene.getProperties().forceMessageOnHard)
				{
					g_sharedMessageBox.visible = false;
				}
				if (scene.getProperties().forceMessageOnTop)
				{
					g_sharedMessageBox.y = 70;
				}
				else if (scene.getProperties().hasOptions)
				{
					g_sharedMessageBox.y = 70;
					g_sharedMessageBox.setContinueButtonVisible(false);
				}
				else if (scene.totalFrames > 1)
				{
					g_sharedMessageBox.y = 430;
					g_sharedMessageBox.setContinueButtonVisible(false);
				}
				else
				{
					g_sharedMessageBox.y = 430;

					var showContinueButton:Boolean = true;

					for (var i:uint = 0; i < scene.numChildren; i++)
					{
						if (scene.getChildAt(i) is PointerButton)
						{
							showContinueButton = false;
						}
					}

					g_sharedMessageBox.setContinueButtonVisible(showContinueButton);
				}
			}
			else
			{
				g_sharedMessageBox.visible = false;
			}

		}
		private function setSceneHRM(scene:SurgeryStep)
		{
			if (scene.getProperties().startHRM && ! g_sharedHRM.isCounting())
			{
				startHRM();
				if (scene.getProperties().hasOptions)
				{
					g_sharedMessageBox.y = 70;
					g_sharedMessageBox.setContinueButtonVisible(false);
				}
				else
				{
					g_sharedMessageBox.y = 430;
					g_sharedMessageBox.setContinueButtonVisible(true);
				}
			}

		}

		private function hideNoBloodElements(scene:SurgeryStep)
		{
			if (m_noBloodMode)
			{
				if (scene.getProperties().hideOnNoBlood != null)
				{
					for (var i:int = 0; i < scene.getProperties().hideOnNoBlood.length; i++)
					{
						var displayable:DisplayObject = scene.getChildByName(scene.getProperties().hideOnNoBlood[i] as String);
						if (displayable != null)
						{
							displayable.visible = false;
						}
						else
						{
							GMGDebugger.traceString("Couldn't find object of name " 
							+ scene.getProperties().hideOnNoBlood[i] 
							+ "in scene " + getQualifiedClassName(m_nextScene) + ".");
						}
					}
					if (scene.getProperties().startHRM && ! g_sharedHRM.isCounting())
					{
						startHRM();
						g_sharedMessageBox.visible = true;
						showMessageBox(scene.getProperties().text);
						if (scene.getProperties().hasOptions)
						{
							g_sharedMessageBox.y = 70;
							g_sharedMessageBox.setContinueButtonVisible(false);
						}
						else
						{
							g_sharedMessageBox.y = 430;
							g_sharedMessageBox.setContinueButtonVisible(true);
						}
					}
				}
			}
		}

		private function setSceneDrag(scene:SurgeryStep)
		{
			if (scene.getProperties().elementToDrag != "")
			{
				var dragElement:MovieClip = MovieClip(scene.getChildByName(scene.getProperties().elementToDrag));
				if (dragElement != null)
				{
					dragElement.mouseEnabled = false;
					dragElement.mouseChildren = false;
					dragElement.startDrag(true);
				}
				else
				{
					GMGDebugger.traceString("The element with name " + scene.getProperties().elementToDrag + " called at " + getQualifiedClassName(scene) + " does not exist and couldn't be dragged.");
				}
			}
		}

		private function setSceneMusic(scene:SurgeryStep)
		{
			if (scene.getProperties().backGroundMusic != "")
			{
				var ClassReference:Class = null;
				try
				{
					if(scene.getProperties().backGroundMusic != null)
					{
						ClassReference = getDefinitionByName(scene.getProperties().backGroundMusic) as Class;
					}
					else
					{
						GMGDebugger.traceString("Music called at " + getQualifiedClassName(scene) + " is null.");
					}
				}
				catch (err:Error)
				{
					GMGDebugger.traceString("Music named " + scene.getProperties().backGroundMusic + " called at " + getQualifiedClassName(scene) + " does not exist.");
				}
				if (ClassReference != null)
				{
					try
					{
						var bgMusic:GMGSound = GMGSound(new ClassReference());
						SoundManager.sharedManager().playMusic(bgMusic);
					}
					catch (err:Error)
					{
						GMGDebugger.traceString("Named file is not of GMGSound type: " + scene.getProperties().backGroundMusic);
					}
				}
				else
				{
					SoundManager.sharedManager().stopMusic();
				}
			}
			else
			{
				SoundManager.sharedManager().stopMusic();
			}
		}

		private function addMantainedElement(scene:SurgeryStep)
		{
			if (m_currentScene != null)
			{
				var element:MovieClip = MovieClip(m_currentScene.getChildByName(m_currentScene.getProperties().elementToMantain));
				if (element != null && !(scene is GameOverMenu))
				{
					scene.addChild(element);
				}
			}
		}
		public function getCurrentScene():SurgeryStep
		{
			return m_currentScene;
		}

		private function showMessageBox(text:String)
		{
			if (! m_gameContainer.parent.contains(g_sharedMessageBox))
			{
				m_gameContainer.parent.addChild(g_sharedMessageBox);
				m_gameContainer.parent.setChildIndex(g_sharedMessageBox, 1);
			}
			g_sharedMessageBox.setText(text);
		}

		private function startHRM()
		{
			if (! m_gameContainer.parent.contains(g_sharedHRM))
			{
				m_gameContainer.parent.addChild(g_sharedHRM);
				g_sharedHRM.x = 5.70;
				g_sharedHRM.y = -24.55;
			}
			g_sharedHRM.startCountdown(SURGERY_DURATION_MINUTES, SURGERY_DURATION_SECONDS);
		}

		public function punishPlayer()
		{
			addMistake();
			var damage:PunishMessage = new PunishMessage();
			if (g_sharedHRM.isCounting())
			{
				g_sharedHRM.gotoNextState();
				if (! g_sharedHRM.canContinue())
				{
					gameOver();
				}
				else
				{
					m_gameContainer.parent.addChild(damage);
					SoundManager.sharedManager().playSound(new SND_FalseAlarm());
				}
			}
			else
			{
				SoundManager.sharedManager().playSound(new SND_FalseAlarm());
				m_gameContainer.parent.addChild(damage);
			}
		}

		public function setContinueButtonVisible(value:Boolean)
		{
			g_sharedMessageBox.setContinueButtonVisible(value);
		}

		public function getMistakes():int
		{
			return m_mistakes;
		}

		public function addMistake()
		{
			m_mistakes++;
		}

		public function isHardMode():Boolean
		{
			return m_hardMode;
		}

		public function getTimeScore():int
		{
			return (g_sharedHRM.getSeconds() + (g_sharedHRM.getMinutes() * 60)) * 100;
		}

		public function getMistakeScore():int
		{
			return m_mistakes * -100;
		}

		public function getTimeInSeconds():int
		{
			return (g_sharedHRM.getSeconds() + (g_sharedHRM.getMinutes() * 60));
		}

		public function reachedHRMState(state:int):Boolean
		{
			return g_sharedHRM.isStateReached(state);
		}

		public function getTimesCompleted():int
		{
			return m_timesCompleted;
		}

		public function isNoBlood():Boolean
		{
			return m_noBloodMode;
		}

		public function gameOver()
		{
			m_reviveScene = m_currentSceneName;
			g_sharedHRM.pauseCountdown();
			showSceneByName("src.scenes.GameOverMenu");
			SoundManager.sharedManager().playSound(new MUS_Failed());
		}

		public function setOverByTime(value:Boolean)
		{
			m_overByTime = value;
		}

		public function getOverByTime():Boolean
		{
			return m_overByTime;
		}

		public function addTime(minutes:int, seconds:int)
		{
			g_sharedHRM.addTime(minutes, seconds);
		}

		public function canRevive():Boolean
		{
			return m_canRevive;
		}
		
		public function canContinue():Boolean
		{
			return g_sharedHRM.canContinue();
		}
		
		public function sendCalculatedScore(score:int)
		{
			if(m_started)
			{
				SpilAPIManager.sharedSpilAPI().sendScore(score);
			}
		}
	}
}
