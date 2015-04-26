package ahhenderson.core.starling.controls.core {

	import com.kurst.cfwrk.system.DeviceCapabilities;
	import com.kurst.cfwrk.system.StarlingMultiResConfig;
	import com.kurst.cfwrk.system.data.DeviceInfo;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageOrientation;
	import flash.display.StageScaleMode;
	import flash.display3D.Context3DProfile;
	import flash.events.Event;
	import flash.events.UncaughtErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.utils.ByteArray;
	
	import ahhenderson.core.managers.LoggingManager;
	
	import starling.core.Starling;
	import starling.utils.HAlign;
	import starling.utils.VAlign;


	public class StarlingApplication extends Sprite {
		
		private var _logger:LoggingManager;
		
		include  "../../../_includes/_Version.inc";
		
		public function StarlingApplication(debug:Boolean=false) {
 
			scopeClassInstances();
			
			if(debug){ 
				initializeLogger(); 
			}
			
			if ( this.stage ) {
				this.stage.scaleMode = StageScaleMode.NO_SCALE;
				this.stage.align = StageAlign.TOP_LEFT;
			}
			this.mouseEnabled = this.mouseChildren = false;

			this.showLaunchImage();

			//addChild(new FrocessingPanel())
			this.loaderInfo.addEventListener( flash.events.Event.COMPLETE, loaderInfo_completeHandler );

			// Global error handling.
			this.loaderInfo.uncaughtErrorEvents.addEventListener( UncaughtErrorEvent.UNCAUGHT_ERROR, onUncaughtError );
		}

		public function get resolutionConfig():StarlingMultiResConfig
		{
			return _resolutionConfig;
		}

		protected function scopeClassInstances():void{
			
			
		}
		public function get logger():LoggingManager
		{
			if(!_logger)
				_logger = LoggingManager.instance;
			
			return _logger;
		}

		protected function initializeLogger():void{
			
			logger.initialize(this);
			logger.clear();
			logger.trace(this, "[ahhenderson-core-framework] VERSION: " + getAppVersion());
			logger.trace(this, "Starting Starling Application...");
			 
			
		}
		protected var _launchImage:Loader;

		protected var _savedAutoOrients:Boolean;

		protected var _splashBackground:Bitmap;

		protected var _starling:Starling;
		
		protected var _splashImg_Portrait_2x:String ="Default-Portrait@2x.png";
		
		protected var _splashImg_Landscape_2x:String ="Default-Landscape@2x.png";
		
		protected var _splashImg_Portrait:String ="Default-Portrait.png";
		
		protected var _splashImg_Landscape:String ="Default-Landscape.png";
		
		protected var _splashImg_Default:String ="Default.png";
		
		protected var _splashImg_Default_2x:String ="Default@2x.png";
		
		protected var _splashImg_568h_2x:String ="Default-568h@2x.png";
		
		// iOS 6 Res.
		protected var _splashImg_375w_677h_2x:String ="Default-375w-667h@2x.png"; // 750x1334
		
		// iOS 6 Plus Res.
		protected var _splashImg_414w_736h_landscape_3x:String ="Default-414w-736h-landscape@3x.png"; // 2208x1242
		
		protected var _splashImg_414w_736h_3x:String ="Default-414w-736h@3x.png"; // 1242x2208

	
		protected var _enableErrorChecking:Boolean=false;
		protected var _handleLostContext:Boolean=true;
		protected var _multitouchEnabled:Boolean=true;
		protected var _renderMode:String = "auto";
		protected var _defaultProfile:String=Context3DProfile.BASELINE_EXTENDED;
		private var _resolutionConfig:StarlingMultiResConfig;
		
		protected function defaultConfiguration():void{
			
			throw new Error( "Override StarlingApplication defaultConfiguration() method" );
		}
	
		/*********************************************************************************************************************************************************************************
		 * NOTES	 
		 * 
		 *	_resolutionConfig = new StarlingMultiResConfig(stage, _starling);
		 *	
		 *	Simulate an IOS device:		_resolutionConfig.set( null , null , OSList.IOS );
		 * 	Simulate an Android device: _resolutionConfig.set( null , null , OSList.ANDROID );
		 * 	Production / no simulation: _resolutionConfig.set( );
		 * 		
		 **********************************************************************************************************************************************************************************/
		protected function determineScreenResolution():void{
			 
			const device:DeviceInfo = DeviceCapabilities.deviceInformation(); 
			const viewPort:Rectangle = new Rectangle(0,0,device.width, device.height);
			
			trace("Viewport Width: ", viewPort.width);
			trace("Viewport Height: ", viewPort.height);
			
			_resolutionConfig.set(viewPort);
			
		}
		
		protected function loaderInfo_completeHandler(event:Event):void
		{
			defaultConfiguration();
			
			Starling.handleLostContext = _handleLostContext;
			Starling.multitouchEnabled = _multitouchEnabled; //DeviceCapabilities.handleLostContextOnDevice();
			this._starling = new Starling(rootContainer(), this.stage, null, null, _renderMode, _defaultProfile);
			this._starling.enableErrorChecking = _enableErrorChecking;
			this._starling.showStats = true;
			this._starling.showStatsAt(HAlign.RIGHT, VAlign.BOTTOM);
			
			DeviceCapabilities.init(stage);
			_resolutionConfig = new StarlingMultiResConfig(stage, _starling);
			
			// Dynamically set correct resolution
			// * Can override to simulate resolutions.
			determineScreenResolution();
			
			this._starling.start();
			
			
			//if(this._launchImage)
			//{
				this._starling.addEventListener("rootCreated", starling_rootCreatedHandler);
			//}
			
			this.stage.addEventListener(Event.RESIZE, stage_resizeHandler, false, int.MAX_VALUE, true);
			this.stage.addEventListener(Event.DEACTIVATE, stage_deactivateHandler, false, 0, true);
		}
		
		protected function starling_rootCreatedHandler(event:Object, rootView:*):void
		{ 
			
			if(this._launchImage)
			{
				this.removeChild(this._launchImage);
				this._launchImage.unloadAndStop(true);
				this._launchImage = null;
				this.stage.autoOrients = this._savedAutoOrients;
			}
			
			onRootContainerCreated(event, rootView);
		}

		protected function rootContainer():Class{
			
			throw new Error( "Override StarlingApplication rootScreen() method" );
			
		}
		
		protected function onRootContainerCreated(event:Object, rootView:*):void{
			
			throw new Error( "Override StarlingApplication onRootContainerCreated() method" );
			
		}
		
		 
		
		protected function onUncaughtError( e:UncaughtErrorEvent ):void {

			//TODO: Need pre-feathers alert.
			  
			//this suppresses the error dialogue
			e.preventDefault(); 
			  
		}

		protected function showLaunchImage():void {

			var filePath:String;
			var isPortraitOnly:Boolean = false;
			var isCurrentlyPortrait:Boolean;

			trace( "Type: " + Capabilities.manufacturer );
			trace( "XRes: " + Capabilities.screenResolutionX );
			trace( "YRes: " + Capabilities.screenResolutionY );

			if ( Capabilities.manufacturer.indexOf( "iOS" ) >= 0 ) {
				if ( Capabilities.screenResolutionX == 1536 && Capabilities.screenResolutionY == 2048 ) {
					isCurrentlyPortrait =
						this.stage.orientation == StageOrientation.DEFAULT || this.stage.orientation == StageOrientation.UPSIDE_DOWN;
					filePath = isCurrentlyPortrait ? _splashImg_Portrait_2x : _splashImg_Landscape_2x;
				}
				else if ( Capabilities.screenResolutionX == 1242 && Capabilities.screenResolutionY == 2208 ) {
					isCurrentlyPortrait =
						this.stage.orientation == StageOrientation.DEFAULT || this.stage.orientation == StageOrientation.UPSIDE_DOWN;
					filePath = isCurrentlyPortrait ? _splashImg_414w_736h_3x : _splashImg_414w_736h_landscape_3x;
				} else if ( Capabilities.screenResolutionX == 768 && Capabilities.screenResolutionY == 1024 ) {
					isCurrentlyPortrait =
						this.stage.orientation == StageOrientation.DEFAULT || this.stage.orientation == StageOrientation.UPSIDE_DOWN;
					filePath = isCurrentlyPortrait ? _splashImg_Portrait : _splashImg_Landscape;
				} 
				else if ( Capabilities.screenResolutionX == 750 ) {
					isPortraitOnly = true;
					
					if ( Capabilities.screenResolutionY == 1334 ) {
						filePath = _splashImg_375w_677h_2x;
					} else {
						filePath = _splashImg_Default_2x;
					}
				} else if ( Capabilities.screenResolutionX == 640 ) {
					isPortraitOnly = true;

					if ( Capabilities.screenResolutionY == 1136 ) {
						filePath = _splashImg_568h_2x;
					} else {
						filePath = _splashImg_Default_2x;
					}
				} else if ( Capabilities.screenResolutionX == 320 ) {
					isPortraitOnly = true;
					filePath = _splashImg_Default;
				} else {
					isCurrentlyPortrait =
						this.stage.orientation == StageOrientation.DEFAULT || this.stage.orientation == StageOrientation.UPSIDE_DOWN;
					filePath = isCurrentlyPortrait ? _splashImg_Portrait : _splashImg_Landscape;
				}
			} else {
				if ( Capabilities.screenResolutionX == 1536 && Capabilities.screenResolutionY == 2048 ) {
					isCurrentlyPortrait =
						this.stage.orientation == StageOrientation.DEFAULT || this.stage.orientation == StageOrientation.UPSIDE_DOWN;
					filePath = isCurrentlyPortrait ? _splashImg_Portrait_2x : _splashImg_Landscape_2x;
				} 
				else if ( Capabilities.screenResolutionX == 1242 && Capabilities.screenResolutionY == 2208 ) {
					isCurrentlyPortrait =
						this.stage.orientation == StageOrientation.DEFAULT || this.stage.orientation == StageOrientation.UPSIDE_DOWN;
					filePath = isCurrentlyPortrait ? _splashImg_414w_736h_3x : _splashImg_414w_736h_landscape_3x;
				} else if ( Capabilities.screenResolutionX == 768 && Capabilities.screenResolutionY == 1024 ) {
					isCurrentlyPortrait =
						this.stage.orientation == StageOrientation.DEFAULT || this.stage.orientation == StageOrientation.UPSIDE_DOWN;
					filePath = isCurrentlyPortrait ? _splashImg_Portrait : _splashImg_Landscape;
				} else if ( Capabilities.screenResolutionX == 640 ) {
					isPortraitOnly = true;

					if ( Capabilities.screenResolutionY == 1136 ) {
						filePath = _splashImg_568h_2x;
					} else {
						filePath = _splashImg_Default_2x;
					}
				} else if ( Capabilities.screenResolutionX == 320 ) {
					isPortraitOnly = true;
					filePath = _splashImg_Default;
				} else {
					isCurrentlyPortrait =
						this.stage.orientation == StageOrientation.DEFAULT || this.stage.orientation == StageOrientation.UPSIDE_DOWN;
					filePath = isCurrentlyPortrait ? _splashImg_Portrait : _splashImg_Landscape;
				}
			}

			if ( filePath ) {
				filePath = "assets/icons/" + filePath;

				var file:File = File.applicationDirectory.resolvePath( filePath );

				if ( file.exists ) {
					var bytes:ByteArray = new ByteArray();
					var stream:FileStream = new FileStream();
					stream.open( file, FileMode.READ );
					stream.readBytes( bytes, 0, stream.bytesAvailable );
					stream.close();
					this._launchImage = new Loader();
					this._launchImage.loadBytes( bytes );
					this.addChild( this._launchImage );
					this._savedAutoOrients = this.stage.autoOrients;
					this.stage.autoOrients = false;

					if ( isPortraitOnly ) {
						this.stage.setOrientation( StageOrientation.DEFAULT );
					}
				}
			}
		}

		protected function stage_deactivateHandler(event:Event):void
		{
			this._starling.stop();
			this.stage.addEventListener(Event.ACTIVATE, stage_activateHandler, false, 0, true);
		}
		
		protected function stage_activateHandler(event:Event):void
		{
			this.stage.removeEventListener(Event.ACTIVATE, stage_activateHandler);
			this._starling.start();
		}

		private function stage_resizeHandler(event:Event):void
		{
			this._starling.stage.stageWidth = this.stage.stageWidth;
			this._starling.stage.stageHeight = this.stage.stageHeight;
			
			var viewPort:Rectangle = this._starling.viewPort;
			viewPort.width = this.stage.stageWidth;
			viewPort.height = this.stage.stageHeight;
			try
			{
				this._starling.viewPort = viewPort;
			}
			catch(error:Error) {}
			 
			this._starling.showStatsAt(HAlign.LEFT, VAlign.BOTTOM);
		}
		
	}
}
