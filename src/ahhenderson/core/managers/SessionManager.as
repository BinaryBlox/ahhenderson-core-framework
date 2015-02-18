//------------------------------------------------------------------------------
//
//   Copyright ViziFit, Inc. 2010 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package ahhenderson.core.managers {
    import flash.events.EventDispatcher;
    
    import ahhenderson.core.managers.dependency.session.so.SessionProperty;
    import ahhenderson.core.util.DateUtil;
 
    public class SessionManager extends EventDispatcher {

        // =======================================
        //  Singleton instance
        // =======================================

        /** Storage for the singleton instance. */
        private static const _instance:SessionManager = new SessionManager(SingletonLock);

		protected function get logger():LoggingManager
		{
			if(!_logger)
				_logger = LoggingManager.instance;
			
			return _logger;
		}

        /** Provides singleton access to the instance. */
        public static function get instance():SessionManager {
            return _instance;
        }



        /**
         * Constructor
         *
         * @param lock The Singleton lock class to pevent outside instantiation.
         */
        public function SessionManager(lock:Class) {
            // Verify that the lock is the correct class reference.
            if (lock != SingletonLock) {
                throw new Error("Invalid Singleton access.  Use Model.instance.");
            }

            _sessionProperties = new Vector.<SessionProperty>();

        }

        public var debugState:Boolean = false;

        private const CLASS_NAME:String = "SessionManager";

        private var _sessionProperties:Vector.<SessionProperty>;

        private var _sessionCreated:String;

        private var _sessionId:String;
 
		private var _logger:LoggingManager;
	 
		
        /**
         * Registers or new or updates an existing session member.
         *
         * @key: Key for new session member to be added/updated.
         * @context: object context for session member.
         * @group: for grouping session items together
         * @isUpdateable: Can update be performed via another add?
         *
         * @langversion 3.0
         * @playerversion Flash 11.5
         * @playerversion AIR 3.5
         * @productversion Starling 1.2, Flex 4.6 
         */
        public function addProperty(key:String, context:*, group:String = null, isUpdateable:Boolean = true):Boolean {

            if (!key || context == null) {
				//LogHpr.log(LType.INFO, LCategory.SESSION, "Add item failed", "Key or context was not provided for session member..."); 
       
            }

            var sessionMember:SessionProperty = new SessionProperty(key, context, group, isUpdateable);
            var existingIndex:int = searchSessionMembers(sessionMember.key);
            var bSuccess:Boolean;

            try {
                if (existingIndex >= 0) {
					//LogHpr.log(LType.INFO, LCategory.SESSION, "item update", "Updating context for session member: " + sessionMember.key); 
                    
                    if (sessionMember.isUpdateable) // Only update session member context if allowed.
                        _sessionProperties[existingIndex].context = sessionMember.context;

                } else {
					//LogHpr.log(LType.INFO, LCategory.SESSION, "item add", "Registering session member: " + sessionMember.key);                  
                    _sessionProperties.push(sessionMember);
                }

                bSuccess = true;
            } catch (error:Error) {
				//LogHpr.log(LType.ERROR, null, "Add Item Error", "Error attempting to register session member: " + error.message); 
            
            } finally {
                return bSuccess;
            }
        }

        /**
         * Returns session member value or SessionMemberSO; if an error occurs an Error object will be returned.
         *
         * @memberKey: Key of session member
         * @returnSessionMemberSO: Return for SessionMemberSO
         *
         * @langversion 3.0
         * @playerversion Flash 11.5
         * @playerversion AIR 3.5
         * @productversion Starling 1.2, Flex 4.6 
         */
        public function getProperty(propertyName:String, returnPropertyMetadata:Boolean = false):* {

            try {
                if (_sessionProperties == null || _sessionProperties.length == 0) {
                    return new Error("No session members have been registered...");
                    trace("No session members have been registered...");
                }

                for each (var sessionMember:SessionProperty in _sessionProperties) {

                    var existingMemberKey:String = sessionMember.key;
                    if (propertyName == existingMemberKey) {
                        //trace("Found registered session member " + memberKey);

                        if (returnPropertyMetadata)
                            return sessionMember;
                        else
                            return sessionMember.context;

                    }
                }
            } catch (error:Error) {
                throw new Error(error.message);
            }

            return null;


        }

		public function set properties(value:Object):void{
			
			
		}
        /**
         * Unregisters existing session member.
         *
         * @sessionMember: object containing information about the session member to be added)
         *
         * @langversion 3.0
         * @playerversion Flash 11.5
         * @playerversion AIR 3.5
         * @productversion Starling 1.2, Flex 4.6 
         */
        public function removeProperty(key:String):Boolean {

            var existingIndex:int = searchSessionMembers(key);
            var bSuccess:Boolean;

            try {
                if (existingIndex >= 0) {
                    rebuildArray(existingIndex);
                    trace("Registered session member removed.." + key);

                } else
                    trace("Registered session member not found: " + key);

                bSuccess = true;
            } catch (error:Error) {
                trace("Adding Session Member Error: " + error.message);
            } finally {
                return bSuccess;
            }
        }

        /**
         * Resets current session
         *
         * @token: Security token required to reset session.
         *
         * @langversion 3.0
         * @playerversion Flash 11.5
         * @playerversion AIR 3.5
         * @productversion Starling 1.2, Flex 4.6 
         */
        public function reset(token:String = null):void {
            _sessionId = null;
            _sessionCreated = null;
            _sessionProperties = null;
        }

        public function get sessionCreated():String {
            return _sessionCreated;
        }

        public function get sessionId():String {
			
			if(!_sessionId)
				throw new Error("Session not created");
			
            return _sessionId;
        }



        /**
         * Starts a new session (only if session doesn't exist)
         *
         * @token: Security token required to reset session.
         *
         * @langversion 3.0
         * @playerversion Flash 11.5
         * @playerversion AIR 3.5
         * @productversion Starling 1.2, Flex 4.6 
         */
        public function start(token:String = null):void {
			
            if (!_sessionId) { 
				
				if(!token)
					throw new Error("Session token is empty...");   
				
                _sessionId = token;
                _sessionCreated = DateUtil.toRFC802(new Date());
				
				logger.trace(instance, "Starting session with token: " + _sessionId);
				logger.trace(instance, "Starting session time: " + _sessionCreated);
                return;
            }
			
			throw new Error("Session alread started...");   
        } 

        // Rebuilds array after removing existing item
        private function rebuildArray(existingIndex:int):void {

            var varr:Vector.<SessionProperty> = new Vector.<SessionProperty>();

            for (var i:int = 0; i < _sessionProperties.length; i++) {
                if (i != existingIndex)
                    varr.push(_sessionProperties[i]);

            }

            _sessionProperties = varr;
        }

        private function searchSessionMembers(memberKey:String):Number {

            for (var i:int = 0; i < _sessionProperties.length; i++) {
                var existingMemberKey:String = _sessionProperties[i].key;

                if (memberKey == existingMemberKey) {
                    //trace("Found registered session member: " + memberKey);
                    return i;
                }
            }

            return -1;
        }
    }
}

class SingletonLock {
}
