//
//  BottomSheetViewController.swift
//  WatchOut!
//
//  Created by Derek Wu on 2017/4/8.
//  Copyright © 2017年 Xintong Wu. All rights reserved.
//

import Foundation
import UIKit

class BottomSheetViewController: UIViewController{
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var blgLimit: UILabel!
    @IBOutlet weak var TIV: UILabel!
    @IBOutlet weak var premiumAmount: UILabel!
    @IBOutlet weak var policyNum: UILabel!
    @IBOutlet weak var longitude: UILabel!
//    @IBOutlet weak var severity: UILabel!
    
    let fullView: CGFloat = 100
    var partialView: CGFloat {
        return UIScreen.main.bounds.height - 150
    }
    
    //Configuration
    func prepareBackgroundView(){
        let blurEffect = UIBlurEffect.init(style: .extraLight)
        let visualEffect = UIVisualEffectView.init(effect: blurEffect)
        let bluredView = UIVisualEffectView.init(effect: blurEffect)
        bluredView.contentView.addSubview(visualEffect)
        
        visualEffect.frame = UIScreen.main.bounds
        bluredView.frame = UIScreen.main.bounds
        
        view.insertSubview(bluredView, at: 0)
    }
    
    func panGesture(recognizer: UIPanGestureRecognizer) {
//        let translation = recognizer.translation(in: self.view)
        let velocity = recognizer.velocity(in: self.view)
        
//        let y = self.view.frame.minY
        //self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
        recognizer.setTranslation(CGPoint(x: 0,y :0), in: self.view)
        
        //
        if recognizer.state == .ended {
//            var duration =  velocity.y < 0 ? Double((y - fullView) / -velocity.y) : Double((partialView - y) / velocity.y )
//            
//            duration = duration > 1.3 ? 1 : duration
            let duration = 0.2
            UIView.animate(withDuration: duration, delay: 0.0, options: [.allowUserInteraction], animations: {
                if  velocity.y >= 0 {
                    self.view.frame = CGRect(x: 0, y: self.partialView, width: self.view.frame.width, height: self.view.frame.height)
                } else {
                    self.view.frame = CGRect(x: 0, y: self.fullView, width: self.view.frame.width, height: self.view.frame.height)
                }
            }, completion: { [weak self] _ in
                if ( velocity.y < 0 ) {
                    print(velocity.y)
                }
            })
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareBackgroundView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        UIView.animate(withDuration: 0.3) { [weak self] in
            let frame = self?.view.frame
            let yComponent = UIScreen.main.bounds.height - 200
            self?.view.frame = CGRect(x: 0, y: yComponent, width: frame!.width, height: frame!.height)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var cur_risk = earthquake(lattitude: (lattitude: cur_lat), longitude: (longitude: cur_lon), radius: Double(r_))//declare object
        
        latitude.text = String(cur_lat)
        longitude.text = String(cur_lon)
        blgLimit.text = String(cur_risk.Building_limit_count)
        TIV.text = String(cur_risk.TIV_count)
        premiumAmount.text = String(cur_risk.Premium_count)
        policyNum.text = String(cur_risk.count)
        
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(BottomSheetViewController.panGesture))
        view.addGestureRecognizer(gesture)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
