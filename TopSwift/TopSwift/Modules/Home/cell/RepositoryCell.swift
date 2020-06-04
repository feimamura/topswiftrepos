//
//  RepositoryCell.swift
//  TopSwift
//
//  Created by Felipe Imamura on 02/06/20.
//  Copyright © 2020 Felipe Imamura. All rights reserved.
//

import UIKit
import Kingfisher

class RepositoryCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblStars: UILabel!
    @IBOutlet weak var imageViewOwnerUser: UIImageView!
    @IBOutlet weak var lblOwnerName: UILabel!
    
    var repository: Repository? {
        
        willSet(newValue) {
            
            if let name = newValue?.name {
                self.lblName.text = name
            }
            if let stars = newValue?.stargazers_count {
                self.lblStars.text = "\(stars)"
            }
            if let urlString = newValue?.owner.avatar_url {
                let url = URL(string: urlString)
                
                self.imageViewOwnerUser.kf.indicatorType = .activity
                self.imageViewOwnerUser.kf.setImage(with: url, options: [.transition(.fade(0.8))])
            }
            if let login = newValue?.owner.login {
                self.lblOwnerName.text = "Author: \(login)"
            }
        }
    }
    
}


class ShadowView: UIView {
    
    private var shadowLayer: CAShapeLayer!
    private var corners : UIRectCorner = []
    private var fillColorI: UIColor = .white
    private var shadowColorI: UIColor = .white
    
    @IBInspectable var fillColor: UIColor = .white {
        didSet {
            fillColorI = fillColor
        }
    }
    
    @IBInspectable var shadowColor: UIColor = .white {
        didSet {
            shadowColorI = shadowColor
        }
    }
    
    @IBInspectable public var cornerRadius : CGFloat = 0 {
        didSet {
            setup()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    
    private func setup() {
        
        backgroundColor = .clear
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            
            shadowLayer.fillColor = fillColorI.cgColor
            shadowLayer.shadowColor = shadowColorI.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = .zero
            shadowLayer.shadowOpacity = 1.0
            shadowLayer.shadowRadius = 5.0
            
            layer.insertSublayer(shadowLayer, at: 0)
        }
        else {
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.fillColor = fillColorI.cgColor
            shadowLayer.shadowColor = shadowColorI.cgColor
        }
    }
    
}
