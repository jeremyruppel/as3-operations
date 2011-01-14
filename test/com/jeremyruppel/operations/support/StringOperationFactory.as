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
	public class StringOperationFactory implements IOperationFactory
	{
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
	
		/**
		 * @constructor
		 */
		public function StringOperationFactory( string : String )
		{
			this.string = string;
		}
		
		//--------------------------------------
		//  PRIVATE VARIABLES
		//--------------------------------------
		
		/**
		 * @private
		 */
		private var string : String;

		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		
		/**
		 * @inheritDoc
		 */
		public function create( payload : * = null ) : IOperation
		{
			return new Operation( String, String, function( operation : Operation ) : void
			{
				operation.succeed( string );
			} );
		}
	
	}

}
