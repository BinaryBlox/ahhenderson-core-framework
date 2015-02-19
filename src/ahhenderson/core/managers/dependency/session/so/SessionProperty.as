
package ahhenderson.core.managers.dependency.session.so {
	import ahhenderson.core.util.DateUtil;
	
	public class SessionProperty {

		public function SessionProperty(key:String, context:*, group:String=null, isUpdateable:Boolean=false) {
			this._context=context;
			this._group=group;
			this._key=key;
			this._isUpdateable = isUpdateable;
			this._created=DateUtil.toRFC802(new Date);

		}

		private var _created:String;

		private var _context:*;

		private var _group:String;

		private var _isUpdateable:Boolean;

		private var _key:String;

		public function get isUpdateable():Boolean
		{
			return _isUpdateable;
		}

		/**
		  * Date returned in RFC802 string format (user DateUtils to get date).
		  */
		public function get created():String {
			return _created;
		}

		public function get context():* {
			return _context;
		}

		public function set context(value:*):void {
			_context=value;
		}

		public function get group():String {
			return _group;
		}

		public function get key():String {
			return _key;
		}
	}
}

