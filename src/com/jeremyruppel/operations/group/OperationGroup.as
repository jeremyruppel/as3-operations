//AS3///////////////////////////////////////////////////////////////////////////
// 
// Copyright (c) 2011 the original author or authors
//
// Permission is hereby granted to use, modify, and distribute this file
// in accordance with the terms of the license agreement accompanying it.
// 
////////////////////////////////////////////////////////////////////////////////

package com.jeremyruppel.operations.group
{
	import com.jeremyruppel.operations.base.OperationBase;
	import com.jeremyruppel.operations.core.IOperation;
	import com.jeremyruppel.operations.core.IOperationGroup;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.ISignalOwner;
	import org.osflash.signals.Signal;

	/**
	 * Basic operation group that calls all of its sub-operations at the
	 * same time and succeeds when all of the sub-operations have
	 * succeeded. Can optionally be configured to skip failures.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @author Jeremy Ruppel
	 * @since  13.01.2011
	 */
	public class OperationGroup extends OperationBase implements IOperationGroup
	{
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
	
		/**
		 * @constructor
		 */
		public function OperationGroup( skipFailed : Boolean = false )
		{
			super( );
			
			this.skipFailed = skipFailed;
		}
	
		//--------------------------------------
		//  PRIVATE VARIABLES
		//--------------------------------------
		
		/**
		 * @private
		 */
		private var operations : Array = new Array( );
		
		/**
		 * @private
		 */
		private var completed : int;
		
		/**
		 * @private
		 */
		private var skipFailed : Boolean;
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------

		/**
		 * @inheritDoc
		 * @param operation IOperation
		 * @return IOperationGroup 
		 */
		public function add( operation : IOperation ) : IOperationGroup
		{
			operations.push( operation );
			
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
			if( ++completed == operations.length )
			{
				if( succeeded.numListeners )
				{
					_succeeded.dispatch( );
				}
				
				release( );
			}
		}
		
		/**
		 * @param payload *
		 * @private
		 */
		protected function onOperationFailed( payload : * ) : void
		{
			if( skipFailed )
			{
				onOperationSucceeded( payload );
			}
			else
			{
				if( failed.numListeners )
				{
					_failed.dispatch( );
				}
				
				release( );
			}
		}
		
		//--------------------------------------
		//  PROTECTED METHODS
		//--------------------------------------
		
		/**
		 * @inheritDoc
		 */
		override protected function begin( ) : void
		{
			completed = 0;

			for each( var operation : IOperation in operations )
			{
				operation.succeeded.add( onOperationSucceeded );

				operation.failed.add( onOperationFailed );

				operation.call( );
			}
		}
	
	}

}
