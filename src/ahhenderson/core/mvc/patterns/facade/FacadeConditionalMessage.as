//------------------------------------------------------------------------------
//
//   Anthony Henderson  Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package ahhenderson.core.mvc.patterns.facade {
	


	public class FacadeConditionalMessage {
		public function FacadeConditionalMessage(success:FacadeMessage, error:FacadeMessage) {
			_success = success;
			_error = error;
		}


		private var _error:FacadeMessage;

		private var _success:FacadeMessage;

		public function get error():FacadeMessage {
			return _error;
		}

		public function get success():FacadeMessage {
			return _success;
		}
	}
}
