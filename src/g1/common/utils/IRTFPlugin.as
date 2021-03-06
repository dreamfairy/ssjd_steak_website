/**
 * RichTextField
 * @author Alex.li - www.riaidea.com
 * @homepage http://code.google.com/p/richtextfield/
 */

package g1.common.utils
{
	import g1.common.components.RichTextField;
	
	/**
	 * RichTextField插件接口，所有插件都应实现此接口。
	 */
	public interface IRTFPlugin
	{
		/**
		 * 安装插件时由RichTextField对象调用。
		 * @param	target 要安装插件的RichTextField对象。
		 */
		function setup(target:RichTextField):void;
		
		/**
		 * 一个布尔值，指示插件是否启用。
		 */
		function get enabled():Boolean;
		
		function set enabled(value:Boolean):void;
	}	
}