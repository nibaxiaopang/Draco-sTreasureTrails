//
//  Setting.swift
//  DracosTreasureTrails
//
//  Created by Draco’s Treasure Trails on 2024/12/24.
//


import UIKit

class TreasureSettingViewController: UIViewController {

    //MARK: - Declare IBOutlets
    
    
    //MARK: - Declare Variables
    
    
    //MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Functions
    
    
    //MARK: - Declare IBAction
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnShareApp(_ sender: Any) {
        let textToShare = "Check out Draco’s Treasure Trails app!"
        
        let activityViewController = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
        
        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.airDrop]
        
        if let popoverController = activityViewController.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        present(activityViewController, animated: true, completion: nil)
    }
    
}
