//AS3///////////////////////////////////////////////////////////////////////////
// 
// Copyright 2011 AKQA
// 
////////////////////////////////////////////////////////////////////////////////

package com.jeremyruppel.operations.chain
{
	import com.jeremyruppel.operations.chain.OperationChain;
	import com.jeremyruppel.operations.support.FailureOperationFactory;
	import com.jeremyruppel.operations.support.StringOperationFactory;
	import com.jeremyruppel.operations.support.UpcaseOperationFactory;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.osflash.signals.utils.SignalAsyncEvent;
	import org.osflash.signals.utils.handleSignal;
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
	public class OperationChainFixture
	{
		//--------------------------------------
		//  PRIVATE VARIABLES
		//--------------------------------------
		
		private var chain : OperationChain;
		
		//--------------------------------------
		//  SETUP
		//--------------------------------------
		
		[Before]
		public function setup( ) : void
		{
			chain = new OperationChain( );
		}
		
		//--------------------------------------
		//  TEST CASES
		//--------------------------------------
	
		[Test(async,description='chain succeeds with last operation value in chain')]
		public function test_chain_succeeds_with_last_operation_value_in_chain( ) : void
		{
			handleSignal( this, chain.succeeded, function( event : SignalAsyncEvent, data : Object ) : void
			{
				assertThat( event.args[ 0 ], equalTo( 'hello tests!' ) );
			} );
			
			chain.add( new StringOperationFactory( 'hello tests!' ) ).call( );
		}
		
		[Test(async,description='chain passes result from one operation to the next')]
		public function test_chain_passes_result_from_one_operation_to_the_next( ) : void
		{
			handleSignal( this, chain.succeeded, function( event : SignalAsyncEvent, data : Object ) : void
			{
				assertThat( event.args[ 0 ], equalTo( 'HELLO TESTS!' ) );
			} );
			
			chain.add( new StringOperationFactory( 'hello tests!' ) )
				 .add( new UpcaseOperationFactory( ) )
				 .call( );
		}
		
		[Test(async,description='chain fails if any link fails')]
		public function test_chain_fails_if_any_link_fails( ) : void
		{
			handleSignal( this, chain.failed, function( event : SignalAsyncEvent, data : Object ) : void
			{
				assertThat( event.args[ 0 ], equalTo( 'failure message!' ) );
			} );
			
			registerFailureSignal( this, chain.succeeded );
			
			chain.add( new StringOperationFactory( 'hello tests!' ) )
				 .add( new FailureOperationFactory( 'failure message!' ) )
				 .call( );
		}
		
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
	
		/**
		 * @constructor
		 */
		public function OperationChainFixture( )
		{
		}
	
	}

}
