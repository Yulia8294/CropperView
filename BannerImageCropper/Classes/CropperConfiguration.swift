//
//  CropperConfiguration.swift
//  BannerImageCropper
//
//  Created by Yulia Novikova on 2/10/22.
//

import UIKit

public typealias BannerCropperCompletion = (UIImage?) -> Void

public struct BannerCropperCofiguration {
    
    public var bannerHeight: CGFloat = 120
    public var image: UIImage
    public var displayGrid = false
    public var gridColor: UIColor?
    public var dimColor: UIColor?
    public var cropAreaBorderColor: UIColor?
    public var cropAreaBorderWidth: CGFloat?
    
    public init(image: UIImage) {
        self.image = image
    }

}
