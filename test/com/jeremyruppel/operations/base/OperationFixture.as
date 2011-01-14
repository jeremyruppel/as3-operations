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
	import com.jeremyruppel.operations.base.Operation;
	import com.jeremyruppel.operations.core.IOperation;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.osflash.signals.utils.SignalAsyncEvent;
	import org.osflash.signals.utils.handleSignal;
	import org.osflash.signals.utils.proceedOnSignal;
	import org.osflash.signals.utils.registerFailureSignal;

	/**
	 * Class.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @author Jeremy Ruppel
	 * @since  13.01.2011
	 */
	public class OperationFixture
	{
		//--------------------------------------
		//  TEST CASES
		//--------------------------------------
	
		[Test(async,description='succeed dispatches succeeded signal')]
		public function test_succeed_dispatches_succeeded_signal( ) : void
		{
			var operation : IOperation = new Operation( null, null, function( operation : Operation ) : void
			{
				operation.succeed( );
			} );
			
			proceedOnSignal( this, operation.succeeded );
			
			registerFailureSignal( this, operation.failed );
			
			operation.call( );
		}
		
		[Test(async,description='succeed dispatches succeeded signal with payload')]
		public function test_succeed_dispatches_succeeded_signal_with_payload( ) : void
		{
			var operation : IOperation = new Operation( String, null, function( operation : Operation ) : void
			{
				operation.succeed( 'hello tests!' );
			} );
			
			handleSignal( this, operation.succeeded, function( event : SignalAsyncEvent, data : Object ) : void
			{
				assertThat( event.args[ 0 ], equalTo( 'hello tests!' ) );
			} );
			
			registerFailureSignal( this, operation.failed );
			
			operation.call( );
		}
		
		[Test(async,description='fail dispatches failed signal')]
		public function test_fail_dispatches_failed_signal( ) : void
		{
			var operation : IOperation = new Operation( null, null, function( operation : Operation ) : void
			{
				operation.fail( );
			} );
			
			proceedOnSignal( this, operation.failed );
			
			registerFailureSignal( this, operation.succeeded );
			
			operation.call( );
		}
		
		[Test(async,description='fail dispatches failed signal with payload')]
		public function test_fail_dispatches_failed_signal_with_payload( ) : void
		{
			var operation : IOperation = new Operation( null, String, function( operation : Operation ) : void
			{
				operation.fail( 'hello failure!' );
			} );
			
			handleSignal( this, operation.failed, function( event : SignalAsyncEvent, data : Object ) : void
			{
				assertThat( event.args[ 0 ], equalTo( 'hello failure!' ) );
			} );
			
			registerFailureSignal( this, operation.succeeded );
			
			operation.call( );
		}
		
		[Test(async,description='operation cannot be called while it is currently performing its task')]
		public function test_operation_cannot_be_called_while_it_is_currently_performing_its_task( ) : void
		{
			var called : int = 0;
			
			var operation : IOperation = new Operation( null, null, function( operation : Operation ) : void
			{
				called++;
				
				var timer : Timer = new Timer( 0.1, 1 );
				
				timer.addEventListener( TimerEvent.TIMER, function( event : TimerEvent ) : void
				{
					operation.succeed( );
				} );
				
				timer.start( );
			} );
			
			handleSignal( this, operation.succeeded, function( event : SignalAsyncEvent, data : Object ) : void
			{
				assertThat( called, equalTo( 1 ) );
			} );
			
			operation.call( );
			operation.call( );
			operation.call( );
		}
		
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
	
		/**
		 * @constructor
		 */
		public function OperationFixture( )
		{
		}
	
	}

}
