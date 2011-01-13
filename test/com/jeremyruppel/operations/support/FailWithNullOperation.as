//AS3///////////////////////////////////////////////////////////////////////////
// 
// Copyright 2011 AKQA
// 
////////////////////////////////////////////////////////////////////////////////

package com.jeremyruppel.operations.support
{
	import com.jeremyruppel.operations.base.Operation;

	/**
	 * Class.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @author Jeremy Ruppel
	 * @since  13.01.2011
	 */
	public class FailWithNullOperation extends Operation
	{
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
	
		/**
		 * @constructor
		 */
		public function FailWithNullOperation( )
		{
			super( null, null, function( operation : Operation ) : void
			{
				operation.fail( );
			} );
		}
	
	}

}