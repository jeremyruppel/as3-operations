AS3 Operations
==============

**as3-operations** is a set of async operation contracts and helpers for ActionScript 3.
The package utilizes Robert Penner's excellent [as3-signals][as3-signals] library for its
callback mechanism. Signals are a convenient choice because they are fast and can be easily
and neatly cleaned up after an operation has finished.

Usage Overview
--------------

For many asynchronous operations, we typically only need to know whether the operation has
succeeded or failed, and with what result. The `IOperation` contract describes this behavior,
providing only a `succeeded` signal, a `failed` signal, and a `call` method that should be used
to initiate the operation.

A simple asynchronous load operation could look like this:

	class LoadImageOperation extends Operation
	{
		public function LoadImageOperation( url : String )
		{
			super( DisplayObject, String, function( operation : Operation ) : void
			{
				var loader : Loader = new Loader( );
				
				var request : URLRequest = new URLRequest( url );
				
				loader.contentLoaderInfo.addEventListener( Event.COMPLETE, function( event : Event ) : void
				{
					operation.succeed( event.target.content );
				} );
				
				loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, function( event : Event ) : void
				{
					operation.fail( 'Image at url "' + url '" could not be found' );
				} );
				
				loader.contentLoaderInfo.addEventListener( SecurityErrorEvent.SECURITY_ERROR, function( event : Event ) : void
				{
					operation.fail( 'Image could not be loaded because the policy file was missing or something' );
				} );
				
				loader.load( request );
			} );
		}
	}

This operation translates the loader's several different events into either success or failure. The operation
can then be used like this:

	var operation : IOperation = new LoadImageOperation( 'my-image.jpg' );
	
	operation.succeeded.add( function( image : DisplayObject ) : void
	{
		trace( image );
	} );
	
	operation.failed.add( function( message : String ) : void
	{
		trace( 'Failure!: ' + message );
	} );
	
	operation.call( );

Operation Groups
----------------

The **as3-operations** package comes with two simple implementation of operation groups: `OperationGroup` and
`OperationQueue`. The biggest difference between the two is that an `OperationGroup` executes all of its sub-operations
at the same time while an `OperationQueue` executes them single-file. Each group will, by default, succeed only if 
all of its sub-operations succeed, though this can be configured through the group's constructor. Both groups also
allow chaining through their `add` method so multiple operations can be added in-line if you wish.

**Note:** Since operation groups can have any number of sub-operations (including other operation groups), the succeeded
and failed handlers for groups do not receive a payload. To handle the success or failure of each sub-operation, attach
handlers to the sub-operation directly.

	var group : IOperationGroup = new OperationGroup( );
	
	var config : IOperation = new LoadConfigOperation( );
	
	var assets : IOperation = new LoadAssetsOperation( );
	
	config.succeeded.add( function( xml : XML ) : void
	{
		// do something with the config xml...
	} );
	
	group.succeeded.add( function( ) : void
	{
		trace( 'all assets have finished loading' );
	} );
	
	group.add( config ).add( assets ).call( );

Operation Chains
----------------

**as3-operations** comes with a simple `OperationChain` implementation, which behaves a lot like an `OperationQueue`,
except that the payload from each operation that finishes is passed to the next operation in the queue, with the final
payload yielded to the success handler of the chain. To do this cleanly, operations are generated from `IOperationFactory`
implementations. See the tests and support classes for examples of how you could implement this yourself.

[as3-signals]: https://github.com/robertpenner/as3-signals "as3-signals"