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
	public class Operation implements IOperation
	{
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
	
		/**
		 * @constructor
		 */
		public function Operation( successClass : Class, failureClass : Class, block : Function )
		{
			_successClass = successClass;
			_failureClass = failureClass;
			_block = block;
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
		protected var _block : Function;

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
		protected var _calling : Boolean;
		
		//--------------------------------------
		//  GETTER / SETTERS
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
		
		/**
		 * @inheritDoc
		 */
		public function call( ) : void
		{
			if( !_calling )
			{
				_block.call( null, this );
				
				_calling = true;
			}
		}
		
		//--------------------------------------
		//  PROTECTED METHODS
		//--------------------------------------
		
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
			
			_calling = false;
		}
	}

}
