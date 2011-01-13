//AS3///////////////////////////////////////////////////////////////////////////
// 
// Copyright 2011 AKQA
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
	public class OperationBase implements IOperation
	{
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
	
		/**
		 * @constructor
		 */
		public function OperationBase( successClass : Class = null, failureClass : Class = null )
		{
			_successClass = successClass;
			_failureClass = failureClass;
		}
	
		//--------------------------------------
		//  PRIVATE VARIABLES
		//--------------------------------------
	
		/**
		 * @private
		 */
		protected var _successClass : Class;
		
		/**
		 * @private
		 */
		protected var _failureClass : Class;
		
		/**
		 * @private
		 */
		protected var _succeeded : ISignalOwner;
		
		/**
		 * @private
		 */
		protected var _failed : ISignalOwner;
		
		/**
		 * @private
		 */
		protected var calling : Boolean;
		
		//--------------------------------------
		//  GETTER/SETTERS
		//--------------------------------------
		
		/**
		 * @inheritDoc
		 */
		public function get succeeded( ) : ISignal
		{
			return _succeeded || ( _succeeded = ( _successClass ? new Signal( _successClass ) : new Signal( ) ) );
		}
		
		/**
		 * @inheritDoc
		 */
		public function get failed( ) : ISignal
		{
			return _failed || ( _failed = ( _failureClass ? new Signal( _failureClass ) : new Signal( ) ) );
		}
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		
		/**
		 * @inheritDoc
		 */
		public function call( ) : void
		{
			if( !calling )
			{
				calling = true;
				
				begin( );
			}
		}
		
		//--------------------------------------
		//  PRIVATE & PROTECTED INSTANCE METHODS
		//--------------------------------------
		
		/**
		 * begins the operation
		 * @private
		 */
		protected function begin( ) : void
		{
			throw new Error( 'OperationBase#begin must be overridden in subclass' );
		}
		
		/**
		 * removes all listeners from this operation's signals
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
			
			calling = false;
		}
	
	}

}
