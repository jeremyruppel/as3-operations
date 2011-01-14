//AS3///////////////////////////////////////////////////////////////////////////
// 
// Copyright 2011 AKQA
// 
////////////////////////////////////////////////////////////////////////////////

package com.jeremyruppel.operations.support
{
	import com.jeremyruppel.operations.base.Operation;
	import com.jeremyruppel.operations.core.IOperation;
	import com.jeremyruppel.operations.core.IOperationFactory;

	/**
	 * Class.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @author Jeremy Ruppel
	 * @since  13.01.2011
	 */
	public class FailureOperationFactory implements IOperationFactory
	{
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
	
		/**
		 * @constructor
		 */
		public function FailureOperationFactory( message : String )
		{
			this.message = message;
		}
	
		//--------------------------------------
		//  PRIVATE VARIABLES
		//--------------------------------------
	
		/**
		 * @private
		 */
		private var message : String;

		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
	
		public function create( payload : * = null ) : IOperation
		{
			return new Operation( null, String, function( operation : Operation ) : void
			{
				operation.fail( message );
			} );
		}
	
	}

}