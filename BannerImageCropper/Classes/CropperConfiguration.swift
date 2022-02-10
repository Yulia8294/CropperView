//
//  CropperConfiguration.swift
//  BannerImageCropper
//
//  Created by Yulia Novikova on 2/10/22.
//

import UIKit

public typealias BannerCropperCompletion = (UIImage?) -> Void
public typealias BannerCropperDismissCompletion = () -> Void

public struct BannerCropperCofiguration {
    
    public var bannerHeight: CGFloat = 120
    public var image: UIImage
    public var displayGrid = false
    public var gridColor: UIColor?
    public var dimColor: UIColor?
    public var cropAreaBorderColor: UIColor?
    public var cropAreaBorderWidth: CGFloat?
    public var closeButtonText = "Back"
    public var saveButtonText = "Save"
    public var saveButtonTint: UIColor = .white
    public var closeButtonTint: UIColor = .white
    public var saveButtonBackground: UIColor = .blue
    public var closeButtonBackground: UIColor = .white
    public var cropperViewBackgroundColor: UIColor = .black
    public var closeButtonCornerRadius: CGFloat = 0
    public var cropButtonCornerRadius: CGFloat = 0
    public var cropperViewCornerRadius: CGFloat = 0
    
    public init(image: UIImage) {
        self.image = image
    }

}
