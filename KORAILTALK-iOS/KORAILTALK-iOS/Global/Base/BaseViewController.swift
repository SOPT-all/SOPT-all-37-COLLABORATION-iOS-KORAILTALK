//
//  BaseViewController.swift
//  KORAILTALK-iOS
//
//  Created by 어재선 on 11/17/25.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setAddTarget()
        setDelegate()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func setView() {}
    
    func setAddTarget() {}
    
    func setDelegate() {}
}

