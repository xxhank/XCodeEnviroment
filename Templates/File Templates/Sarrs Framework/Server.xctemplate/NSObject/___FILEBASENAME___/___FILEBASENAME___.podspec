#
#  Be sure to run `pod spec lint ___FILEBASENAME___.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docspec.cocoapodspec.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name         = "___FILEBASENAME___"
  spec.version      = "0.0.1"
  spec.summary      = "A short description of ___FILEBASENAME___."
  spec.description  = <<-DESC
                   DESC

  spec.homepage     = "http://EXAMPLE/___FILEBASENAME___"
  spec.license      = "MIT (example)"
  spec.author             = { "wangchao" => "xxhank.boy@gmail.com" }

  spec.platform     = :ios, "8.0"

  spec.subspec 'Interface' do |sp|
    sp.source_files = 'Interface/**/*.{swift,h}'
  end

  spec.requires_arc  = true
  spec.source_files  = "**/*.{h,m,mm,swift}"
  non_arc_files   =  ""
  spec.exclude_files = "Classes/Exclude",non_arc_files

  spec.subspec 'no-arc' do |sp|
    sp.requires_arc = false
    sp.source_files = non_arc_files
  end

  spec.header_mappings_dir = '.'
  # spec.preserve_paths = 'Frameworks/*.framework'
  # spec.module_map = 'source/module.modulemap'

  # spec.public_header_files = "Classes/**/*.h"
  # spec.header_dir = 'Three20Core'

  # Resources
  # spec.resources = ['Images/*.png', 'Sounds/*']
  spec.resource_bundles = {
    '___FILEBASENAME___' => ['Resource/**/*.json','**/UI/*.xcassets', '**/*.xib', '**/*.storyboard'],
  }

  # Build settings
  # spec.frameworks = "SomeFramework", "AnotherFramework"
  # spec.libraries = "iconv", "xml2"
  # spec.vendored_frameworks = 'MyFramework.framework', 'TheirFramework.framework'
  # spec.vendored_libraries = 'libProj4.a', 'libJavaScriptCore.a'

  # spec.compiler_flags =
  # spec.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-lObjC' }
  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }


  # Dependency
  # spec.dependency "JSONKit"#, "~> 1.4"
  # spec.dependency "OtherModule/Interface"#, "~> 1.4"
  # spec.dependency ""
  # spec.dependency ""
  # spec.dependency ""
  # spec.dependency ""
  # spec.dependency ""
  # spec.dependency ""
  # spec.dependency ""
end
