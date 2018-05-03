//
//  ViewController.swift
//  CustomLoader_Swift
//
//  Created by WOS_MacMini_1 on 28/04/18.
//  Copyright © 2018 White Orange Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnShowLoader: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnShowLoaderAction() {
        
        let objVC : LoaderVC = self.storyboard?.instantiateViewController(withIdentifier: "LoaderVC") as! LoaderVC
        objVC.show_AnimatedLoader = true
        objVC.Popup_Show(asViewController: objVC, onViewController: self)
        
        let deadlineTime = DispatchTime.now() + .seconds(10)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            //objVC.Popup_Hide(onViewController: self)
        };
    }
}

