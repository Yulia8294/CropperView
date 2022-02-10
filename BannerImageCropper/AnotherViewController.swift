//
//  AnotherViewController.swift
//  BannerImageCropper
//
//  Created by Yulia Novikova on 2/10/22.
//

import UIKit

class AnotherViewController: UIViewController {

    @IBOutlet weak var testView: ImageCropperView!
    var firstLainch = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if firstLainch {
            testView.updateMinZoomScaleForSize(view.bounds.size)
            testView.centerContent()
            firstLainch = false
        }
        
       
    }
    
    @IBAction func didPressCrop(_ sender: Any) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImagePresenter") as! ImagePresenter
        let image = testView.croppedImage()
        vc.image = image
        present(vc, animated: true, completion: nil)
    }
}





