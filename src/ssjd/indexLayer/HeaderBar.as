package ssjd.indexLayer
{
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import g1.common.loader.SWFLoader;

	/**
	 * 顶部的三个按钮
	 */
	public class HeaderBar
	{
		public function HeaderBar()
		{
		}
		
		public function init(root : DisplayObjectContainer) : void
		{
			m_root = root;
			
			m_sceneW = 980;
			m_sceneH = 760;
			m_halfSceneW = m_sceneW/2;
			m_halfSceneH = m_sceneH/2;
		}
		
		public function setConfig(data : XMLList) : void
		{

		}
		
		public function setBaseDir(baseFolder:String):void
		{
			
		}
		
		protected function onError(event:Event):void
		{
			// TODO Auto-generated method stub
			
		}
		
		public function show() : void
		{
			var reflectClass : Class = getDefinitionByName("topBtn") as Class;
			m_centerBtn = new reflectClass();
			reflectClass = getDefinitionByName("leftBtn") as Class;
			m_leftBtn = new reflectClass();
			m_leftBtn.stop();
			reflectClass = getDefinitionByName("rightBtn") as Class;
			m_rightBtn = new reflectClass();
			m_rightBtn.stop();
			reflectClass = getDefinitionByName("logo") as Class;
			m_logo = new reflectClass();
			
			m_centerBtn.x = m_halfSceneW - 154.40;
			m_root.addChild(m_centerBtn);
			
			tweenImage(m_logo,  m_halfSceneW, 10);
		}
		
		public function reset() : void
		{
			if(null == m_centerBtn) return;
			
			m_centerBtn.gotoAndPlay(1);
			tweenImage(m_logo,  m_halfSceneW, 10);
		}
		
		private function tweenImage(image : DisplayObject, x : int, y : int):void
		{
			m_root.addChild(image);
			image.x = x;
			image.y = y;
			image.alpha = 0;
			TweenLite.to(image,1,{alpha : 1,delay : 1});
		}
		
		public function showSubMenu() : void
		{
			
		}
		
		private var m_root : DisplayObjectContainer;
		private var m_centerBtn : MovieClip;
		private var m_leftBtn : MovieClip;
		private var m_rightBtn : MovieClip;
		private var m_logo : MovieClip;
		
		private var m_sceneW : int;
		private var m_sceneH : int;
		private var m_halfSceneW : int;
		private var m_halfSceneH : int;
		
		private static const CENTER_IMAGE : String = "center";
		private static const LEFT_IMAGE : String = "left";
		private static const RIGHT_IMAGE : String = "right";
	}
}