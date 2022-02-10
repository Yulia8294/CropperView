//
//  ViewController.swift
//  BannerImageCropper
//
//  Created by Yulia Novikova on 2/9/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bannerView: BannerCroppingView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageTopConstraint: NSLayoutConstraint!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        
        
    }
    
    private func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / imageView.bounds.width
        let heightScale = size.height / imageView.bounds.height
        let minScale = min(widthScale, heightScale)
            
        scrollView.minimumZoomScale = minScale
        scrollView.zoomScale = minScale
        scrollView.alwaysBounceVertical = true
        scrollView.alwaysBounceHorizontal = true
        scrollView.contentInsetAdjustmentBehavior = .never
        

//        print()
//        print("IMAGE FRAME: \(frame(for: imageView.image!, inImageViewAspectFit: imageView))")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateMinZoomScaleForSize(view.bounds.size)
    }
    
}

extension ViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateImageConstraintsForSize(view.bounds.size)
        scrollView.contentInset = .zero
    }
    
    private func updateImageConstraintsForSize(_ size: CGSize) {
        
        let yOffset = max(0, (size.height - imageView.frame.height) / 2)
        imageTopConstraint.constant = yOffset
        imageBottomConstraint.constant = yOffset
        
        let xOffset = max(0, (size.width - imageView.frame.width) / 2)
        imageLeadingConstraint.constant = xOffset
        imageTrailingConstraint.constant = xOffset
        
        view.layoutIfNeeded()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let imageHeight = frame(for: imageView.image!, inImageViewAspectFit: imageView).height
        let currentOffset = ceil(abs(scrollView.contentOffset.y))
        let maxOffset = scrollView.contentSize.height < scrollView.frame.height ? imageHeight/2 - 60 : scrollView.contentSize.height - view.frame.height / 2 - 60
        let allowedOffset = min(CGFloat(maxOffset), currentOffset)
        
        if scrollView.contentOffset.y < 0 {
            if scrollView.contentInset.top != allowedOffset {
                scrollView.contentInset = UIEdgeInsets(top: allowedOffset, left: 0, bottom: 0, right: 0)
            }
        } else {
            if scrollView.contentInset.top != -allowedOffset {
                scrollView.contentInset = UIEdgeInsets(top: -allowedOffset, left: 0, bottom: 0, right: 0)
                print(scrollView.contentInset)
            }
        }
    }
}

class BannerCroppingView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    
    static func scaleRect(rect: CGRect, scale: CGFloat) -> CGRect {
        return CGRect(
            x: rect.origin.x * scale,
            y: rect.origin.y * scale,
            width: rect.size.width * scale,
            height: rect.size.height * scale)
    }
    
    private func configure() {
        layer.borderColor = UIColor.orange.cgColor
        layer.borderWidth = 1
        backgroundColor = .black.withAlphaComponent(0.4)
    }
}

