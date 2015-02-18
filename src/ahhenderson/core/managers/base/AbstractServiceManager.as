//------------------------------------------------------------------------------
//
//   ViziFit, Inc. Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package ahhenderson.core.managers.base {
	import ahhenderson.core.util.dependency.arg.Arg;
	
	import mx.utils.UIDUtil;
	
	import ahhenderson.core.mvc.patterns.facade.FacadeMessageFilter;
	import ahhenderson.core.mvc.base.AbstractMVCDispatcher;


	public class AbstractServiceManager extends AbstractMVCDispatcher {

		public function AbstractServiceManager() {
			super();

			initialize();
		}


		protected var _isStarted:Boolean;

		protected var _managerId:String;

		private var _managerMessageFilter:FacadeMessageFilter;

		public function get isStarted():Boolean {

			return _isStarted;
		}

		public function get managerId():String {
			return _managerId;
		}

		public function get managerMessageFilter():FacadeMessageFilter {
			return _managerMessageFilter;
		}

		public function set managerMessageFilter(value:FacadeMessageFilter):void {
			_managerMessageFilter = value;
		}

		public function start(args:Vector.<Arg> = null):void {

			_managerId = UIDUtil.createUID();
			_isStarted = true;
		}

		public function stop(args:Vector.<Arg> = null):void {

			_isStarted = false;
		}

		protected function initialize():void {

		}
	}
}
