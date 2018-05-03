//
//  LoaderVC.swift
//  CustomLoader_Swift
//
//  Created by WOS_MacMini_1 on 28/04/18.
//  Copyright © 2018 White Orange Software. All rights reserved.
//

import UIKit
import Foundation

import Lottie

class LoaderVC: UIViewController {
    
    //MARK: - Outlet
    static let duration_after = 0.05
    static let duration_popup = 0.20
    
    @IBOutlet weak var viewLoader_Main: UIView!
    
    @IBOutlet weak var viewLoader_Image: UIView!
    @IBOutlet weak var imgLoader: UIImageView!
    
    @IBOutlet weak var viewLoader_Lotties: UIView!
    @IBOutlet weak var viewLoader_Lotties_BG: LOTAnimationView!
    @IBOutlet weak var viewLoader_Lotties_loader: LOTAnimationView!
    
    @IBOutlet weak var viewSideMenu: UIView!
    @IBOutlet weak var lc_viewSideMenu_x: NSLayoutConstraint!
    
    //MARK: - Variables
    var show_AnimatedLoader : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Set BG-Color
        self.view.backgroundColor = UIColor.clear
        //Set Main-View BG-Color
        viewLoader_Main.backgroundColor = UIColor.init(red: 170/255, green: 170/255, blue: 170/255, alpha: 0.50)
        
        //Set Sidemenu View Frame
        self.sidemenu_hide(withAnimation: false)
        //self.sidemenu_show(withAnimation: true)
        
        //Manage Show Loader
        viewLoader_Image.isHidden = true
        viewLoader_Lotties.isHidden = true
        
        if (show_AnimatedLoader == true) {
            self.manage_LottiesLoader()
            
            viewLoader_Lotties.backgroundColor = UIColor.clear
            viewLoader_Lotties.isHidden = false
        }
        else {
            self.rotateView(targetView: viewLoader_Image, duration: 1.0)
            
            viewLoader_Image.backgroundColor = UIColor.clear
            viewLoader_Image.isHidden = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: -
    func sidemenu_hide(withAnimation: Bool) -> Void {
        var sidemenu_view_position_x : CGFloat = 0.0
        sidemenu_view_position_x = -self.view.frame.width * 0.80
        
        if (withAnimation == true) {
            let deadlineTime = DispatchTime.now() + LoaderVC.duration_after
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                DispatchQueue.main.async {
                    UIView.animate(withDuration: LoaderVC.duration_popup, animations: {
                        //Set BG Color Clear
                        self.viewLoader_Main.backgroundColor = UIColor.clear
                        
                        self.lc_viewSideMenu_x.constant = sidemenu_view_position_x
                        self.view.layoutIfNeeded()
                    })
                }
            }
        }
        else {
            self.lc_viewSideMenu_x.constant = sidemenu_view_position_x
            self.view.layoutIfNeeded()
        }
    }
    
    func sidemenu_show(withAnimation: Bool) -> Void {
        var sidemenu_view_position_x : CGFloat = 0.0
        sidemenu_view_position_x = 0.0
        
        if (withAnimation == true) {
            let deadlineTime = DispatchTime.now() + LoaderVC.duration_after
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                DispatchQueue.main.async {
                    UIView.animate(withDuration: LoaderVC.duration_popup, animations: {
                        self.lc_viewSideMenu_x.constant = sidemenu_view_position_x
                        self.view.layoutIfNeeded()
                    })
                }
            }
        }
        else {
            self.lc_viewSideMenu_x.constant = sidemenu_view_position_x
            self.view.layoutIfNeeded()
        }
    }
    
    private func rotateView(targetView: UIView, duration: Double = 2.0) {
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveLinear, animations: {
            targetView.transform = targetView.transform.rotated(by: CGFloat(M_PI * 01))
        }) { finished in
            self.rotateView(targetView: targetView, duration: duration)
        }
    }
    
    func manage_LottiesLoader() {
        let deadlineTime = DispatchTime.now() + LoaderVC.duration_after
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            DispatchQueue.main.async {
            
                //Set BG
                let strFileName_BG : NSString = "confetti"
                self.viewLoader_Lotties_BG.setAnimation(named: strFileName_BG as String)
                self.viewLoader_Lotties_BG.contentMode = UIViewContentMode.scaleAspectFit
                self.viewLoader_Lotties_BG.play()
                self.viewLoader_Lotties_BG.loopAnimation = true
            
                //Set Loader
                let strFileName_Loader : NSString = "heartbutton"
                self.viewLoader_Lotties_loader.setAnimation(named: strFileName_Loader as String)
                self.viewLoader_Lotties_loader.contentMode = UIViewContentMode.scaleAspectFit
                self.viewLoader_Lotties_loader.play()
                self.viewLoader_Lotties_loader.loopAnimation = true
            }
        }
    }
    
    //MARK: - Button action method
    @IBAction func btnDismissAction() {
        self.Popup_Hide(onViewController: UIViewController.init())
    }
    
    //MARK: - Loader (Custome)
    func Popup_Show(asViewController:UIViewController) -> Void {
        //let objVC : LoaderVC = self.storyboard?.instantiateViewController(withIdentifier: "LoaderVC") as! LoaderVC
        //self.Popup_Show(asViewController: objVC, onViewController: asViewController)
        self.Popup_Show(asViewController: self, onViewController: asViewController)
    }
    
    func Popup_Show(asViewController:UIViewController, onViewController: UIViewController) -> Void {
        DispatchQueue.main.async {
            asViewController.modalPresentationStyle = .overCurrentContext
            asViewController.modalTransitionStyle = .crossDissolve
            
            onViewController.present(asViewController, animated: false, completion: nil)
            //UIApplication.shared.delegate?.window!?.rootViewController?.present(objVC, animated: true, completion: nil)
        }
    }
    
    func Popup_Hide(onViewController: UIViewController) {
        
        self.sidemenu_hide(withAnimation: true)
        
        let deadlineTime = DispatchTime.now() + LoaderVC.duration_popup * 1.2
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            
            DispatchQueue.main.async {
                //self.viewLoader_Main.backgroundColor = UIColor.clear
                
                //onViewController.dismiss(animated: false, completion: nil)
                UIApplication.shared.delegate?.window!?.rootViewController?.dismiss(animated: false, completion: nil)
            }
        }
    }
}
