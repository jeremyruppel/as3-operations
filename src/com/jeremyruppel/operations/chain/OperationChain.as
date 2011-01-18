//AS3///////////////////////////////////////////////////////////////////////////
// 
// Copyright (c) 2011 the original author or authors
//
// Permission is hereby granted to use, modify, and distribute this file
// in accordance with the terms of the license agreement accompanying it.
// 
////////////////////////////////////////////////////////////////////////////////

package com.jeremyruppel.operations.chain
{
	import com.jeremyruppel.operations.base.OperationBase;
	import com.jeremyruppel.operations.core.IOperationFactory;
	import com.jeremyruppel.operations.core.IOperation;

	/**
	 * Simple helper class for chaining operations together.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @author Jeremy Ruppel
	 * @since  13.01.2011
	 */
	public class OperationChain extends OperationBase
	{
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
	
		/**
		 * @constructor
		 */
		public function OperationChain( )
		{
		}
	
		//--------------------------------------
		//  PRIVATE VARIABLES
		//--------------------------------------
	
		/**
		 * @private
		 */
		private var factories : Array = new Array( );
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		
		/**
		 * adds a new operation factory to the chain
		 * @param factory IOperationFactory
		 * @return OperationChain 
		 */
		public function add( factory : IOperationFactory ) : OperationChain
		{
			factories.push( factory );
			
			return this;
		}
		
		//--------------------------------------
		//  EVENT HANDLERS
		//--------------------------------------
		
		/**
		 * @param payload *
		 * @private
		 */
		protected function onOperationSucceeded( payload : * ) : void
		{
			proceed( payload );
		}
		
		/**
		 * @param payload *
		 * @private
		 */
		protected function onOperationFailed( payload : * ) : void
		{
			if( failed.numListeners )
			{
				_failed.dispatch( payload );
			}
			
			release( );
		}
		
		//--------------------------------------
		//  PRIVATE & PROTECTED INSTANCE METHODS
		//--------------------------------------
		
		/**
		 * @inheritDoc
		 */
		override protected function begin( ) : void
		{
			proceed( );
		}
		
		/**
		 * @param payload *
		 * @private
		 */
		protected function proceed( payload : * = null ) : void
		{
			if( factories.length )
			{
				var factory : IOperationFactory = factories.shift( );
				
				var operation : IOperation = factory.create.call( null, payload );
				
				operation.succeeded.add( onOperationSucceeded );
				
				operation.failed.add( onOperationFailed );
				
				operation.call( );
			}
			else
			{
				if( succeeded.numListeners )
				{
					_succeeded.dispatch( payload );
				}
				
				release( );
			}
			
		}
	
	}

}