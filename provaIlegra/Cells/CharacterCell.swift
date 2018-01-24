//
//  CharacterCell.swift
//  provaIlegra
//
//  Created by Marcelo Garcia on 24/01/18.
//  Copyright © 2018 Marcelo Garcia. All rights reserved.
//

import UIKit

class CharacterCell: UITableViewCell {

    @IBOutlet weak var imageCharacter: UIImageView!
    @IBOutlet weak var nameCharacter: UILabel!
    
    func loadCharacterCell(character:Character, index:Int){
        nameCharacter.text = character.name
        
        DispatchQueue.global().async {
            let url = NSURL(string: (character.thumbnail?.path)! + "/portrait_xlarge." + (character.thumbnail?.extensionThumb)! )
            let data = NSData(contentsOf: url! as URL)
            
            DispatchQueue.main.async {
                if(self.tag == index) {
                    self.imageCharacter?.image = UIImage(data: data! as Data)
                }
            }
        }
    }

}
