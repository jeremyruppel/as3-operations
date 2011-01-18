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
	 * @since  18.01.2011
	 */
	public interface IOperationOwner
	{
	
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		
		/**
		 * tells this operation to succeed, optionally with a payload
		 * @param payload *
		 */
		function succeed( payload : * = null ) : void;
		
		/**
		 * tells this operation to fail, optionally with a payload
		 * @param payload *
		 */
		function fail( payload : * = null ) : void;
	
	}

}