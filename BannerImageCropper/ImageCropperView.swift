//
//  TestView.swift
//  BannerImageCropper
//
//  Created by Yulia Novikova on 2/10/22.
//

import UIKit

class ImageCropperView: UIView {
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = false
        scrollView.alwaysBounceHorizontal = true
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "test2"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var bannerView: BannerCroppingView = {
        let banner = BannerCroppingView()
        banner.isUserInteractionEnabled = false
        return banner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func centerContent() {
        let height = BannerImageCropper.frame(for: imageView.image!, inImageViewAspectFit: imageView).height
        let centerOffsetY = (height - scrollView.frame.size.height) / 2 - 60
        scrollView.contentOffset = CGPoint(x: 0, y: centerOffsetY)
    }
    
    func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / imageView.bounds.width
        let heightScale = size.height / imageView.bounds.height
        let minScale = min(widthScale, heightScale)
            
        scrollView.minimumZoomScale = minScale
        scrollView.zoomScale = minScale
    }
    
    private func constraintLayout() {
        
        addSubview(scrollView)
        scrollView.addSubview(imageView)
        addSubview(bannerView)
        scrollView.delegate = self
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        bannerView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        scrollView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        bannerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        bannerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        bannerView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        bannerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        bannerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func configure() {
       constraintLayout()
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)

        if view == self {
            return scrollView
        }
        return view
    }

}

extension ImageCropperView: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }
}

// Cropping
extension ImageCropperView {
    
    
    func croppedImage() -> UIImage? {
        let visibleRect = calcVisibleRectForResizeableCropArea()

        guard let image = imageView.image,
              let cropped = image.cgImage?.cropping(to: visibleRect) else {
                  print("Error when cropping")
                  return nil
              }
        return UIImage(cgImage: cropped, scale: image.scale, orientation: image.imageOrientation)
    }

    private func calcVisibleRectForResizeableCropArea() -> CGRect {
        var sizeScale = self.imageView.image!.size.width / self.imageView.frame.size.width
        sizeScale *= self.scrollView.zoomScale
        var visibleRect = bannerView.convert(bannerView.bounds, to: imageView)
        visibleRect = BannerCroppingView.scaleRect(rect: visibleRect, scale: sizeScale)
        return visibleRect
    }
}

