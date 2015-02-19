/*----------------------------------------------------------------------------*/
/*                                                                            */
/*   Copyright 2012 Anthony Henderson                                           */
/*   All rights reserved.                                                     */
/*                                                                            */
/*----------------------------------------------------------------------------*/

package ahhenderson.core.mvc.patterns.actor {

	import ahhenderson.core.mvc.enums.ActorType;
	import ahhenderson.core.mvc.interfaces.IFacadeActor;
	import ahhenderson.core.mvc.patterns.facade.FacadeMessageFilter;
	import ahhenderson.core.util.ArrayUtil;


	/**
	 *
	 * @author thenderson
	 */
	public class ActorState {

		/**
		 *
		 * @param actor
		 * @param actorKey
		 * @param messageFilter
		 * @param messageDomain
		 * @param messageDomain
		 */
		public function ActorState( actor:IFacadeActor, actorKey:String, 
									messageFilter:FacadeMessageFilter = null, 
									messageDomain:String =null ) {

			this._actor = actor; 
			this._messageFilter = messageFilter;
			this._messageDomain = messageDomain;
			this._actorKey = actorKey;
			this._actorType = actor.actorType;
			
			flattenMessageItems( this._messageFilter );

		}
 
		
		private var _actor:IFacadeActor;

		private var _actorKey:String;
		
		private var _actorType:ActorType;

		private var _flattenendMessageGroups:String;

		private var _flattenendMessageTypes:String;

		private var _messageDomain:String;

		private var _messageFilter:FacadeMessageFilter;
 

		public function get actorType():ActorType
		{
			return _actorType;
		}

		/**
		 *
		 * @return
		 */
		public function get actor():IFacadeActor {

			return _actor;
		}

		/**
		 *
		 * @return
		 */
		public function get actorKey():String {

			return _actorKey;
		}

		/**
		 *
		 * @return
		 */
		public function get flattenendMessageGroups():String {

			return _flattenendMessageGroups;
		}

		/**
		 *
		 * @return
		 */
		public function get flattenendMessageTypes():String {

			return _flattenendMessageTypes;
		}

		/**
		 *
		 * @return
		 */
		public function get messageDomain():String {

			return _messageDomain;
		}

		/**
		 *
		 * @return
		 */
		public function get messageFilter():FacadeMessageFilter {

			return _messageFilter;
		}

		/**
		 *
		 * @param value
		 */
		public function set messageFilter( value:FacadeMessageFilter ):void {

			_messageFilter = value;

			flattenMessageItems( _messageFilter );
		}

		private function flattenMessageItems( messageFilter:FacadeMessageFilter ):void {

			if ( messageFilter ) {
				if ( messageFilter.messageGroups && messageFilter.messageGroups.length > 0 )
					_flattenendMessageGroups = ArrayUtil.sortAndFlattenStringArray( messageFilter.messageGroups, null, false, "|" );

				if ( messageFilter.messageTypes && messageFilter.messageTypes.length > 0 )
					_flattenendMessageTypes = ArrayUtil.sortAndFlattenStringArray( messageFilter.messageTypes, null, false, "|" );
			}
		}
	}
}

