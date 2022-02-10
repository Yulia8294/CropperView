//
//  AnotherViewController.swift
//  BannerImageCropper
//
//  Created by Yulia Novikova on 2/10/22.
//

import UIKit

class BannerCroppingViewController: UIViewController {

    @IBOutlet weak var cropButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var croppingView: BannerCroppingView!
    
    private var config: BannerCropperCofiguration!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var conf = BannerCropperCofiguration(image: UIImage(named: "test2")!)
        conf.displayGrid = true
        conf.gridColor = .white
        conf.cropAreaBorderColor = .white
        conf.cropButtonCornerRadius = 10
        conf.closeButtonTint = .darkGray
        conf.saveButtonBackground = .orange
        conf.cropperViewCornerRadius = 10
        conf.cropperViewBackgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        configure(with: conf)
        
        guard let config = config else {
            fatalError("Please provide configuration with image to display on cropper view")
        }
        
        croppingView.configure(with: config)
        setupUI()
    }
    
    private func setupUI() {
        cropButton.setTitle(config.saveButtonText, for: .normal)
        cropButton.tintColor = config.saveButtonTint
        closeButton.setTitleColor(config.saveButtonTint, for: .normal)
        cropButton.backgroundColor = config.saveButtonBackground
        closeButton.setTitle(config.closeButtonText, for: .normal)
        closeButton.setTitleColor(config.closeButtonTint, for: .normal)
        closeButton.tintColor = config.closeButtonTint
        closeButton.backgroundColor = config.closeButtonBackground
        cropButton.layer.cornerRadius = config.cropButtonCornerRadius
        closeButton.layer.cornerRadius = config.closeButtonCornerRadius
        closeButton.layer.masksToBounds = true
        cropButton.layer.masksToBounds = true
        croppingView.layer.cornerRadius = config.cropperViewCornerRadius
        croppingView.layer.masksToBounds = true
        croppingView.clipsToBounds = true
    }
    
    @discardableResult
    func configure(with config: BannerCropperCofiguration) -> Self {
        self.config = config
        return self
    }

    
    @IBAction func didPressClose(_ sender: UIButton) {
        
    }
    
    @IBAction func didPressCrop(_ sender: UIButton) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImagePresenter") as! ImagePresenter
        let image = croppingView.croppedImage()
        vc.image = image
        present(vc, animated: true, completion: nil)
    }
}





