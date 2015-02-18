/*----------------------------------------------------------------------------*/
/*                                                                            */
/*   Copyright 2010 ViziFit, Inc.                                          */
/*   All rights reserved.                                                     */
/*                                                                            */
/*----------------------------------------------------------------------------*/

package ahhenderson.core.managers.dependency.session.so {

	import ahhenderson.core.mvc.patterns.facade.FacadeMessage;

	public class ModuleWidgetSO {


		public function ModuleWidgetSO(widgetClass:String, destination:FacadeMessage, postLoadAction:FacadeMessage = null, accessTypeId:String = null, ...widgetArgs) {

			_widgetClass=widgetClass;
			_destination=destination;
			_postLoadAction=postLoadAction;
			_accessTypeId=accessTypeId;
			_widgetArgs = widgetArgs;

		}

		private var _accessTypeId:String;

		private var _destination:FacadeMessage;

		private var _postLoadAction:FacadeMessage;

		private var _widgetClass:String;

		private var _widgetArgs:Array;
		
		public function get widgetArgs():Array
		{
			return _widgetArgs;
		}

		public function get accessTypeId():String {

			return _accessTypeId;
		}


		public function get destination():FacadeMessage {

			return _destination;
		}


		public function get postLoadAction():FacadeMessage {

			return _postLoadAction;
		}


		public function get widgetClass():String {

			return _widgetClass;
		}
		
		// Use when passing in rest parameters argument.
		public function setArgs(...args):void{
			_widgetArgs = args;
		}
	}
}

