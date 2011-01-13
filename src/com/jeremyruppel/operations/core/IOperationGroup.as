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
	public interface IOperationGroup extends IOperation
	{
	
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		
		/**
		 * adds an operation to this group
		 * @param operation IOperation
		 * @return IOperationGroup 
		 */
		function add( operation : IOperation ) : IOperationGroup;
		
		//--------------------------------------
		//  GETTER/SETTERS
		//--------------------------------------
	
	}

}

