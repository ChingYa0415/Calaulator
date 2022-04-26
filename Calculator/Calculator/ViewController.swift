//
//  ViewController.swift
//  Calculator
//
//  Created by Angus on 2022/4/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            if let font = UIFont(name: "Color", size: 34) {
                titleLabel.font = UIFontMetrics(forTextStyle: .title1).scaledFont(for: font)
            }
        }
    }
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            if let font = UIFont(name: "Color", size: 34) {
                nameLabel.font = UIFontMetrics(forTextStyle: .title1).scaledFont(for: font)
            }
        }
    }
    @IBOutlet weak var nameTextField: UITextField! {
        didSet {
            if let font = UIFont(name: "Color", size: 34) {
                nameTextField.font = UIFontMetrics(forTextStyle: .title1).scaledFont(for: font)
            }
        }
    }
    @IBOutlet weak var goButton: UIButton! {
        didSet {
            if let font = UIFont(name: "Color", size: 26) {
                goButton.titleLabel?.font = UIFontMetrics(forTextStyle: .title1).scaledFont(for: font)
            }
        }
    }
    
    private var imageView: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        image.image = UIImage(named: "calculator")
        
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        let moveTransform = CGAffineTransform.init(translationX: 600, y: 0)
        let scaleTransform = CGAffineTransform.init(scaleX: 5.0, y: 5.0)
        let moveScaleTransform = scaleTransform.concatenating(moveTransform)
        
        changeAlpha(alpha: 0, transform: moveScaleTransform)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.center = view.center
        
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            self.animate()
        })
    }

    private func animate() {
        UIView.animate(withDuration: 0.5) {
            let size = self.view.frame.size.width * 1.5
            let diffX = size - self.view.frame.size.width
            let diffY = self.view.frame.height - size
            
            self.imageView.frame = CGRect(x: -(diffX / 2), y: diffY / 2, width: size, height: size )
        
            self.imageView.alpha = 0
        }
        
        UIView.animate(withDuration: 0.6, delay: 0.1, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.3, options: [], animations: {
            self.changeAlpha(alpha: 1, transform: .identity)
        }, completion: nil)
        
    }
    
    private func changeAlpha(alpha: CGFloat, transform: CGAffineTransform) {
        logoImageView.alpha = alpha
        titleLabel.alpha = alpha
        nameLabel.alpha = alpha
        nameTextField.alpha = alpha
        goButton.alpha = alpha
        
        logoImageView.transform = transform
        titleLabel.transform = transform
        nameLabel.transform = transform
        nameTextField.transform = transform
        goButton.transform = transform
    }
    
}
