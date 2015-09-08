﻿package src.scenes {	import flash.events.MouseEvent;	import src.GLP.GLPDirector;	import src.game.SurgeryStep;	import src.game.GameLogic;	import src.game.PlayerData;	import src.game.SpilAPIManager;	import src.GLP.Analytics;	import com.spilgames.api.User;	import src.game.SoundManager;	import flash.events.Event;	import flash.text.TextField;	public class MainMenu extends SurgeryStep {				private var noBlood:Boolean = false;				public function MainMenu() {			(getChildByName("versionText") as TextField).text = PlayerData.sharedData().getGameVersion();						if(PlayerData.sharedData().getNoBlood())			{				//noBloodButton2.gotoAndStop(1);			}			else			{				//noBloodButton2.gotoAndStop(2);			}						playButton.addEventListener(MouseEvent.CLICK, startGame);			//noBloodButton.addEventListener(MouseEvent.CLICK, noBloodClick);			playSite.addEventListener(MouseEvent.CLICK, moreGamesClick);						buttonQuality.addEventListener(MouseEvent.CLICK, qualityCycle);			buttonQuality.addEventListener(MouseEvent.MOUSE_OVER, mOver);						Analytics.CustomMetric("main screen viewed");						if(User.isLoggedIn())			{				Analytics.CustomMetric("user logged in");			}		}				private function startGame(ev:MouseEvent)		{			if(PlayerData.sharedData().getTimesCompleted() > 0)			{				GameLogic.sharedGameLogic().showSceneByName("src.scenes.DifficultyMenu");			}			else			{				GameLogic.sharedGameLogic().startGame(false, PlayerData.sharedData().getNoBlood());			}			ev.target.removeEventListener(MouseEvent.CLICK, startGame);		}				private function noBloodClick(ev:MouseEvent)		{			var noBlood:Boolean = PlayerData.sharedData().getNoBlood();			noBlood = !noBlood;			PlayerData.sharedData().setNoBlood(noBlood);			if(noBlood)			{				//noBloodButton2.gotoAndStop(1);			}			else			{				//noBloodButton2.gotoAndStop(2);			}		}				private function moreGamesClick(ev:MouseEvent)		{			SpilAPIManager.sharedSpilAPI().navigateToMoreGames();			Analytics.CustomMetric("seeding link main menu clicked");		}				private function playAnotherGameClick(ev:MouseEvent)		{			SpilAPIManager.sharedSpilAPI().navigateToOtherSurgeryGame();			Analytics.CustomMetric("seeding link main menu clicked");		}		function qualityCycle(e:MouseEvent):void		{			SoundManager.sharedManager().playSound(new SND_ClickOption());			PlayerData.sharedData().gotoNextQualityOnStage(this.stage);		}				public function mOver(ev:MouseEvent)		{			SoundManager.sharedManager().playSound(new SND_OverOption());		}				override public function updateTexts(ev:Event = null)		{			playButton.updateTexts();			//noBloodButton.addEventListener(MouseEvent.CLICK, noBloodClick);			playSite.updateTexts();		}	}	}