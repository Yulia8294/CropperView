//
//  File.swift
//  BannerImageCropper
//
//  Created by Yulia Novikova on 2/10/22.
//

import UIKit

class ImagePresenter: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
    }
    
}
