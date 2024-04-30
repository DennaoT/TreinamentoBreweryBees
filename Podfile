# Uncomment the next line to define a global platform for your project
platform :ios, '17.4'
use_frameworks!

def setup_libs
  pod 'SwiftGen', '~> 6.0'
  pod 'ReachabilitySwift'
end

def firebase_libs
  pod 'Firebase/Core'
  pod 'Firebase/Firestore'
  pod 'Firebase/RemoteConfig'
end

def external_libs
  pod 'SnapKit', '~> 5.6.0'
end

target 'TreinamentoBreweryBees' do
  setup_libs
  firebase_libs
  external_libs
end

# Pods for TreinamentoBreweryBees

target 'TreinamentoBreweryBeesTests' do
  inherit! :search_paths
  # Pods for testing
end
