platform :ios, '9.0'

target 'SpriteKitElementsExample' do
  use_frameworks!

  pod 'SpriteKitElements'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end