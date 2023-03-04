Pod::Spec.new do |s|
  s.name             = 'MondoKit'
  s.version          = '1.0.0'
  s.summary          = 'A short description of MondoKit.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC
  s.homepage         = 'https://github.com/cocomanbar/MondoKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'cocomanbar' => '125322078@qq.com' }
  s.source           = { :git => 'https://github.com/cocomanbar/MondoKit.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '10.0'
  
  s.subspec 'Core' do |a|
      a.source_files = 'MondoKit/Classes/Core/*'
  end
  
  s.subspec 'Util' do |a|
      a.source_files = 'MondoKit/Classes/Util/*'
  end
  
  s.subspec 'NSString' do |a|
      a.source_files = 'MondoKit/Classes/NSString/*'
  end
  
  s.subspec 'NSAttributedString' do |a|
      a.source_files = 'MondoKit/Classes/NSAttributedString/*'
  end
  
  s.subspec 'NSJSONSerialization' do |a|
      a.source_files = 'MondoKit/Classes/NSJSONSerialization/*'
  end
  
  s.subspec 'NSSet' do |a|
      a.source_files = 'MondoKit/Classes/NSSet/*'
  end
  
  s.subspec 'NSOrderedSet' do |a|
      a.source_files = 'MondoKit/Classes/NSOrderedSet/*'
  end
  
  s.subspec 'NSArray' do |a|
      a.source_files = 'MondoKit/Classes/NSArray/*'
  end
  
  s.subspec 'NSDictionary' do |a|
      a.source_files = 'MondoKit/Classes/NSDictionary/*'
  end
  
  s.subspec 'NSCache' do |a|
      a.source_files = 'MondoKit/Classes/NSCache/*'
  end
  
  s.subspec 'NSData' do |a|
      a.source_files = 'MondoKit/Classes/NSData/*'
  end
  
  s.subspec 'UIView' do |a|
      a.source_files = 'MondoKit/Classes/UIView/*'
  end
  
  s.subspec 'NSObject' do |a|
      a.source_files = 'MondoKit/Classes/NSObject/*'
  end
  
  s.subspec 'KeyValueObserving' do |a|
      a.source_files = 'MondoKit/Classes/KeyValueObserving/*'
  end
  
  s.subspec 'NSTimer' do |a|
      a.source_files = 'MondoKit/Classes/NSTimer/*'
  end
  
  
end
