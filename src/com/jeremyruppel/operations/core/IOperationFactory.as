//AS3///////////////////////////////////////////////////////////////////////////
// 
// Copyright 2011 AKQA
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
	
		function create( payload : * = null ) : IOperation;
	
	}

}