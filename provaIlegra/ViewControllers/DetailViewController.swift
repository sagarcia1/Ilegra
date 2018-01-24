//
//  DetailViewController.swift
//  provaIlegra
//
//  Created by Marcelo Garcia on 24/01/18.
//  Copyright © 2018 Marcelo Garcia. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var DetailImageView: UIImageView!
    @IBOutlet var DetailDescriptionLabel: UILabel!
    @IBOutlet var DetailTitleLabel: UILabel!
    
    var character : Character?
    var imageThumb: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateView()
    }
    
    func populateView() {
        DetailImageView.image = imageThumb
        DetailDescriptionLabel.text = character?.description?.characters.count == 0 ? "Description not found" : character?.description
        DetailTitleLabel.text = character?.name
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
