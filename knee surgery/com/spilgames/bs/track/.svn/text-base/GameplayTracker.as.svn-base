package com.spilgames.bs.track
{
	/**
	 * This event category is designed for tracking game design related events.
	 * 
	 * <p>This class should help you sent these events to the Spil Tracking System.</p>
	 */ 
	public class GameplayTracker extends ATracker
	{
		private static var _instance:GameplayTracker;
		
		public function GameplayTracker(priv:Private)
		{
			eventType = "game";
		}
		
		public static function getInstance():GameplayTracker {
			if (!_instance) _instance = new GameplayTracker(new Private());
			return _instance;
		}
		
		
		public function startGame():void {
			call(SpilTrackEvent.GAME_START)			
		}
		
		/**
		 * 
		 * @param	level
		 */
		public function levelStart(level:String = ""):void {
			
			call(
				SpilTrackEvent.GAME_LEVEL_START,
				{
					level:level
				}
			);
			
		}
		
		/**
		 * levelComplete
		 * @param	level
		 * @param	timeSpent 	if not set then it will use runtime data
		 */
		public function levelComplete(levelData:Object):void {
			
			call(SpilTrackEvent.GAME_LEVEL_FINISH, levelData);
		}
		
		public function levelFailed(levelData:Object):void {
			
			call(SpilTrackEvent.GAME_LEVEL_FAIL, levelData);
			
		}
		
		public function worldStart(world:String):void {
			
			call(
				SpilTrackEvent.GAME_WORLD_START,
				{
					level:world
				}
			);
			
		}
		
		public function worldComplete(worldData:Object):void {
			
			call( SpilTrackEvent.GAME_WORLD_FINISH, worldData	);
			
		}
		
		
		public function scene(scene:String):void {
			call(
				SpilTrackEvent.GAME_SCENE,
				{
					scene:scene
				}
			);
		}
		
		public function milestone(milestone:String):void {
			call(
				SpilTrackEvent.GAME_MILESTONE,
				{
					milestone:milestone
				}
			);
		}
		
		public function objectiveReached(objective:String):void {
			call(
				SpilTrackEvent.GAME_OBJECTIVE,
				{
					objective:objective
				}
			);
		}
		
		public function setting(setting:String):void {
			call(
				SpilTrackEvent.GAME_SETTINGS,
				{
					setting:setting
				}
			);
		}
		
		public function winGame():void {
			call(SpilTrackEvent.GAME_WIN);
		}
		
		public function resetGame():void {
			call(SpilTrackEvent.GAME_RESET);
		}
		
		public function quitGame():void {
			call(SpilTrackEvent.GAME_QUIT);
		}
		
		public function loseGame():void {
			call(SpilTrackEvent.GAME_LOSE);
		}
		
		public function tutorialFinished():void {
			call(SpilTrackEvent.GAME_TUTORIAL_FINISH);
		}
		
		public function tutorialStep(step:String):void {
			call(
				SpilTrackEvent.GAME_TUTORIAL_STEP,
				{
					step:step
				}
			);
		}
		
		public function buttonPressed(name:String):void {
			call(
				SpilTrackEvent.GAME_BUTTON_PRESS,
				{
					name:name
				}
			);
		}
		
		public function itemObtained(name:String):void {
			call(
				SpilTrackEvent.GAME_ITEM_GET,
				{
					name:name
				}
			);
		}
		
		public function itemSetting(setting:String):void {
			call(
				SpilTrackEvent.GAME_ITEM_SET,
				{
					setting:setting
				}
			);
		}
		
		public function pauseGame():void {
			call(SpilTrackEvent.GAME_PAUSE);
		}
		
		public function resumeGame():void {
			call(SpilTrackEvent.GAME_PAUSE);
		}
		
		public function feature(name:String):void {
			call(
				SpilTrackEvent.GAME_FEATURE,
				{
					name:name
				}
			);
		}
		
		public function score(score:String):void {
			call(
				SpilTrackEvent.GAME_SCORE,
				{
					score:score
				}
			);
		}
		
		public function highScore(score:String):void {
			call(
				SpilTrackEvent.GAME_HIGHSCORE,
				{
					score:score
				}
			);
		}
		
		public function newRecord(score:String):void {
			call(
				SpilTrackEvent.GAME_NEW_RECORD,
				{
					score:score
				}
			);
		}
		
		public function heartbeat(params:Object = null):void {
			call(SpilTrackEvent.GAME_HEARTBEAT, params);
		}
		
		
		
		/**
		 * 
		 * @param	obj
		 */
		public function __custom(obj:Object):void {
			call(SpilTrackEvent.GAME_CUSTOM, obj);
		}
	}
}

/**
 * This class reinforces the Singleton Pattern
 */ 
internal class Private{}