import UIKit
import Flutter

class NativeImageView: NSObject, FlutterPlatformView {
    private let imageView: UIImageView

    init(frame: CGRect, viewId: Int64, args: Any?) {
        self.imageView = UIImageView(frame: frame)
        super.init()

        if let creationParams = args as? [String: Any],
           let imageUrl = creationParams["imageUrl"] as? String {
            if let url = URL(string: imageUrl) {
                imageView.load(url: url)
            } else {
                print("Invalid URL: \(imageUrl)")
            }
        }
    }

    func view() -> UIView {
        return imageView
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async {
            print("Loading image from URL: \(url)")
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                    print("Image loaded successfully")
                }
            } else {
                print("Failed to load image data")
            }
        }
    }
}
