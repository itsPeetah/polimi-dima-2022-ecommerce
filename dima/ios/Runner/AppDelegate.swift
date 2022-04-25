import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
      _ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? 
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    /* Added plugin */
    GMSServices.provideAPIKey("AIzaSyDxYVZ5BP2UrMUZv1szpf34BkHImArhvCA")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
