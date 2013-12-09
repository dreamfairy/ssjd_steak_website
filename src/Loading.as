package
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.Timer;
	import flash.utils.setTimeout;

	[SWF(width="1000", height = "766", frameRate="30")]
	public class Loading extends Sprite
	{
		private var m_loaderMC : MovieClip;
		private var m_loader : Loader;
		private var m_currentFrame : uint;
		private var m_hasInited : Boolean;
		private var m_timer : Timer;
		
		public function Loading()
		{
			stage ? init() : addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null) : void
		{
			if(!hasEventListener(Event.ADDED_TO_STAGE))
				removeEventListener(Event.ADDED_TO_STAGE, init);
			
			m_currentFrame = 0;
			stage.addEventListener(Event.ENTER_FRAME, onEnter);
			
			m_loader = new Loader();
			m_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			m_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
			m_loader.load(new URLRequest("./res/Loading.swf"), new LoaderContext(ApplicationDomain.currentDomain));
			
			m_timer = new Timer(50,7);
			m_timer.addEventListener(TimerEvent.TIMER, onTimer);
		}
		
		private function onComplete(e:Event) : void
		{
			m_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
			m_loaderMC = m_loader.contentLoaderInfo.content as MovieClip;
			startup();
		}
		
		private function onError(e:IOErrorEvent) : void
		{
			
		}
		
		private var tempFrame : uint = 0;
		private function onEnter(e:Event) : void
		{
			m_currentFrame = tempFrame++ % 30 + 1;
			
			if(!m_hasInited) return;
			var lastMc : MovieClip = m_loaderMC.getChildByName("it" + 7) as MovieClip;
			if(lastMc.currentFrame == lastMc.totalFrames){
				m_timer.start();
			}
		}
		
		private function startup() : void
		{
			//初始化暂停所有的loading方块
			var block : MovieClip;
			for(var i : int = 1; i <= 7; i++){
				block = m_loaderMC.getChildByName("it" + i) as MovieClip;
				block.stop();
			}
			addChild(m_loaderMC);
			
			m_timer.start();
			
			setTimeout(loadMain, 2000);
			
			function loadMain() : void
			{
				m_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadMain);
				m_loader.load(new URLRequest("./main.swf"), new LoaderContext(ApplicationDomain.currentDomain));
			}
			
			m_hasInited = true;
		}
		
		protected function onLoadMain(event:Event):void
		{
			m_timer.stop();
			m_timer.removeEventListener(TimerEvent.TIMER, onTimer);
			m_timer = null;
			stage.removeEventListener(Event.ENTER_FRAME, onEnter);
			removeChild(m_loaderMC);
			m_loaderMC = null;
			
			addChild(m_loader.contentLoaderInfo.content);
		}
		
		private function onTimer(e:TimerEvent) : void
		{
			var count : int = Timer(e.target).currentCount % 7 + 1;
			var block : MovieClip = m_loaderMC.getChildByName("it" + count) as MovieClip; 
			block.play();
		}
	}
}