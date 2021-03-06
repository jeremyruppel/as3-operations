//AS3///////////////////////////////////////////////////////////////////////////
// 
// Copyright (c) 2011 the original author or authors
//
// Permission is hereby granted to use, modify, and distribute this file
// in accordance with the terms of the license agreement accompanying it.
// 
////////////////////////////////////////////////////////////////////////////////

package com.jeremyruppel.operations.core
{

	/**
	 * Interface describing the contract for...
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @author Jeremy Ruppel
	 * @since  13.01.2011
	 */
	public interface IOperationFactory
	{
	
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		
		/**
		 * Retrieves an operation instance from the factory, optionally
		 * passing a payload that the operation may depend on.
		 * @param payload *
		 * @return IOperation 
		 */
		function create( payload : * = null ) : IOperation;
	
	}

}