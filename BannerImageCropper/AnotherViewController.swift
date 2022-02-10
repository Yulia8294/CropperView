//
//  AnotherViewController.swift
//  BannerImageCropper
//
//  Created by Yulia Novikova on 2/10/22.
//

import UIKit

class AnotherViewController: UIViewController {

    @IBOutlet weak var testView: BannerCroppingView!
    var firstLainch = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var config = BannerCropperCofiguration(image: UIImage(named: "test2")!)
        config.displayGrid = true
        config.gridColor = .white
        config.cropAreaBorderColor = .white
        testView.configure(with: config)
    }

    
    @IBAction func didPressCrop(_ sender: Any) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImagePresenter") as! ImagePresenter
        let image = testView.croppedImage()
        vc.image = image
        present(vc, animated: true, completion: nil)
    }
}





