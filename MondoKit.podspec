Pod::Spec.new do |s|
  s.name             = 'Dr.mondo'
  s.version          = '1.0.0'
  s.summary          = 'A library that can protect against crashes online.'
  s.description      = 'Dr. Mundo that is a framework can protect against crashes online.'
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
      a.dependency 'Dr.mondo/Core'
      a.dependency 'Dr.mondo/Util'
  end
  
  s.subspec 'NSAttributedString' do |a|
      a.source_files = 'MondoKit/Classes/NSAttributedString/*'
      a.dependency 'Dr.mondo/Core'
      a.dependency 'Dr.mondo/Util'
  end
  
  s.subspec 'NSJSONSerialization' do |a|
      a.source_files = 'MondoKit/Classes/NSJSONSerialization/*'
      a.dependency 'Dr.mondo/Core'
      a.dependency 'Dr.mondo/Util'
  end
  
  s.subspec 'NSSet' do |a|
      a.source_files = 'MondoKit/Classes/NSSet/*'
      a.dependency 'Dr.mondo/Core'
      a.dependency 'Dr.mondo/Util'
  end
  
  s.subspec 'NSOrderedSet' do |a|
      a.source_files = 'MondoKit/Classes/NSOrderedSet/*'
      a.dependency 'Dr.mondo/Core'
      a.dependency 'Dr.mondo/Util'
  end
  
  s.subspec 'NSArray' do |a|
      a.source_files = 'MondoKit/Classes/NSArray/*'
      a.dependency 'Dr.mondo/Core'
      a.dependency 'Dr.mondo/Util'
  end
  
  s.subspec 'NSDictionary' do |a|
      a.source_files = 'MondoKit/Classes/NSDictionary/*'
      a.dependency 'Dr.mondo/Core'
      a.dependency 'Dr.mondo/Util'
  end
  
  s.subspec 'NSCache' do |a|
      a.source_files = 'MondoKit/Classes/NSCache/*'
      a.dependency 'Dr.mondo/Core'
      a.dependency 'Dr.mondo/Util'
  end
  
  s.subspec 'NSData' do |a|
      a.source_files = 'MondoKit/Classes/NSData/*'
      a.dependency 'Dr.mondo/Core'
      a.dependency 'Dr.mondo/Util'
  end
  
  s.subspec 'UIView' do |a|
      a.source_files = 'MondoKit/Classes/UIView/*'
      a.dependency 'Dr.mondo/Core'
      a.dependency 'Dr.mondo/Util'
  end
  
  s.subspec 'NSObject' do |a|
      a.source_files = 'MondoKit/Classes/NSObject/*'
      a.dependency 'Dr.mondo/Core'
      a.dependency 'Dr.mondo/Util'
  end
  
  s.subspec 'KeyValueObserving' do |a|
      a.source_files = 'MondoKit/Classes/KeyValueObserving/*'
      a.dependency 'Dr.mondo/Core'
      a.dependency 'Dr.mondo/Util'
  end
  
  s.subspec 'NSTimer' do |a|
      a.source_files = 'MondoKit/Classes/NSTimer/*'
      a.dependency 'Dr.mondo/Core'
      a.dependency 'Dr.mondo/Util'
  end
  
  
end
