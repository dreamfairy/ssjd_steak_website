package ssjd.indexLayer
{
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getDefinitionByName;

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
			
			m_sceneW = 1000;
			m_sceneH = 766;
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
			reflectClass = getDefinitionByName("rightBarIcon") as Class;
			m_rightBarIcon = new reflectClass();
			reflectClass = getDefinitionByName("leftBarIcon") as Class;
			m_leftBarIcon = new reflectClass();
			
			m_rightBarIcon.graphics.beginFill(0,0);
			m_rightBarIcon.graphics.drawRect(24,15,m_rightBarIcon.width,m_rightBarIcon.height);
			m_rightBarIcon.graphics.endFill();
			
			m_leftBarIcon.graphics.beginFill(0,0);
			m_leftBarIcon.graphics.drawRect(24,15,m_leftBarIcon.width,m_leftBarIcon.height);
			m_leftBarIcon.graphics.endFill();
			
			m_centerBtn.x = m_halfSceneW - 154.40;
			m_leftBtn.x = m_halfSceneW - 155;
			m_leftBarIcon.x = m_halfSceneW;
			m_leftBarIcon.alpha = 0;
			m_rightBtn.scaleX = -1;
			m_rightBtn.x = m_halfSceneW + 267;
			m_rightBarIcon.x = m_halfSceneW;
			m_rightBarIcon.alpha = 0;
			
			m_root.addChild(m_leftBtn);
			m_root.addChild(m_leftBarIcon);
			m_root.addChild(m_rightBtn);
			m_root.addChild(m_rightBarIcon);
			m_root.addChild(m_centerBtn);
//			m_centerBtn.alpha = .5;
			
			m_rightBtn.visible = false;
			m_leftBtn.visible = false;
			
			tweenImage(m_logo,  m_halfSceneW, 10);
		}
		
		protected function onClickMenu(event:MouseEvent):void
		{
			m_root.dispatchEvent(new Event("menu"));
		}
		
		protected function onClickBack(event:MouseEvent):void
		{
			m_root.dispatchEvent(new Event("back"));
		}
		
		public function showSubMenu() : void
		{
			if(m_onHideTweening){
				TweenLite.killTweensOf(m_leftBtn);
				TweenLite.killTweensOf(m_rightBtn);
				hideOver();
			}
			
			TweenLite.killTweensOf(m_rightBtn);
			m_rightBtn.visible = true;
			m_leftBtn.visible = true;
			
			m_leftBtn.gotoAndPlay(1);
			m_rightBtn.gotoAndPlay(1);
			
			TweenLite.to(m_leftBarIcon,.5,{x:m_halfSceneW + 125, alpha : 1});
			TweenLite.to(m_rightBarIcon,.5,{x:m_halfSceneW - 105, alpha : 1});
			
			m_rightBarIcon.buttonMode = true;
			m_leftBarIcon.buttonMode = true;
			
			m_leftBarIcon.addEventListener(MouseEvent.CLICK, onClickBack);
			m_rightBarIcon.addEventListener(MouseEvent.CLICK, onClickMenu);
		}
		
		public function onMoveOver() : void
		{
			TweenLite.killTweensOf(m_leftBarIcon);
			TweenLite.killTweensOf(m_rightBarIcon);
			m_leftBarIcon.x = m_halfSceneW;
			m_rightBarIcon.x = m_halfSceneW;
			m_leftBarIcon.alpha = 0;
			m_rightBarIcon.alpha = 0;
			
			m_rightBarIcon.buttonMode = false;
			m_leftBarIcon.buttonMode = false;
			
			m_leftBarIcon.removeEventListener(MouseEvent.CLICK, onClickBack);
			m_rightBarIcon.removeEventListener(MouseEvent.CLICK, onClickMenu);
		}
		
		public function hideSubMenu() : void
		{
			TweenLite.to(m_rightBtn, .2,{x: m_halfSceneW + 347 , onComplete : hideOver});
			TweenLite.to(m_leftBtn,.2,{x:m_halfSceneW - 235});
			
			TweenLite.to(m_rightBarIcon,.2,{x: m_halfSceneW,onComplete : onMoveOver});
			TweenLite.to(m_leftBarIcon,.2,{x: m_halfSceneW});
			
			m_onHideTweening = true;
		}
		
		public function hideOver() : void
		{
			TweenLite.killTweensOf(m_leftBtn);
			TweenLite.killTweensOf(m_rightBtn);
			
			m_rightBtn.x = m_halfSceneW + 267;
			m_leftBtn.x = m_halfSceneW - 155;
			m_leftBtn.visible = false;
			m_rightBtn.visible = false;
			
			m_onHideTweening = false;
		}
		
		public function reset() : void
		{
//			if(null == m_centerBtn) return;
//			
//			m_centerBtn.gotoAndPlay(1);
//			tweenImage(m_logo,  m_halfSceneW, 10);
		}
		
		private function tweenImage(image : DisplayObject, x : int, y : int):void
		{
			m_root.addChild(image);
			image.x = x;
			image.y = y;
			image.alpha = 0;
			TweenLite.to(image,1,{alpha : 1,delay : 1});
		}
		
		private var m_rightBarIcon : MovieClip;
		private var m_leftBarIcon : MovieClip;
		
		private var m_onHideTweening : Boolean;
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