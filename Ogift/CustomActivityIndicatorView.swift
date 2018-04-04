//
//  CustomActivityIndicatorView.swift
//  Ogift
//
//  Created by Sukumar Anup Sukumaran on 23/01/18.
//  Copyright © 2018 AssaRadviewTech. All rights reserved.
//

import UIKit
import QuartzCore

class CustomActivityIndicatorView: UIView {

    lazy private var animationLayer : CALayer = {
        return CALayer()
    }()
    
    var isAnimating : Bool = false
    var hidesWhenStopped : Bool = true
    
    init(image : UIImage) {
        
        let frame : CGRect = CGRect(x: 0.0, y: 0.0, width: image.size.width, height: image.size.height)
        
        super.init(frame: frame)
        
        animationLayer.frame = frame
        animationLayer.contents = image.cgImage
        animationLayer.masksToBounds = true
        
        self.layer.addSublayer(animationLayer)
        
        addRotation(forLayer: animationLayer)
        pause(layer: animationLayer)
        
        self.isHidden = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK - Func to rotate image
    
    func addRotation(forLayer layer : CALayer) {
        
        let rotation : CABasicAnimation = CABasicAnimation(keyPath : "transform.rotation.y")
        
        rotation.duration = 1.0
        rotation.isRemovedOnCompletion = false
        rotation.repeatCount = HUGE
        rotation.fillMode = kCAFillModeForwards
        rotation.fromValue = NSNumber(value: 0.0)
        rotation.toValue = NSNumber(value: 3.14 * 2.0)
        
        layer.add(rotation, forKey: "rotate")
        
    }
    
     //MARK - Func to pause image
    
    func pause(layer : CALayer) {
        
        let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        
        layer.speed = 0.0
        layer.timeOffset = pausedTime
        
        isAnimating = false
        
    }
    
    
    func startAnimating() {
        print("startAnimating()")
//        if isAnimating {
//            return
//        }
        
//        isAnimating = true
        addRotation(forLayer: animationLayer)
        pause(layer: animationLayer)
        
        if hidesWhenStopped {
            
            self.isHidden = false
            print("LoaderIsNotHidden")
        }
        
        resume(layer: animationLayer)
        
         print("startAnimating().END")
        
    }
    
    func stopAnimating() {
         print("stopAnimating()")
        
        if hidesWhenStopped {
            self.isHidden = true
             print("LoaderIsHidden")
        }
        isAnimating = false
//resume(layer: animationLayer)
          print("stopAnimating().END")
    }
    
    func resume(layer : CALayer) {
        
        let pausedTime : CFTimeInterval = layer.timeOffset
        
        layer.speed = 1.0
        layer.timeOffset  = 0.0
        layer.beginTime = 0.0
        
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        
        layer.beginTime = timeSincePause
        
        isAnimating = true
        
    }
    
    
    
    

}
