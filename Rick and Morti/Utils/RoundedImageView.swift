//
//  RoundedImageView.swift
//  Rick and Morti
//
//  Created by Youchen Zhou on 6/2/23.
//

import Foundation
import UIKit
@IBDesignable
class RoundedImageView: UIImageView{
    @IBInspectable var cornerRadiusValue: CGFloat = 10.0 {
        didSet {
            setUpView()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
    func setUpView() {
        self.layer.cornerRadius = self.cornerRadiusValue
        self.clipsToBounds = true
    }
}
