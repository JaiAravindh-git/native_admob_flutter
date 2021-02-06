import Flutter
import UIKit
import GoogleMobileAds


let controllerManager = InterstitialAdControllerManager.shared

public class SwiftNativeAdmobFlutterPlugin: NSObject, FlutterPlugin {
    
    let messenger: FlutterBinaryMessenger
    
    init(messenger: FlutterBinaryMessenger) {
            self.messenger = messenger
        }

  public static func register(with registrar: FlutterPluginRegistrar) {
    //messenger = registrar.messenger()
    let channel = FlutterMethodChannel(name: "native_admob_flutter", binaryMessenger: registrar.messenger())
    let instance = SwiftNativeAdmobFlutterPlugin(messenger: registrar.messenger())
    registrar.addMethodCallDelegate(instance, channel: channel)

    //let factory = BannerAdViewFactory(messenger: registrar.messenger())
    //registrar.register(factory, withId: "banner_admob")
  }
    
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let params = call.arguments as? [String: Any]
    switch call.method {
      case "initialize":
        // TODO: add a completionHandler and result after it completed
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        result(UIDevice.current.systemVersion)

      // Native Ad
      //case "initNativeAdController":
        // TODO: initialize the controller
      //case "disposeNativeAdController":
        // TODO: dispose the controller

      // Banner Ad
      //case "initBannerAdController":
        // TODO: initialize the controller
      //case "disposeBannerAdController":
        // TODO: dispose the controller

       //Interstitial Ad
      case "initInterstitialAd":
        controllerManager.createController(forID: params!["id"] as! String, binaryMessenger: messenger)
        result(true)
        
      case "disposeInterstitialAd":
        controllerManager.removeController(forID: params!["id"] as! String)
        result(nil)
      
      // Rewarded Ad
      //case "initRewardedAd":
        // TODO: initialize the ad
      //case "disposeRewardedAd":
        // TODO: dispose the ad

      // App Open 
      //case "initAppOpenAd":
        // TODO: initialize the ad
      //case "disposeAppOpenAd":
        // TODO: dispose the ad
      
      // General
//      case "isTestDevice":
        // TODO: isTestDevice
        // ? It seems there's no implementation for this on iOS
//        result(nil)
      
//      case "setTestDeviceIds":
//        GADMobileAds
//          .sharedInstance()
//          .requestConfiguration
//          .testDeviceIdentifiers = params["setTestDeviceIds"] as! [String]
//        result(nil)

//      case "setChildDirected":
        // https://developers.google.com/admob/ios/targeting#child-directed_setting
//        GADMobileAds
//          .sharedInstance()
//          .requestConfiguration
//          .tag(forChildDirectedTreatment: params["directed"])
//
      //case "setTagForUnderAgeOfConsent":
        // https://developers.google.com/admob/ios/targeting#users_under_the_age_of_consent
        // GADMobileAds
        //   .sharedInstance()
        //   .requestConfiguration
        //   .tagForUnderAgeOfConsent(params["under"]);
        // 
        // tagForUnderAgeOfConsent requires a String, but `params["under"]`
        // comes as an int from the dart side.
        // TODO: setTagForUnderAgeOfConsent

      //case "setMaxAdContentRating":
        // TODO: setMaxAdContentRating

      //case "setAppVolume":
        // https://developers.google.com/admob/ios/global-settings#video_ad_volume_control
//        GADMobileAds.sharedInstance().applicationVolume = params["volume"] as! Float
//        result(nil)
//
     // case "setAppMuted":
//        // https://developers.google.com/admob/ios/global-settings#video_ad_volume_control
//        GADMobileAds.sharedInstance().applicationMuted = params["muted"]
//        result(nil)

      default:
        result(FlutterMethodNotImplemented)
    }
  }
}
