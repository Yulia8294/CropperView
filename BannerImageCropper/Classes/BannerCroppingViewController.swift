//
//  AnotherViewController.swift
//  BannerImageCropper
//
//  Created by Yulia Novikova on 2/10/22.
//

import UIKit

public class BannerCroppingViewController: UIViewController {
    
    static public func initialize(with configuration: BannerCropperCofiguration,
                                  _ completion: @escaping BannerCropperCompletion,
                                  _ onDismiss: @escaping BannerCropperDismissCompletion) -> BannerCroppingViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "BannerCroppingViewController") as! BannerCroppingViewController
        vc.configure(with: configuration, completion, onDismiss)
        return vc
    }

    @IBOutlet weak var cropButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var croppingView: BannerCroppingView!
    
    private var completion: BannerCropperCompletion?
    private var dismissCompletion: BannerCropperDismissCompletion?
    private var config: BannerCropperCofiguration!
        
    override public func viewDidLoad() {
        super.viewDidLoad()
        
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
    func configure(with config: BannerCropperCofiguration,
                   _ completion: @escaping BannerCropperCompletion,
                   _ onDismiss: @escaping BannerCropperDismissCompletion) -> Self {
        self.config = config
        self.completion = completion
        self.dismissCompletion = onDismiss
        return self
    }

    @IBAction func didPressClose(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        dismissCompletion?()
    }
    
    @IBAction func didPressCrop(_ sender: UIButton) {
        if let image = croppingView.croppedImage() {
            dismiss(animated: true, completion: nil)
            completion?(image)
        }
    }
}





