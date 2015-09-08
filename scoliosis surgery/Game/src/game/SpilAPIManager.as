package src.game
{
	import flash.events.Event;
	import flash.events.ErrorEvent;
	import com.spilgames.api.SpilGamesServices;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	import com.spilgames.bs.comps.LocalizedTextField;
	import flash.display.MovieClip;
	import com.spilgames.api.ScoreService;
	import com.spilgames.api.AwardsService;
	import com.spilgames.api.AvatarService;
	import src.GLP.GMGDebugger;
	import src.GLP.Analytics;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import com.spilgames.api.User;
	import com.spilgames.bs.BrandingManager;
	import flash.text.TextFormat;
	import src.GLP.GLPDirector;
	import src.scenes.SurgeryContainer;
	import flash.text.Font;

	// Eventos
	[Event(name="languageChanged", type="GLP.SpilGame.LANGUAGE_CHANGED")]
	
	public class SpilAPIManager
	{
		private static var g_sharedSpilAPI:SpilAPIManager = null;
		
		private var m_isAPIReady:Boolean = false;
		
		public static const SENT:int = 0;
		public static const SENDING:int = 1;
		public static const ERROR:int = 2;
		public static const NOT_LOGGED:int = 3;
		public static const NOT_CONNECTED:int = 4;
		
		private var m_lastAvatarStatus:int = ERROR;
		
		private static var m_sentAwards:Array = new Array();
		
		private var m_sMute:Boolean = false;
		private var m_mMute:Boolean = false;
		
		public function SpilAPIManager()
		{
		}

		public static function sharedSpilAPI():SpilAPIManager
		{
			if (g_sharedSpilAPI == null)
			{
				g_sharedSpilAPI = new SpilAPIManager();
			}
			return g_sharedSpilAPI;
		}
		
		public function setMainContent(cont:DisplayObject)
		{
			// Commented this to run in air 
			
			/*var spilGamesServices:SpilGamesServices = SpilGamesServices.getInstance();
			var brandingManager:BrandingManager = BrandingManager.getInstance();

			brandingManager.addEventListener(SpilGamesServices.COMPONENTS_READY, onBrandingComponentsReady);
			spilGamesServices.addEventListener(SpilGamesServices.COMPONENTS_READY, onComponentsReady);
			spilGamesServices.addEventListener(SpilGamesServices.SERVICES_READY, onServicesReady);
			spilGamesServices.addEventListener(SpilGamesServices.SERVICE_ERROR, onServicesFailed);
			
			spilGamesServices.connect(cont,PlayerData.SPIL_GAME_ID, false, new LocalizationPack());*/
		}
		
		public function addOnLocaleChangedEvent(target:Function)
		{
			var spilGamesServices:SpilGamesServices = SpilGamesServices.getInstance();
			spilGamesServices.addEventListener(SpilGamesServices.LOCALE_CHANGED, target);
		}
		
		public function removeOnLocaleChangedEvent(target:Function)
		{
			var spilGamesServices:SpilGamesServices = SpilGamesServices.getInstance();
			spilGamesServices.removeEventListener(SpilGamesServices.LOCALE_CHANGED, target);
		}
		
		// Some dummy event listeners
		private function onBrandingComponentsReady(ev:Event):void
		{
			GMGDebugger.traceString("Branding Components ready");
		}

		private function onComponentsReady(ev:Event):void
		{
			GMGDebugger.traceString("Components ready");
		}

		private function onServicesReady(ev:Event):void
		{
			m_isAPIReady = true;
			GMGDebugger.traceString("Services ready");
		}

		private function onServicesFailed(ev:ErrorEvent):void
		{
			GMGDebugger.traceString("Services failed.");
		}
		
		public function isApiReady():Boolean
		{
			return m_isAPIReady;
		}
		
		public function sendScore(score:Number):void
		{
			if(ScoreService.isAvailable())
			{
				ScoreService.submitScore(score,scoreSubmissionCallback);
				GMGDebugger.traceString("Score " + score + " sent.");
			}
			else
			{
				GMGDebugger.traceString("Couldn't send score. ScoreService not available.");
			}
		}
		
		private function scoreSubmissionCallback(callbackID:int,data:Object):void
		{
			if (! data.success)
			{
				GMGDebugger.traceString("Couldn't send score.");
			}
		}
		
		public function sendAward(value:String):void
		{
			if(AwardsService.isAvailable())
			{
				if(m_sentAwards.indexOf(value) < 0)
				{
					AwardsService.submitAward(value, awardSubmissionCallback);
					GMGDebugger.traceString("Award " + value + " sent.");
					m_sentAwards.push(value);
				}
			}
			else
			{
				GMGDebugger.traceString("Couldn't send award. AwardsService not available.");
			}
		}
		private function awardSubmissionCallback(callbackID:int,data:Object):void
		{
			if (! data.success)
			{
				GMGDebugger.traceString("Couldn't send award.");
			}
		}
		public function sendAvatar(avatarIndex:uint):int
		{
			var options:Object = null;
			var avatarBitmap:DisplayObject;
			
			if(AvatarService.isAvailable())
			{
				if(!User.isGuest())
				{
					switch(avatarIndex)
					{
						case 1:
							avatarBitmap = new Avatar1();
							options = {title:"AvatarTest1", description:"AvatarTest1Description"};
							break;
						case 2:
							avatarBitmap = new Avatar2();
							options = {title:"AvatarTest2", description:"AvatarTest2Description"};
							break;
						case 3:
							avatarBitmap = new Avatar3();
							options = {title:"AvatarTest3", description:"AvatarTest3Description"};
							break;
						default:
							return ERROR;
					}
					AvatarService.saveDrawable(avatarBitmap, null, options, avatarSubmissionCallback);
				}
				else
				{
					return NOT_LOGGED;
				}
			}
			else
			{
				GMGDebugger.traceString("AvatarService is not available.");
				return NOT_CONNECTED;
			}
			GMGDebugger.traceString("Sending avatar " + avatarIndex + ".");
			m_lastAvatarStatus = SENDING;
			return SENDING;
		}
		
		private function avatarSubmissionCallback(callbackID:int,data:Object):void
		{
			if (! data.success)
			{
				GMGDebugger.traceString("Couldn't send avatar.");
			}
			else
			{
				GMGDebugger.traceString("Avatar successfully uploaded");
				m_lastAvatarStatus = SENT;
			}
		}
		
		public function getLastAvatarStatus():int
		{
			return m_lastAvatarStatus;
		}
		
		public function navigateToMoreGames()
		{
			var newB:BrandingManager = BrandingManager.getInstance();
			navigateToURL(new URLRequest(newB.getMoreGamesLink()),"_blank");
		}
		
		public function navigateToOtherSurgeryGame()
		{
			var newB:BrandingManager = BrandingManager.getInstance();
			var link:String = newB.getGameLink("relatedGame");
			navigateToURL(new URLRequest(link),"_blank");
		}
		
		public function navigateToOnGameAd()
		{
			if(GameLogic.sharedGameLogic().getCurrentScene() != null)
			{
				GameLogic.sharedGameLogic().getCurrentScene().pauseScene();
			}
			if(GameLogic.sharedGameLogic().getNextScene() != null)
			{
				GameLogic.sharedGameLogic().getNextScene().pauseScene();
			}
			
			m_sMute = PlayerData.sharedData().getSoundMute();
			m_mMute = PlayerData.sharedData().getMusicMute();
			
			if(!m_sMute)
			{
				PlayerData.sharedData().setSoundMute(true);
			}
			if(!m_mMute)
			{
				PlayerData.sharedData().setMusicMute(true);
			}
			
			BrandingManager.getInstance().requestOnGameAd(navigateToOnGameAdCallback);
		}
		
		public function navigateToOnGameAdCallback()
		{
			GMGDebugger.traceString("Ad request successful");
			if(GameLogic.sharedGameLogic().getCurrentScene() != null)
			{
				GameLogic.sharedGameLogic().getCurrentScene().continueScene();
			}
			if(GameLogic.sharedGameLogic().getNextScene() != null)
			{
				GameLogic.sharedGameLogic().getNextScene().continueScene();
			}
			
			if(m_sMute != PlayerData.sharedData().getSoundMute())
			{
				PlayerData.sharedData().setSoundMute(m_sMute);
			}
			if(m_mMute != PlayerData.sharedData().getMusicMute())
			{
				PlayerData.sharedData().setMusicMute(m_mMute);
			}
		}
		
		public function getLocalizedText(string:String):String
		{
			string = string.replace("{","").replace("}","");
			var newB:BrandingManager = BrandingManager.getInstance();
			if(!isApiReady())
			{
				return string;
			}
			else
			{
				return newB.getLocalizedString(string);
			}
		}
		
		public function localizeTextField(textField:TextField):void
		{
			if(isApiReady())
			{
				var string:String = textField.text;

				if(textField.multiline)
				{
					while(string.search(String.fromCharCode(13)) >= 0)
					{
						string = string.replace(String.fromCharCode(13), "");
					}
				}
				
				var font:Font = null;
				
				if(BrandingManager.getInstance().getCurrentLanguage() == "zh-CN")
				{
					font = new SimHei();
				}
				else
				{
					font = new CurierBold();
				}
				
				var myFormat:TextFormat = new TextFormat();
				myFormat.size = textField.getTextFormat().size;
				myFormat.font = font.fontName;
				
				textField.setTextFormat(myFormat);
				textField.defaultTextFormat = myFormat;
				
				if(textField.multiline)
				{
					while(string.search(String.fromCharCode(13)) >= 0)
					{
						string = string.replace(String.fromCharCode(13), "");
					}
				}
				var localizedString:String = getLocalizedText(string);
				
				textField.text = localizedString;
				
				var f:TextFormat = textField.getTextFormat();
				var size:Number = ( textField.width > textField.height ) ? textField.width : textField.height;
				textField.setTextFormat( f );
				
				f.size = size < f.size ? size : f.size;
				
				while ( textField.textWidth > textField.width - 4 || textField.textHeight > textField.height - 6 ) 
				{
					f.size = int( f.size ) - 1;
					textField.setTextFormat( f );
				}
			}
		}
	}
}
