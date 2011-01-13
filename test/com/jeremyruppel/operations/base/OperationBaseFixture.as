//AS3///////////////////////////////////////////////////////////////////////////
// 
// Copyright 2011 AKQA
// 
////////////////////////////////////////////////////////////////////////////////

package com.jeremyruppel.operations.base
{
	import com.jeremyruppel.operations.base.OperationBase;
	import com.jeremyruppel.operations.core.IOperation;
	import org.hamcrest.assertThat;
	import org.hamcrest.collection.emptyArray;
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
	public class OperationBaseFixture
	{
		//--------------------------------------
		//  TEST CASES
		//--------------------------------------
	
		[Test(description='succeeded signal has no value classes if success class is null')]
		public function test_succeeded_signal_has_no_value_classes_if_success_class_is_null( ) : void
		{
			var operation : IOperation = new OperationBase( null, null );
			
			assertThat( operation.succeeded.valueClasses, emptyArray( ) );
		}
		
		[Test(description='succeeded signal has correct value class if success class is provided')]
		public function test_succeeded_signal_has_correct_value_class_if_success_class_is_provided( ) : void
		{
			var operation : IOperation = new OperationBase( String, null );
			
			assertThat( operation.succeeded.valueClasses, array( String ) );
		}
		
		[Test(description='failed signal has no value classes if failure class is null')]
		public function test_failed_signal_has_no_value_classes_if_failure_class_is_null( ) : void
		{
			var operation : IOperation = new OperationBase( null, null );
			
			assertThat( operation.failed.valueClasses, emptyArray( ) );
		}
		
		[Test(description='failed signal has correct value class if failure class is provided')]
		public function test_failed_signal_has_correct_value_class_if_failure_class_is_provided( ) : void
		{
			var operation : IOperation = new OperationBase( null, Number );
			
			assertThat( operation.failed.valueClasses, array( Number ) );
		}
		
		[Test(description='throws error when calling operation base',expected='Error')]
		public function test_throws_error_when_calling_operation_base( ) : void
		{
			var operation : IOperation = new OperationBase( String, Number );
			
			operation.call( );
		}
		
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
	
		/**
		 * @constructor
		 */
		public function OperationBaseFixture( )
		{
		}
	
	}

}