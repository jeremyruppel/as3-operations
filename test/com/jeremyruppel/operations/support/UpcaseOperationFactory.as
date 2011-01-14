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
	public class UpcaseOperationFactory implements IOperationFactory
	{
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
	
		/**
		 * @constructor
		 */
		public function UpcaseOperationFactory( )
		{
		}

		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		
		/**
		 * @inheritDoc
		 * @param payload *
		 * @return IOperation 
		 */
		public function create( payload : * = null ) : IOperation
		{
			return new Operation( String, String, function( operation : Operation ) : void
			{
				if( payload is String )
				{
					operation.succeed( String( payload ).toUpperCase( ) );
				}
				else
				{
					operation.fail( 'Payload "' + payload + '" was not of the expected type ' + String + '.' );
				}
			} );
		}
	
	}

}
