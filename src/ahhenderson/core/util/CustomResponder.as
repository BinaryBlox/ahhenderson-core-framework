////////////////////////////////////////////////////////////////////////////////
//
//  ADOBE SYSTEMS INCORPORATED
//  Copyright 2005-2007 Adobe Systems Incorporated
//  All Rights Reserved.
//
//  NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

package ahhenderson.core.util
{
	import mx.rpc.IResponder;
	
	import ahhenderson.core.mvc.patterns.facade.FacadeMessage;

/**
 *  This class provides a default implementation of 
 *  the mx.rpc.IResponder interface.
 *  
 *  @langversion 3.0
 *  @playerversion Flash 9
 *  @playerversion AIR 1.1
 *  @productversion Flex 3
 */
public class CustomResponder implements IResponder
{
    /**
     *  Constructs an instance of the responder with the specified handlers.
     *  
     *  @param  result Function that should be called when the request has
     *           completed successfully.
     *  @param  fault Function that should be called when the request has
     *          completed with errors.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    public function CustomResponder(result:Function, fault:Function, message:FacadeMessage=null)
    {
        super();
        _resultHandler = result;
        _faultHandler = fault;
		_message = message;
    }
    
    /**
     *  This method is called by a remote service when the return value has been 
     *  received.
         *
     *  @param data Object containing the information about the error that occured. .
     *  While <code>data</code> is typed as Object, it is often (but not always) 
     *  an mx.rpc.events.ResultEvent.
     */
    public function result(data:Object):void
    {
        _resultHandler(data, _message);
    }
    
    /**
     *  This method is called by a service when an error has been received.
         *
     *  @param info Object containing the information returned from the request.
     *  While <code>info</code> is typed as Object, it is often (but not always) 
     *  an mx.rpc.events.FaultEvent.
     */
    public function fault(info:Object):void
    {
        _faultHandler(info, _message);
    }
    
    /**
     *  @private
     */
    private var _resultHandler:Function;
    
    /**
     *  @private
     */
    private var _faultHandler:Function;

	/**
	 *  @private
	 */
	public function get message():FacadeMessage
	{
		return _message;
	}

	
	private var _message:FacadeMessage;
	
}


}