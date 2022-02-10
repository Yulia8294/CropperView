//
//  TestView.swift
//  BannerImageCropper
//
//  Created by Yulia Novikova on 2/10/22.
//

import UIKit

class BannerCroppingView: UIView {
    
    var conifig: BannerCropperCofiguration?
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = false
        scrollView.alwaysBounceHorizontal = true
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var bannerView: CroppingAreaView = {
        let banner = CroppingAreaView()
        banner.isUserInteractionEnabled = false
        banner.translatesAutoresizingMaskIntoConstraints = false
        return banner
    }()
    
    var dimView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configure(with configuration: BannerCropperCofiguration?) {
        guard let configuration = configuration else {
            return
        }

        self.conifig = configuration
        bannerView.configure(with: CroppingAreaViewModel(gridColor:    configuration.gridColor,
                                                         displaysGrid: configuration.displayGrid,
                                                         borderColor:  configuration.cropAreaBorderColor,
                                                         borderWidth:  configuration.cropAreaBorderWidth))
        imageView.image = configuration.image
        dimView.backgroundColor = configuration.cropperViewBackgroundColor
        backgroundColor = configuration.cropperViewBackgroundColor
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    func centerContent() {
        guard let image = imageView.image else { return }
        let height = BannerImageCropper.frame(for: image, inImageViewAspectFit: imageView).height
        let centerOffsetY = (height - scrollView.frame.size.height) / 2
        scrollView.setContentOffset(CGPoint(x: 0, y: centerOffsetY), animated: false)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateMinZoomScaleForSize(bounds.size)
        centerContent()
        updateDimmingMaskFrame()
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
        addSubview(dimView)
        scrollView.delegate = self

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
        
        dimView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        dimView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        dimView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        dimView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func configure() {
       constraintLayout()
    }
    
    func updateDimmingMaskFrame() {
        let maskLayer = CAShapeLayer()
        maskLayer.frame = dimView.bounds
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        let path = UIBezierPath(rect: dimView.bounds)
        path.append(UIBezierPath(rect: bannerView.frame))
        maskLayer.path = path.cgPath
        dimView.layer.mask = maskLayer
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)

        if view == self {
            return scrollView
        }
        return view
    }

}

extension BannerCroppingView: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }
}

// Cropping
extension BannerCroppingView {
    
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
        visibleRect = CroppingAreaView.scaleRect(rect: visibleRect, scale: sizeScale)
        return visibleRect
    }
}

