//
//  homeController.swift
//  ipad1
//
//  Created by arrow on 5/21/20.
//  Copyright © 2020 arrow. All rights reserved.
//

import UIKit

class homeViewController: UIViewController {
    
    //MARK: - Properties
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.addSubview(profileImageView)
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.anchor(top: view.topAnchor, paddingTop: 88, width: 120, heigth: 120)
        return view
    }()
    
    let profileImageView:UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "avatar")
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("home page")
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .white
        
        //MARK: Add Subview
        view.addSubview(containerView)
        containerView.anchor(top: view.topAnchor, left: view.leftAnchor, rigth: view.rightAnchor,heigth: 300)

    }

    
}



extension UIView {
    
    func anchor(top:NSLayoutYAxisAnchor? = nil,left:NSLayoutXAxisAnchor? = nil,bottom:NSLayoutYAxisAnchor? = nil,rigth:NSLayoutXAxisAnchor? = nil,
        paddingTop:CGFloat? = 0,paddingLeft: CGFloat? = 0,paddingBottom:CGFloat? = 0,paddingRigth:CGFloat? = 0,
        width:CGFloat? = nil,heigth:CGFloat? = nil)
    {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop!).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft!).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingTop!).isActive = true
        }
        
        if let rigth = rigth {
            rightAnchor.constraint(equalTo: rigth, constant: -paddingRigth!).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let heigth = heigth {
            heightAnchor.constraint(equalToConstant: heigth).isActive = true
        }
    }
}
