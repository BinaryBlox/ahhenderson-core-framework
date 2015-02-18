//------------------------------------------------------------------------------
//
//   ViziFit, Inc. Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package ahhenderson.core.mvc.patterns.actor {

	import ahhenderson.core.ahhenderson_internal;
	import ahhenderson.core.mvc.enums.ActorType;
	import ahhenderson.core.mvc.interfaces.IModelActor;
	import ahhenderson.core.mvc.patterns.facade.GlobalFacade;
	import ahhenderson.core.util.GuidUtil;

	use namespace ahhenderson_internal;


	public class ModelActor extends AbstractFacadeActor implements IModelActor {

		
		private static var _globalModelKey:String;
		
		public static function get globalModelKey():String
		{
			if(!_globalModelKey)
				_globalModelKey = GuidUtil.createUID();
			
			return _globalModelKey;
		}

		public static function getModelActorKey(actorName:String):String{
			return "_GLOBAL_MODEL_UID-" + globalModelKey;
		}
			
		public function ModelActor( name:String = null ) {

			super( name );
			
			_key = getModelActorKey(name);

		}

		override public function get actorType():ActorType {

			return ActorType.MODEL;
		}

		override public function beforeRemove():void {

			//LogHpr.log(LType.INFO, LCategory.MVC, "REMOVING mediator", "Mediator Id: " + this.mediatorName +  this.mediatorKey);  
			trace( "Before remove!!" );

			this.remove(); // Remove from facade.
		}

		override public function onRegister():void {

			//LogHpr.log(LType.INFO, LCategory.MVC, "ADDING mediator", "Mediator Id: " + this.mediatorName +  this.mediatorKey);

			trace( "ADDING actor: ", this.actorKey );

		}

		override public function remove():void {

			if ( !this.actorName )
				return;

			GlobalFacade.instance.unRegisterActor( this.actorName, this._key );
		}
 

	}
}
