// Copyright 2010 Spil Games BV
package com.spilgames.bs
{
	import com.spilgames.api.SpilGamesServices;
	import com.spilgames.bs.track.SpilTrackEvent;
	
	import flash.display.MovieClip;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * Dispatched when the components are ready to be used.
	 * 
	 * <p>For example the language select component is ready 
	 * for display and interaction</p>
	 * 
	 * @eventType SpilGamesServices.COMPONENTS_READY 
	 */
	[Event(name="componentsReady", type="flash.events.Event")]
	
	/**
	 * Dispatched when the locale has changed.
	 * 
	 * @eventType SpilGamesServices.LOCALE_CHANGED
	 */
	[Event(name="localeChanged", type="flash.events.Event")]
	
	/**
	 * Dispatched when all the elements of the Spil Branding 
	 * System are ready, for example the logo has been correctly loaded.
	 * 
	 * @eventType BrandingManager.BRANDING_READY
	 */
	[Event(name="brandingReady", type="flash.events.Event")]
	
	/**
	 * The BrandingManager provides developer control, if available,
	 * of the branding elements of a game within a Spil portal.
	 * 
	 * @since 1.3
	 * @langversion 3.0
	 * @playerversion Flash 10
	 * @see #isAvailable()
	 */
	public class BrandingManager extends EventDispatcher
	{	
		// ====================================
		// CLASS CONSTANTS
		// ====================================
		
		/**
		 * Constant used for dispatching Event when
		 * branding elements are loaded
		 * */
		
		public static const BRANDING_READY		: String = "brandingReady";
		
		/**
		 * 
		 * */
		public static const DEFAULT_MORE_GAMES_LINK	: String = "http://www.agame.com";
		
		// ====================================
		// PRIVATE VARS
		// ====================================
		
		/**
		 * Singleton instance of this class.
		 */		
		private static var _instance			: BrandingManager;
		
		/**
		 * Reference to the loaded branding system.
		 *
		 * @internal Internal classes return instances as untyped Objects.
		 */
		private var _brandingSystem				: *;
		
		/**
		 * Indicates whether the components for localization are ready
		 * to be used.
		 * 
		 */		
		private var _componentsReady			: Boolean = false;
		
		/**
		 * Constructor.
		 * 
		 * @param access
		 * @throws Error Cannot be instantiated directly, use <code>getInstance()</code> instead.
		 * 
		 * @see #getInstance()
		 */
		public function BrandingManager(access:Private = null)
		{
			super();
			
			initConstructor(access);
		}
		
		// ====================================
		// STATIC METHODS
		// ====================================
		
		/**
		 * Used for interaction with Spil Games Branding components.
		 * 
		 * @return A static instance of the <code>BrandingManager</code> class.  
		 */
		public static function getInstance():BrandingManager
		{
			if (!_instance)
			{
				_instance = new BrandingManager(new Private());
			}
			
			return _instance;
		}
		
		// ====================================
		// PUBLIC METHODS
		// ====================================
		
		/**
		 * Use this function to create branding components generated by the 
		 * internal Spil API.
		 * 
		 * @param type Provide the type of component you would like returned e.g.
		 *             BrandingComponentTypes.LANGUAGE_SELECTOR,
		 *             BrandingComponentTypes.LOCALISED_BUTTON
		 * @return An internally generated visual component of the Spil Branding
		 * 		   System as a MovieClip. Returns null when <code>type</code> is unknown. 			 			
		 * @see BrandingComponentTypes
		 */
		public function createComponent(type:String):MovieClip
		{
			var result:MovieClip;
			
			if (type && type != "")
			{
				if (_componentsReady)
				{
					try
					{
						result = _brandingSystem.createComponent(type);
					}
					catch (e:Error)
					{
					}
				}
			}
			
			return result;
		}
		
		/**
		 * Returns a Boolean to indicate the BrandingManager is ready to be used based
		 * on the return value of isReady()
		 * 
		 * @return Boolean which indicates whether BrandingManager can be used.
		 */
		[Deprecated(replacement="isReady")]
		public function isAvailable():Boolean
		{
			return isReady();
		}
		
		/**
		 * Indicates whether or not the branding components have been loaded and
		 * initialized and are ready for use.
		 * */
		public function isReady():Boolean
		{
			return _componentsReady;
		}
		/**
		 * Returns a string representation of a link for publishers
		 * who may wish to license this game. 
		 * */		
		public function getAddToSiteLink():String
		{
			var link:String = _brandingSystem.getAddToSiteLink();
			
			return link;
		}
		
		/**
		 * Returns a String representation of the game portal for the current locale
		 * */
		public function getMoreGamesLink():String 
		{
			var returnValue:String = DEFAULT_MORE_GAMES_LINK;
			
			if (isReady() && _brandingSystem)
				returnValue = _brandingSystem.getMoreGamesLink();
			
			return returnValue;
		}
		
		/**
		 * Returns a String representation of the link correspondent to the provided key
		 * 
		 * @param linkKey Is a String representation of the correspondent key to the desired link
		 * that is set in the game configurations 
		 * */
		public function getGameLink(linkKey:String):String 
		{
			var returnValue:String = DEFAULT_MORE_GAMES_LINK;
			
			if (isReady() && _brandingSystem)
				returnValue = _brandingSystem.getGameLink(linkKey);
			
			return returnValue;
		}
		
		/**
		 * Returns a String representation of the game portal for the current locale
		 * @param link The link which should be returned with tracking data
		 * @param trackingTag The keyword that should be used to track this link
		 * @return Returns a string representation of the submitted link with appropriate tracking code
		 * */
		public function getTrackedLink(link:String, trackingTag:String):String 
		{
			var returnValue:String;
			
			if (isReady() && _brandingSystem)
				returnValue = _brandingSystem.getTrackedLink(link, trackingTag);
			
			return returnValue;
		}

		/**
		 * Use this function to retrieve a localized String from a localization pack.
		 * @param key The identifier used for the desired string (without the {} braces required when creating a LocalizedTextField).
		 * @param bundle The localization pack to be used. This can be "SpilGames_Internal" or "SpilGames_Game".
		 * */
		public function getLocalizedString(key:String, bundle:String = "SpilGames_Game"):String
		{
			var returnObject:Object = _brandingSystem.getString(key, bundle);
			
			return returnObject.value;
		}

		/**
		 * This function will return translation data from a localization pack.
		 * @param key The identifier used for the desired string (without the {} braces required when creating a LocalizedTextField).
		 * @param bundle The localization pack to be used. This can be "SpilGames_Internal" or "SpilGames_Game".
		 * @return An object with the following properties:
		 * <ul>
		 * <li>value: The localized String from the localization pack. The same value can be retrieved by calling the getLocalizedString method.</li>
		 * <li>direction: The language direction can be ltr or rtl. Currently on ltr is supported.</li>
		 * <li>fontName: The font that should be used for the translation.</li>
		 * <li>bold: If the textformat should be bold.</li>
		 * <li>italic: If the textformat should be italic.</li>
		 * <li>underline: If the textformat should be underlined.</li>
		 * </ul>
		 **/
		public function getLocalizedObject(key:String, bundle:String = "SpilGames_Game"):Object
		{
			return _brandingSystem.getString(key, bundle);
		}
		
		/**
		 * Use this function to show the Branding Bar.
		 * 
		 * <p>If you have control of the Branding Bar the <code>isAvailable()</code>
		 * function will return <code>true</code>. If it returns <code>false</code>
		 * then you are not allowed to control the display of the Branding Bar.</p>
		 * 
		 * @return Returns <code>true</code> if the Branding Bar was successfully displayed.
		 * @see #isAvailable()
		 * */
		public function showBrandingBar():Boolean
		{
			return _brandingSystem.showBrandingBar();
		}
		
		/**
		 * Use this function to hide the Branding Bar.
		 * 
		 * <p>If you have control of the Branding Bar the <code>isAvailable()</code>
		 * function will return <code>true</code>. If it returns <code>false</code>
		 * then you are not allowed to control the display of the Branding Bar.</p>
		 * 
		 * @return Returns <code>true</code> if the Branding Bar was successfully hidden.
		 * @see #isAvailable()
		 * */
		public function hideBrandingBar():Boolean
		{
			return _brandingSystem.hideBrandingBar();
		}
		
		/**
		 * Use this function to retrieve the current active language.
		 * <p>
		 * Language is returned in the format of "en-GB"
		 * where the letters before "-" represent the language
		 * and the letters after "-" represent the locale of that language.
		 * </p>
		 * 
		 * <p>
		 * e.g. Spanish for Spain would be "es-ES" but spanish in 
		 * Mexico would be "es-MX"
		 * </p>
		 * 
		 * @return The current language code
		 * */
		public function getCurrentLanguage():String
		{
			return _brandingSystem.getCurrentLanguage();
		}
		
		/**
		 * Allows the developer to set the language programmatically
		 * 
		 * @param The language code for the desired language
		 * */
		public function setLanguage(languageCode:String):void 
		{
			_brandingSystem.setLanguage(languageCode);
		}
		
		/**
		 * Use this function to find out the portal group the game currently 
		 * resides on
		 * 
		 * @return Returns a uint which represents the current portal group.
		 * */
		public function getPortalGroup():uint 
		{
			var result:uint = 1;
			if(isReady() && _brandingSystem)
			{
				result = _brandingSystem.portalGroup;
			}
			
			return result;
		}
		
		/**
		 * This function requests an Ad to be displayed in the game. Use it when
		 * there is a moment in the game where an Ad would be suitable.
		 * <p>
		 * The game should be paused before this function is called and the function
		 * to unpause the game should be passed as the argument.
		 * </p>
		 * 
		 * @param The function that should be called once the Ad is over. This function
		 * should be the one to unpause the game.
		 * */
		public function requestOnGameAd(callback:Function):void
		{
			if(SpilGamesServices.getInstance().isReady()) 
			{
				_brandingSystem.requestOnGameAd(SpilGamesServices.getInstance().parent, callback);
			} else {
				callback();
			}
		}
		
		/**
		 * This function is used to track events using the available tracking systems for the game.
		 * 
		 */
		public function trackEvent(event:String, eventType:String, params:Object, forceCall:Boolean = false):void
		{
			if(SpilGamesServices.getInstance().isReady() && !SpilGamesServices.getInstance().isDebugMode()) 
			{
				_brandingSystem.trackEvent(SpilGamesServices.getInstance().parent,
											event,
											eventType,
											params,
											forceCall);
			}
		}
		
		// ====================================
		// PRIVATE METHODS
		// ====================================
		
		/**
		 * @param access
		 */		
		private function initConstructor(access:Private):void
		{
			if (!access)
			{
				throw new Error("Cannot instantiate this class directly. Use BrandingManager.getInstance() instead.");
			}
			
			SpilGamesServices.getInstance().addEventListener(SpilGamesServices.COMPONENTS_READY,
				onComponentsReady);
		}
		
		// ====================================
		// EVENT HANDLERS
		// ====================================
		
		/**
		 * @param event
		 */
		private function onComponentsReady(event:Event):void
		{
			//In some browsers refreshing while branding components are still loading fire the COMPLETE event (it's fixed in fp 11.5)
			try
			{
				_brandingSystem = SpilGamesServices.getInstance().connection.getComponentSystem(
					BrandingComponentTypes.BRAND_SYSTEM);
				
				_brandingSystem.flashVars = SpilGamesServices.getInstance().flashVars;
				
				if (!_brandingSystem)
				{
					return;
				}
				
				_brandingSystem.addEventListener(BRANDING_READY, brandingReady);
				
				if(SpilGamesServices.getInstance().flashVars.siteID > 0)
					_brandingSystem.useGoogleAnalytics = false;
				
				// Register to listen for locale change events
				SpilGamesServices.getInstance().connection.addEventListener(
					SpilGamesServices.LOCALE_CHANGED, onLocaleChanged);
				
				_componentsReady = true;
				dispatchEvent( new Event( SpilGamesServices.COMPONENTS_READY, true ) );
			} catch (e:Error) {}
		}
		
		private function brandingReady(evt:Event):void {
			dispatchEvent(new Event( BRANDING_READY ) );
		}
		
		/**
		 * @param event
		 */
		private function onLocaleChanged(event:Event):void
		{
			if ( hasEventListener( SpilGamesServices.LOCALE_CHANGED ))
			{
				dispatchEvent( new Event( SpilGamesServices.LOCALE_CHANGED ) );
			}
		}
	}
}

/**
 * @private
 */
internal class Private {}
