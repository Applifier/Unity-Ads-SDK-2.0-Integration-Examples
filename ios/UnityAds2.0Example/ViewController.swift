//
//  ViewController.swift
//  UnityAds2.0Example
//
//  Created by Fritz Huie on 7/14/16.
//  Copyright © 2016 Fritz. All rights reserved.
//

import UIKit
import UnityAds

class ViewController: UIViewController, UnityAdsDelegate {

    var rewardVideoIsPlaying = false
    var coins = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UnityAds.isReady() ? enableButtons() : disableButtons()
        UnityAds.initialize("1016671", delegate: self)
        statusLabel.text = "Initializing"
        coinLabel.backgroundColor = UIColor(patternImage: UIImage(named: "coin.png")!)
    }

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var coinLabel: UILabel!
    @IBOutlet weak var interstatialButton: UIButton!
    @IBOutlet weak var rewardedButton: UIButton!

    @IBAction func interstatialPressed(sender: UIButton) {
        UnityAds.show(self)
        rewardVideoIsPlaying = false
        disableButtons()
    }
    
    @IBAction func rewardedPressed(sender: UIButton) {
        UnityAds.show(self, placementId: "rewardedVideo")
        rewardVideoIsPlaying = true
        disableButtons()
    }
    
    func unityAdsDidFinish(placementId: String, withFinishState state: UnityAdsFinishState) {
        
        if (state != .Skipped && rewardVideoIsPlaying) {
            coins+=10
            coinLabel.text = String(coins)
        }
        
        rewardVideoIsPlaying = false
        enableButtons()
    }
    
    func unityAdsReady(placementId: String) {
        enableButtons()
    }
    
    func unityAdsDidStart(placementId: String) {
        
    }
    
    func unityAdsDidError(error: UnityAdsError, withMessage message: String) {
        statusLabel.text = (message)
    }
    
    func disableButtons () {
        interstatialButton.enabled = false
        interstatialButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        rewardedButton.enabled = false
        rewardedButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
    }
    
    func enableButtons () {
        interstatialButton.enabled = true
        interstatialButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        rewardedButton.enabled = true
        rewardedButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
    }
    
}

