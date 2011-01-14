//AS3///////////////////////////////////////////////////////////////////////////
// 
// Copyright (c) 2011 the original author or authors
//
// Permission is hereby granted to use, modify, and distribute this file
// in accordance with the terms of the license agreement accompanying it.
// 
////////////////////////////////////////////////////////////////////////////////

package com.jeremyruppel.operations
{
	import com.jeremyruppel.operations.base.OperationBaseFixture;
	import com.jeremyruppel.operations.base.OperationFixture;
	import com.jeremyruppel.operations.chain.OperationChainFixture;
	import com.jeremyruppel.operations.group.OperationGroupFixture;
	import com.jeremyruppel.operations.group.OperationQueueFixture;

	/**
	 * Class.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @author Jeremy Ruppel
	 * @since  2011-01-13
	 */
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class OperationsTestSuite
	{
		//--------------------------------------
		//  TEST FIXTURES
		//--------------------------------------
		
		// base                          : base implementations
		public var operationFixture      : OperationFixture;
		public var operationBaseFixture  : OperationBaseFixture;
		
		// chain                         : operation chaining
		public var operationChainFixture : OperationChainFixture;
		
		// group                         : groups of operations
		public var operationGroupFixture : OperationGroupFixture;
		public var operationQueueFixture : OperationQueueFixture;
		
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
	
		/**
		 * @constructor
		 */
		public function OperationsTestSuite( )
		{
		}
	
	}

}
