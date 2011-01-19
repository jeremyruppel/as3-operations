#!/usr/bin/env ruby -wKU

require 'rubygems'
require 'nokogiri'

module Operations
  VERSION = '0.1.1'
end

desc "Updates all source and test file headers"
task :headers do
  header = <<EOS
//AS3///////////////////////////////////////////////////////////////////////////
// 
// Copyright (c) 2011 the original author or authors
//
// Permission is hereby granted to use, modify, and distribute this file
// in accordance with the terms of the license agreement accompanying it.
// 
////////////////////////////////////////////////////////////////////////////////

EOS
  Dir[ '{src,test}/**/*.as' ].each do |uri|
    src = IO.read( uri )
    File.open( uri, 'w+' ) do |f|
      f << src.sub( /.+?(?=package)/m, header )
    end
  end
end

desc "Builds documentation"
task :docs do
  `asdoc \
   -output build/docs \
   -source-path src \
   -library-path libs/bin \
   -doc-sources src \
   -compiler.debug=true \
   -warnings=true \
   -main-title 'Operations API Documentation' \
   -window-title 'Operations API Documentation'`
end

desc "Generates source manifest XML"
task :manifest do
  Dir.chdir( 'src' ){
    File.open( 'operations-manifest.xml', 'w+' ) do |f|
      doc = Nokogiri::XML::Builder.new do |xml|
        xml.componentPackage {
          Dir.glob( '**/*.as' ).each do |uri|
            xml.component( :class => uri.gsub( '/', '.' ).sub( /\.as$/, '' ) )
          end
        }
      end
      f << doc.to_xml
    end
  }
end

desc "Builds SWC"
task :swc => :manifest do
  `compc \
   -source-path src \
   -library-path libs/bin \
   -include-sources src \
   -namespace http://jeremyruppel/mxml src/operations-manifest.xml \
   -output build/bin/operations-#{Operations::VERSION}.swc`
end

desc "Compiles and runs the test suite"
task :test do
  `mxmlc \
  -source-path+=test,src,libs/src \
  -library-path+=libs/bin \
  -output deploy/OperationsTestRunner.swf \
  -static-link-runtime-shared-libraries=true \
  test/OperationsTestRunner.mxml`
  File.delete 'deploy/OperationsTestRunner.swf.cache' if File.exist? 'deploy/OperationsTestRunner.swf.cache'
  `open deploy/index.html`
end

desc "Builds SWC, docs, manifest, and tests"
task :release => [ :headers, :docs, :swc, :test ]