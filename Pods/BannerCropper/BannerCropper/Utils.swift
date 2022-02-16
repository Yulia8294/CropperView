//
//  Utils.swift
//  BannerImageCropper
//
//  Created by Yulia Novikova on 2/10/22.
//

import UIKit

extension UIImageView {
    
    func realImageRect() -> CGRect {
        let imageViewSize = frame.size
        let imgSize = image?.size
        
        guard let imageSize = imgSize else {
            return .zero
        }
        
        let scaleWidth = imageViewSize.width / imageSize.width
        let scaleHeight = imageViewSize.height / imageSize.height
        let aspect = fmin(scaleWidth, scaleHeight)
        
        var imageRect = CGRect(x: 0, y: 0, width: imageSize.width * aspect, height: imageSize.height * aspect)
        
        imageRect.origin.x = (imageViewSize.width - imageRect.size.width) / 2
        imageRect.origin.y = (imageViewSize.height - imageRect.size.height) / 2
        
        imageRect.origin.x += frame.origin.x
        imageRect.origin.y += frame.origin.y
        
        return imageRect
    }
}
