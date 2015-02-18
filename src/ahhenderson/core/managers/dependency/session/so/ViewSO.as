/*----------------------------------------------------------------------------*/
/*                                                                            */
/*   Copyright 2010 ViziFit, Inc.                                          */
/*   All rights reserved.                                                     */
/*                                                                            */
/*----------------------------------------------------------------------------*/

package ahhenderson.core.managers.dependency.session.so {
	import ahhenderson.core.collections.interfaces.IDictionaryItem;
	import ahhenderson.core.mvc.patterns.facade.FacadeMessage;
	
	public class ViewSO implements IDictionaryItem{

		private var _viewId:String;
		
		private var _moduleId:String;
		
		private var _menuId:String;
		
		private var _view:*;
		
		private var _message:FacadeMessage;
		
		private var _accessTypeId:String;
		
		private var _key:String;
		
		private var _isUpdateable:Boolean;
		 
		
		public function ViewSO(viewId:String, moduleId:String, menuId:String=null, view:*=null, message:FacadeMessage=null, _accessTypeId:String=null) {

		 	_viewId = viewId;
			_moduleId = moduleId;
			_menuId = menuId;
			_message = message;
			_view = view;
			_accessTypeId = accessTypeId; 
		}
 
		public function get isUpdateable():Boolean {
			return true;
		}

		public function get view():*
		{
			return _view;
		}

		public function get key():String
		{	
			return _moduleId + "_" + _viewId;
		}

		public function get message():FacadeMessage
		{
			return _message;
		}

		public function get accessTypeId():String
		{
			return _accessTypeId;
		}

		public function get menuId():String
		{
			return _menuId;
		}

		public function get moduleId():String
		{
			return _moduleId;
		}

		public function get viewId():String
		{
			return _viewId;
		}
 
	}
}

