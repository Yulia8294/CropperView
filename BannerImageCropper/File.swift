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
    
    @IBAction func didPressDemoButton(_ sender: UIButton) {
        
        var conf = BannerCropperCofiguration(image: UIImage(named: "test2")!)
               conf.displayGrid = true
               conf.gridColor = .white
               conf.cropAreaBorderColor = .white
               conf.cropButtonCornerRadius = 10
               conf.closeButtonTint = .darkGray
               conf.saveButtonBackground = .orange
               conf.cropperViewCornerRadius = 10
               conf.cropperViewBackgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        let controller = BannerCroppingViewController.initialize(with: conf) { image in
            self.imageView.image = image
        } _: {
            print("dismissed")
        }
        
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }
}
