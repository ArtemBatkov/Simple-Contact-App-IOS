//
//  Toast.swift
//  Simple Contact App
//
//  Created by user225247 on 12/10/22.
//

import Foundation
import UIKit

class Toast{
    func showToast(vc: UIViewController, message : String, font: UIFont) {
        let toastLabel = UILabel(frame: CGRect(x: 0, y: 0, width: vc.view.frame.size.width, height: vc.view.frame.size.height))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        vc.view.addSubview(toastLabel)
        UIView.animate(withDuration: 2.5, delay: 0.0, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
