//
//  ViewController.swift
//  ResizeRectangle
//
//  Created by Peter Pohlmann on 20.01.19.
//  Copyright © 2019 Peter Pohlmann. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var rect: UIView!
    
    struct ResizeRect{
        var topTouch = false
        var leftTouch = false
        var rightTouch = false
        var bottomTouch = false
        var middelTouch = false
    }
    
    var touchStart = CGPoint.zero
    var proxyFactor = CGFloat(10)
    var resizeRect = ResizeRect()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            
            let touchStart = touch.location(in: self.view)
            print(touchStart)
            
            resizeRect.topTouch = false
            resizeRect.leftTouch = false
            resizeRect.rightTouch = false
            resizeRect.bottomTouch = false
            resizeRect.middelTouch = false
            
            if  touchStart.y > rect.frame.minY + (proxyFactor*2) &&  touchStart.y < rect.frame.maxY - (proxyFactor*2) &&  touchStart.x > rect.frame.minX + (proxyFactor*2) &&  touchStart.x < rect.frame.maxX - (proxyFactor*2){
                resizeRect.middelTouch = true
                print("middle")
                return
            }
            
            if touchStart.y > rect.frame.maxY - proxyFactor &&  touchStart.y < rect.frame.maxY + proxyFactor {
                resizeRect.bottomTouch = true
                print("bottom")
            }
            
            if touchStart.x > rect.frame.maxX - proxyFactor && touchStart.x < rect.frame.maxX + proxyFactor {
                resizeRect.rightTouch = true
                print("right")
            }
            
            if touchStart.x > rect.frame.minX - proxyFactor &&  touchStart.x < rect.frame.minX + proxyFactor {
                resizeRect.leftTouch = true
                print("left")
            }
            
            if touchStart.y > rect.frame.minY - proxyFactor &&  touchStart.y < rect.frame.minY + proxyFactor {
                resizeRect.topTouch = true
                print("top")
            }
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            let currentTouchPoint = touch.location(in: self.view)
            let previousTouchPoint = touch.previousLocation(in: self.view)
            
            let deltaX = currentTouchPoint.x - previousTouchPoint.x
            let deltaY = currentTouchPoint.y - previousTouchPoint.y
            
            
            if resizeRect.middelTouch{
                topConstraint.constant += deltaY
                leftConstraint.constant += deltaX
                rightConstraint.constant -= deltaX
                bottomConstraint.constant -= deltaY
            }
            
            if resizeRect.topTouch {
                topConstraint.constant += deltaY
            }
            
            if resizeRect.leftTouch {
                leftConstraint.constant += deltaX
            }
            if resizeRect.rightTouch {
                rightConstraint.constant -= deltaX
            }
            if resizeRect.bottomTouch {
                bottomConstraint.constant -= deltaY
            }
            
            
            UIView.animate(withDuration: 0.25, delay: 0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                self.view.layoutIfNeeded()
            }, completion: { (ended) in
                
            })
        }
    }
    
}

