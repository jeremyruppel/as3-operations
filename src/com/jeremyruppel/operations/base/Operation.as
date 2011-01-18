//AS3///////////////////////////////////////////////////////////////////////////
// 
// Copyright (c) 2011 the original author or authors
//
// Permission is hereby granted to use, modify, and distribute this file
// in accordance with the terms of the license agreement accompanying it.
// 
////////////////////////////////////////////////////////////////////////////////

package com.jeremyruppel.operations.base
{
	import com.jeremyruppel.operations.core.IOperationOwner;

	/**
	 * Simple operation implementation. Provides owner-exposed methods to control
	 * success and failure of the operation.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @author Jeremy Ruppel
	 * @since  13.01.2011
	 */
	public class Operation extends OperationBase implements IOperationOwner
	{
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
	
		/**
		 * @constructor
		 */
		public function Operation( successClass : Class, failureClass : Class, block : Function )
		{
			super( successClass, failureClass );
			
			this.block = block;
		}
	
		//--------------------------------------
		//  PRIVATE VARIABLES
		//--------------------------------------
		
		/**
		 * @private
		 */
		protected var block : Function;
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		
		/**
		 * @inheritDoc
		 */
		public function succeed( payload : * = null ) : void
		{
			if( succeeded.numListeners )
			{
				_succeeded.dispatch( payload );
			}
			
			release( );
		}
		
		/**
		 * @inheritDoc
		 */
		public function fail( payload : * = null ) : void
		{
			if( failed.numListeners )
			{
				_failed.dispatch( payload );
			}
			
			release( );
		}
		
		//--------------------------------------
		//  PROTECTED METHODS
		//--------------------------------------
		
		/**
		 * @inheritDoc
		 */
		override protected function begin( ) : void
		{
			block.call( null, this );
		}

	}

}
