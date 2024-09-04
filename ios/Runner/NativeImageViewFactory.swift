import UIKit
import Flutter

class NativeImageViewFactory: NSObject, FlutterPlatformViewFactory {
    func create(withFrame frame: CGRect, viewIdentifier identifier: Int64, arguments: Any?) -> FlutterPlatformView {
        return NativeImageView(frame: frame, viewId: identifier, args: arguments)
    }
}
