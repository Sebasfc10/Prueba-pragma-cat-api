import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  private var methodChannel: FlutterMethodChannel?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // Registrar el PlatformViewFactory
    let registrar = self.registrar(forPlugin: "native-image-view")
    registrar?.register(NativeImageViewFactory(), withId: "native-image-view")

    // Configurar el MethodChannel
    let flutterViewController = self.window?.rootViewController as! FlutterViewController
    methodChannel = FlutterMethodChannel(name: "native-image-view", binaryMessenger: flutterViewController.binaryMessenger)
    methodChannel?.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
      if call.method == "test" {
        result("Hello from iOS")
      } else {
        result(FlutterMethodNotImplemented)
      }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
