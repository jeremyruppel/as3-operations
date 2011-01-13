//AS3///////////////////////////////////////////////////////////////////////////
// 
// Copyright 2011 AKQA
// 
////////////////////////////////////////////////////////////////////////////////

package com.jeremyruppel.operations.group
{
	import com.jeremyruppel.operations.base.Operation;
	import com.jeremyruppel.operations.core.IOperation;
	import com.jeremyruppel.operations.core.IOperationGroup;
	import com.jeremyruppel.operations.group.OperationQueue;
	import com.jeremyruppel.operations.support.FailWithNullOperation;
	import com.jeremyruppel.operations.support.SucceedWithNullOperation;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.isTrue;
	import org.hamcrest.object.sameInstance;
	import org.osflash.signals.utils.SignalAsyncEvent;
	import org.osflash.signals.utils.handleSignal;
	import org.osflash.signals.utils.proceedOnSignal;
	import org.osflash.signals.utils.registerFailureSignal;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.collection.array;

	/**
	 * Class.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @author Jeremy Ruppel
	 * @since  13.01.2011
	 */
	public class OperationQueueFixture
	{
	
		//--------------------------------------
		//  TEST CASES
		//--------------------------------------
		
		[Test(description='group yields itself from add for chaining')]
		public function test_group_yields_itself_from_add_for_chaining( ) : void
		{
			var group : IOperationGroup = new OperationQueue( );
			
			var operation : IOperation = new Operation( null, null, null );
			
			assertThat( group.add( operation ), sameInstance( group ) );
		}
		
		[Test(async,description='group of one finishes when only operation has completed')]
		public function test_group_of_one_finishes_when_only_operation_has_completed( ) : void
		{
			var group : IOperationGroup = new OperationQueue( );
			
			var one : IOperation = new SucceedWithNullOperation( );
			
			var oneSucceeded : Boolean = false;
			
			handleSignal( this, one.succeeded, function( event : SignalAsyncEvent, data : Object ) : void
			{
				oneSucceeded = true;
			} );
			
			handleSignal( this, group.succeeded, function( event : SignalAsyncEvent, data : Object ) : void
			{
				assertThat( oneSucceeded, isTrue( ) );
			} );
			
			group.add( one ).call( );
		}
		
		[Test(async,description='group of two finishes when both operations have completed')]
		public function test_group_of_two_finishes_when_both_operations_have_completed( ) : void
		{
			var group : IOperationGroup = new OperationQueue( );
			
			var one : IOperation = new SucceedWithNullOperation( );
			
			var oneSucceeded : Boolean = false;
			
			handleSignal( this, one.succeeded, function( event : SignalAsyncEvent, data : Object ) : void
			{
				oneSucceeded = true;
			} );
			
			var two : IOperation = new SucceedWithNullOperation( );
			
			var twoSucceeded : Boolean = false;
			
			handleSignal( this, two.succeeded, function( event : SignalAsyncEvent, data : Object ) : void
			{
				twoSucceeded = true;
			} );
			
			handleSignal( this, group.succeeded, function( event : SignalAsyncEvent, data : Object ) : void
			{
				assertThat( oneSucceeded, isTrue( ) );
				assertThat( twoSucceeded, isTrue( ) );
			} );
			
			group.add( one ).add( two ).call( );
		}
		
		[Test(async,description='by default operation group fails on failed operations')]
		public function test_by_default_operation_group_fails_on_failed_operations( ) : void
		{
			var group : IOperationGroup = new OperationQueue( );
			
			var one : IOperation = new SucceedWithNullOperation( );

			var two : IOperation = new FailWithNullOperation( );
			
			proceedOnSignal( this, group.failed );
			
			registerFailureSignal( this, group.succeeded );
			
			group.add( one ).add( two ).call( );
		}
		
		[Test(async,description='operation group can skip failures by passing true to constructor')]
		public function test_operation_group_can_skip_failures_by_passing_true_to_constructor( ) : void
		{
			var group : IOperationGroup = new OperationQueue( true );
			
			var one : IOperation = new SucceedWithNullOperation( );

			var two : IOperation = new FailWithNullOperation( );
			
			proceedOnSignal( this, group.succeeded );
			
			registerFailureSignal( this, group.failed );
			
			group.add( one ).add( two ).call( );
		}
		
		[Test(async,description='operation group cannot be called while sub operations are currently performing their tasks')]
		public function test_operation_group_cannot_be_called_while_sub_operations_are_currently_performing_their_tasks( ) : void
		{
			var called : int = 0;
			
			var tracer : IOperation = new Operation( null, null, function( operation : Operation ) : void
			{
				called++;
				
				operation.succeed( );
			} );
			
			var operation : IOperation = new Operation( null, null, function( operation : Operation ) : void
			{
				var timer : Timer = new Timer( 0.1, 1 );
				
				timer.addEventListener( TimerEvent.TIMER, function( event : TimerEvent ) : void
				{
					operation.succeed( );
				} );
				
				timer.start( );
			} );
			
			var group : IOperationGroup = new OperationQueue( );
			
			handleSignal( this, group.succeeded, function( event : SignalAsyncEvent, data : Object ) : void
			{
				assertThat( called, equalTo( 1 ) );
			} );
			
			group.add( tracer ).add( operation );
			
			group.call( );
			group.call( );
			group.call( );
		}
		
		[Test(async,description='queue calls operations in order')]
		public function test_queue_calls_operations_in_order( ) : void
		{
			var places : Array = [ ];
			
			var async : IOperation = new Operation( null, null, function( operation : Operation ) : void
			{
				var timer : Timer = new Timer( 0.1, 1 );
				
				timer.addEventListener( TimerEvent.TIMER, function( event : TimerEvent ) : void
				{
					operation.succeed( );
				} );
				
				timer.start( );
			} );
			
			async.succeeded.add( function( ) : void
			{
				places.push( 'async' );
			} );
			
			var immediate : IOperation = new SucceedWithNullOperation( );
			
			immediate.succeeded.add( function( ) : void
			{
				places.push( 'immediate' );
			} );
			
			var group : IOperationGroup = new OperationQueue( );
			
			handleSignal( this, group.succeeded, function( event : SignalAsyncEvent, data : Object ) : void
			{
				assertThat( places, array( 'async', 'immediate' ) );
			} );
			
			group.add( async ).add( immediate ).call( );
		}
		
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
	
		/**
		 * @constructor
		 */
		public function OperationQueueFixture( )
		{
		}
	
	}

}