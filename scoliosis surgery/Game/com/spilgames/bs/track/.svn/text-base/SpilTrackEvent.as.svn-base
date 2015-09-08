package com.spilgames.bs.track
{
	public class SpilTrackEvent
	{
		/* gameplay events */
		public static const GAME_START:String = "game.start";
		public static const GAME_LEVEL_START:String = "game.level.start";
		public static const GAME_LEVEL_FINISH:String = "game.level.finish";
		public static const GAME_LEVEL_FAIL:String = "game.level.failed";
		public static const GAME_WORLD_START:String = "game.world.start";
		public static const GAME_WORLD_FINISH:String = "game.world.finish";
		public static const GAME_SCENE:String = "game.scene";
		public static const GAME_MILESTONE:String = "game.milestone";
		public static const GAME_OBJECTIVE:String = "game.objective";
		public static const GAME_SETTINGS:String = "game.settings";
		public static const GAME_WIN:String = "game.win";
		public static const GAME_RESET:String = "game.reset";
		public static const GAME_QUIT:String = "game.quit";
		public static const GAME_LOSE:String = "game.lose";
		public static const GAME_TUTORIAL_FINISH:String = "game.tutorial.finish";
		public static const GAME_TUTORIAL_STEP:String = "game.tutorial.step";
		public static const GAME_BUTTON_PRESS:String = "game.button.press";
		public static const GAME_ITEM_GET:String = "game.get.item";
		public static const GAME_ITEM_SET:String = "game.set.item";
		public static const GAME_PAUSE:String = "game.pause";
		public static const GAME_RESUME:String = "game.resume";
		public static const GAME_FEATURE:String = "game.feature";
		public static const GAME_SCORE:String = "game.score";
		public static const GAME_HIGHSCORE:String = "game.highscore";
		public static const GAME_NEW_RECORD:String = "game.new_record";
		public static const GAME_CUSTOM:String = "game.mycustomevent";
		public static const GAME_HEARTBEAT:String = "game.heartbeat";
		
		/* user events */
		public static const USER_ID:String = "user.id";
		public static const USER_NAME:String = "user.name";
		public static const USER_FIRST_NAME:String = "user.first_name";
		public static const USER_MIDDLE_NAME:String = "user.middle_name";
		public static const USER_LAST_NAME:String = "user.last_name";
		public static const USER_GENDER:String = "user.gender";
		public static const USER_LOCALE :String = "user.locale";
		public static const USER_LANGUAGE:String = "user.language";
		public static const USER_USERNAME:String = "user.username";
		public static const USER_TIMEZONE:String = "user.timezone";
		public static const USER_BIRTHDAY:String = "user.birthday";
		public static const USER_CURRENCY:String = "user.currency";
		public static const USER_EMAIL:String = "user.email";
		public static const USER_LOCATION:String = "user.location";
		public static const USER_PICTURE:String = "user.picture";
		public static const USER_AVATAR:String = "user.avatar";
		public static const USER_WEBSITE:String = "user.website";
		public static const USER_INTEREST:String = "user.interest";
		public static const USER_STATUS:String = "user.status";
		public static const USER_PROGRESS:String = "user.progress";
		public static const USER_FAVORITE_PET:String = "user.favorite_pet";
		public static const USER_ACTIVE:String = "user.active";
		public static const USER_CUSTOM:String = "user.mycustomevent";
		
		/* bussiness events */
		public static const BUSSINESS_STORE_ENTERED:String = "bussiness.store.entered";
		public static const BUSSINESS_STORE_CLOSED:String = "bussiness.store.closed";
		public static const BUSSINESS_ITEM_SELECTED:String = "bussiness.item.selected";
		public static const BUSSINESS_ITEM_CANCELLED:String = "bussiness.item.cancelled";
		public static const BUSSINESS_ITEM_SUCCESSFUL:String = "bussiness.item.successfull";
		public static const BUSSINESS_ITEM_FAILED:String = "bussiness.item.failed";
		public static const BUSSINESS_CUSTOM:String = "bussiness.mycustomevent";
		
		/* quality events */
		public static const QUALITY_PERFORMANCE:String = "quality.performance";
		public static const QUALITY_DEBUG:String = "quality.debug";
		public static const QUALITY_ERROR:String = "quality.error";
		public static const QUALITY_CUSTOM:String = "quality.mycustomevent";
		
		
		public var gameID:String;
		public var gameID_Secondary:String;
		public var params:Object;
		public var eventType:String;
		public var event:String;
		public var timePlayed:Number;
		
		public var userID:String;
		public var sessionID:String;
		
		public function SpilTrackEvent() 
		{
			
		}
		
		
		public function addEvent(event:String, eventType:String, params:Object):void {
			
			if (this.event) return void; //Cant be set twice
			
			this.event = event;
			this.eventType = eventType;
			this.params = params;
			
		}
	}
}