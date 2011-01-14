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
	import org.osflash.signals.ISignal;

	/**
	 * Interface describing the contract for...
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @author Jeremy Ruppel
	 * @since  13.01.2011
	 */
	public interface IOperation
	{
	
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------

		/**
		 * calls this operation's block
		 */
		function call( ) : void;
		
		//--------------------------------------
		//  GETTER/SETTERS
		//--------------------------------------
		
		/**
		 * dispatched when this operation succeeds
		 */
		function get succeeded( ) : ISignal;
		
		/**
		 * dispatched when this operation fails
		 */
		function get failed( ) : ISignal;
	}

}