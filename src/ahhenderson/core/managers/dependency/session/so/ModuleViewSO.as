/*----------------------------------------------------------------------------*/
/*                                                                            */
/*   Copyright 2010 ViziFit, Inc.                                          */
/*   All rights reserved.                                                     */
/*                                                                            */
/*----------------------------------------------------------------------------*/

package ahhenderson.core.managers.dependency.session.so {
	import ahhenderson.core.mvc.patterns.facade.FacadeMessage;
	
	public class ModuleViewSO  {

		private var _viewClass:String; 
		
		private var _menuId:String;
		  
		private var _destination:FacadeMessage;
		
		private var _postLoadAction:FacadeMessage;
		
		private var _accessTypeId:String;
		
		private var _viewArgs:Array;
	 
		private var _customViewId:String;
		
		public function ModuleViewSO(viewClass:String, menuId:String, destination:FacadeMessage, postLoadAction:FacadeMessage=null, accessTypeId:String=null, customViewId:String=null, ...viewArgs) {

		 	_viewClass = viewClass; 
			_menuId = menuId;
			_destination = destination;
			_postLoadAction = postLoadAction;
			_accessTypeId = accessTypeId;
			_customViewId = customViewId;
			_viewArgs = viewArgs;
		}
  

		public function get customViewId():String
		{
			return _customViewId;
		}

		public function get viewArgs():Array
		{
			return _viewArgs;
		}

		public function get accessTypeId():String
		{
			return _accessTypeId;
		}

		public function get postLoadAction():FacadeMessage
		{
			return _postLoadAction;
		}

		public function get destination():FacadeMessage
		{
			return _destination;
		}

		public function get menuId():String
		{
			return _menuId;
		}

		public function get viewClass():String
		{
			return _viewClass;
		}

		// Use when passing in rest parameters argument.
		public function setArgs(...args):void{
			_viewArgs = args;
		}
		
	}
}

