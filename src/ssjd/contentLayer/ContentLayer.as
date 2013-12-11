package ssjd.contentLayer
{
	import flash.display.DisplayObjectContainer;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.Dictionary;
	
	import g1.common.loader.SWFLoader;
	
	import ssjd.contentLayer.menu.Menu;

	public class ContentLayer
	{
		private var m_root : Sprite;
		private static var s_singleton : ContentLayer;
		
		public function ContentLayer()
		{
			s_singleton = this;
		}
		
		public function init(root : Sprite) : void
		{
			m_loader = new SWFLoader();
			m_loader.addEventListener(Event.COMPLETE, __onLoaded);
			m_root = root;
			contentInit();
			
			// test
			//loadContent(MENU);
		}
		
		private function contentInit():void
		{
			m_contentDict = new Dictionary();
			var item : ContentItem;
			item = new ContentItem();
			item.type = GUIDE;
			item.dir = "guide/";
			item.swf = "guide.swf";
			m_contentDict[GUIDE] = item;
			
			item = new ContentItem();
			item.type = MEMBER;
			item.swf = "guide.swf";
			m_contentDict[MEMBER] = item;
			
			item = new ContentItem();
			item.type = JOIN_INTRO;
			item.swf = "guide.swf";
			m_contentDict[JOIN_INTRO] = item;
			
			item = new ContentItem();
			item.type = SHOP_INFO;
			item.swf = "guide.swf";
			m_contentDict[SHOP_INFO] = item;
			
			item = new ContentItem();
			item.type = SALE_INFO;
			item.swf = "guide.swf";
			m_contentDict[SALE_INFO] = item;
			
			item = new ContentItem();
			item.type = MENU;
			item.dir = "menu/";
			item.contentClass = Menu;
			item.swf = "menu.swf";
			m_contentDict[MENU] = item;
			
			item = new ContentItem();
			item.type = CONTACT_US;
			item.swf = "guide.swf";
			m_contentDict[CONTACT_US] = item;
			
			item = new ContentItem();
			item.type = ABOUT_US;
			item.swf = "guide.swf";
			m_contentDict[ABOUT_US] = item;
			
		}
		
		public function setBaseDir(dir : String) : void
		{
			m_baseDir = dir;
		}
		
		public function loadContent(type : int) : void
		{
			var item : ContentItem = m_contentDict[type];
			if (!item) {
				throw new Error("没有此项! type = " + type);
			}
			
			// 记录要加载的项
			m_loadItem = item;
			
			if (m_currentItem) {
				if (m_currentItem.type == type) return;
				// 让当前开始销毁
				m_currentItem.content.destroy();
			}
			else {
				// 开始加载
				loadItem();
			}
		}
		
		private function loadItem():void
		{
			// 如果已经加载好，先初始化
			if (m_loadItem.content) {
				onItemInit(m_loadItem.content);
			}
				//　否则直接加载
			else {
				// 记录要加载的项
				var url : String = m_baseDir + m_loadItem.path;
				var context : LoaderContext = new LoaderContext();
				context.applicationDomain = ApplicationDomain.currentDomain;
				m_loader.load(new URLRequest(url), context);				
			}			
		}
		
		// 当单个项销毁完，加载加载
		public function onItemDestroy(item : IContent) : void
		{
			// 移除
			m_root.removeChild(item.getContent());
			// 通知当前销毁
			notifyItemDestroy();
			
			// 加载
			loadItem();
		}
		
		// 当单个项初始化完
		public function onItemInit(item : IContent) : void
		{ 
			// 设为当前项
			m_currentItem = m_contentDict[item.type];
			// 开始添加
			m_root.addChild(item.getContent());
			// 显示相应的项
			item.show();
			// 通知加载完成
			notifyItemInit();
		}
		
		private function notifyItemInit():void
		{
			// 告知控制变化
			// 告知加载变化

		}
		
		private function notifyItemDestroy() : void
		{
			// 告知控制变化
			// 告知加载变化
		}
		
		private function __onLoaded(event:Event):void
		{
			if (m_loadItem) {
				var content : IContent = new m_loadItem.contentClass();
				content.baseDir = m_baseDir + m_loadItem.dir;
				m_loadItem.content = content;
				var con : DisplayObjectContainer = m_loader.getContent() as DisplayObjectContainer;
				// 开始初始化
				content.init(con);
			}
			else {
				throw new Error("末发现加载项!");
			}
		}
		
		public static function get singleton() : ContentLayer
		{
			return s_singleton ||= new ContentLayer();
		}
		
		public static const GUIDE 			: int = 1;
		public static const MEMBER 			: int = 2;
		public static const JOIN_INTRO		: int = 3;
		public static const SHOP_INFO		: int = 4;
		public static const SALE_INFO		: int = 5;
		public static const MENU			: int = 6;
		public static const CONTACT_US		: int = 7;
		public static const ABOUT_US		: int = 8;
		
		private var m_loadItem : ContentItem;
		private var m_currentItem : ContentItem;
		private var m_loader : SWFLoader;
		private var m_baseDir : String;
		private var m_contentDict : Dictionary;
	}
}
import flash.display.DisplayObjectContainer;

import ssjd.contentLayer.IContent;

class ContentItem {
	public var type : int;
	public var dir : String;
	public var swf  : String;
	public var name : String;
	public var contentClass : Class;
	public var content : IContent;
	
	public function get path() : String
	{
		return dir + swf;
	}
}