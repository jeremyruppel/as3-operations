//AS3///////////////////////////////////////////////////////////////////////////
// 
// Copyright 2011 AKQA
// 
////////////////////////////////////////////////////////////////////////////////

package com.jeremyruppel.operations.group
{
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
	public class OperationGroup implements IOperationGroup
	{
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
	
		/**
		 * @constructor
		 */
		public function OperationGroup( skipFailed : Boolean = false )
		{
			this.skipFailed = skipFailed;
		}
	
		//--------------------------------------
		//  PRIVATE VARIABLES
		//--------------------------------------
	
		/**
		 * @private
		 */
		private var _succeeded : ISignalOwner;
		
		/**
		 * @private
		 */
		private var _failed : ISignalOwner;
		
		/**
		 * @private
		 */
		private var _operations : Array;
		
		/**
		 * @private
		 */
		private var _calling : Boolean;
		
		/**
		 * @private
		 */
		private var completed : int;
		
		/**
		 * @private
		 */
		private var skipFailed : Boolean;
		
		//--------------------------------------
		//  GETTER/SETTERS
		//--------------------------------------
	
		/**
		 * @inheritDoc
		 */
		public function get succeeded( ) : ISignal
		{
			return _succeeded || ( _succeeded = new Signal( ) );
		}
		
		/**
		 * @inheritDoc
		 */
		public function get failed( ) : ISignal
		{
			return _failed || ( _failed = new Signal( ) );
		}
		
		/**
		 * @private
		 */
		public function get operations( ) : Array
		{
			return _operations || ( _operations = new Array( ) );
		}
		
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
		
		/**
		 * @inheritDoc
		 */
		public function call( ) : void
		{
			if( !_calling )
			{
				_calling = true;
				
				completed = 0;

				for each( var operation : IOperation in operations )
				{
					operation.succeeded.add( onOperationSucceeded );

					operation.failed.add( onOperationFailed );

					operation.call( );
				}
			}
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
		 * description
		 * @private
		 */
		protected function release( ) : void
		{
			if( succeeded.numListeners )
			{
				_succeeded.removeAll( );
			}
			
			if( failed.numListeners )
			{
				_failed.removeAll( );
			}
			
			_calling = false;
		}
	
	}

}