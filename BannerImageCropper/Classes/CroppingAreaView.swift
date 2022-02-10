//
//  CroppingAreaView.swift
//  BannerImageCropper
//
//  Created by Yulia Novikova on 2/10/22.
//

import UIKit

struct CroppingAreaViewModel {
    var gridColor: UIColor?
    var displaysGrid = false
    var borderColor: UIColor?
    var borderWidth: CGFloat?
}

class CroppingAreaView: UIView {
    
    private var grid = GridView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configure(with model: CroppingAreaViewModel) {
        grid.tintColor = model.gridColor ?? .white
        grid.isHidden = !model.displaysGrid
        layer.borderColor = model.borderColor?.cgColor ?? UIColor.orange.cgColor
        layer.borderWidth = model.borderWidth ?? 1
    }
    
    static func scaleRect(rect: CGRect, scale: CGFloat) -> CGRect {
        return CGRect(
            x: rect.origin.x * scale,
            y: rect.origin.y * scale,
            width: rect.size.width * scale,
            height: rect.size.height * scale)
    }
    
    private func layoutGridView() {
        grid.translatesAutoresizingMaskIntoConstraints = false
        addSubview(grid)
        grid.backgroundColor = .clear
        grid.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        grid.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        grid.topAnchor.constraint(equalTo: topAnchor).isActive = true
        grid.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func configure() {
        layoutGridView()
        backgroundColor = .clear
    }
}
