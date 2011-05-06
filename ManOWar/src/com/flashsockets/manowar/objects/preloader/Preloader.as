package com.flashsockets.manowar.objects.preloader
{
	import com.flashsockets.manowar.view.ui.interfaces.IView;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.utils.getDefinitionByName;
	
	public class Preloader extends MovieClip implements IView
	{
		private var basicPreloader:MovieClip;
		private var frameEnCours:int = 1;
		
		public function Preloader()
		{
			trace("show preloader at frame 1");
			displayerGraphics();
			setEventListeners();
		}
		
		public function displayerGraphics():void
		{
			basicPreloader = new Preloader_VIEW() as MovieClip;
			addChild(basicPreloader);
		}
		public function setEventListeners():void
		{
			addEventListener(Event.ENTER_FRAME, __checkFrame);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, __progress);
			loaderInfo.addEventListener(Event.COMPLETE, __complete);
		}
		public function removedFromStage(e:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, __checkFrame);
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			
		}
		private function __complete(e:Event):void
		{
			trace("Loader complete");
			basicPreloader.loadingbar.gotoAndStop(100);
		}
		private function __progress(e:ProgressEvent):void
		{
			var fr:int = Math.round((e.bytesTotal/e.bytesTotal)*100);
			basicPreloader.loadingbar.gotoAndStop(fr);
			trace("preloader progress");
		}
		
		private function __checkFrame(e:Event):void
		{
			
			if (basicPreloader.loadingbar.currentFrame == basicPreloader.loadingbar.totalFrames)
			{
				
				stop();
				__init();
				
			}
			
		}
		
		private function __init():void
		{
			
			trace("hide preloader at frama 2 and stop");
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, __progress);
			var mainClass:Class = getDefinitionByName("ManOWar") as Class;
			addChild(new mainClass() as DisplayObject);
			removeChild(basicPreloader);
			
		}
	}
}