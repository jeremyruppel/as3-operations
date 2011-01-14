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
	import com.jeremyruppel.operations.core.IOperation;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.ISignalOwner;
	import org.osflash.signals.Signal;

	/**
	 * Class.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @author Jeremy Ruppel
	 * @since  13.01.2011
	 */
	public class Operation extends OperationBase
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
		 * tells this operation to succeed, optionally with a payload
		 * @param withData *
		 */
		public function succeed( withData : * = null ) : void
		{
			if( succeeded.numListeners )
			{
				_succeeded.dispatch( withData );
			}
			
			release( );
		}
		
		/**
		 * tells this operation to fail, optionally with a payload
		 * @param withData *
		 */
		public function fail( withData : * = null ) : void
		{
			if( failed.numListeners )
			{
				_failed.dispatch( withData );
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