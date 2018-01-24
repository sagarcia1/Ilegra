//
//  ViewController.swift
//  provaIlegra
//
//  Created by Marcelo Garcia on 23/01/18.
//  Copyright © 2018 Marcelo Garcia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var charactersList:[Character] = [Character]()
    let bc =  CharacterClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        populateView();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension ViewController: CharactersDelegate {
    
    
    func success(response: [Character]) {
        activityIndicator.stopAnimating()
        tableView.isHidden = false
        
        charactersList += response
        tableView.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .fade)
    }
    
    func populateView() {
        tableView.isHidden = true;
        bc.delegate = self
        bc.getCharacters(offset: "0")
    }
    
    // Faltou adicionar o pull to refresh
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let cellBuffer: CGFloat = 0
        let bottom: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height
        let buffer: CGFloat = cellBuffer * 110
        let scrollPosition = scrollView.contentOffset.y
        
        if scrollPosition > bottom - buffer {
            bc.getCharacters(offset: String(charactersList.count))
            tableView.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .fade)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if "detailSegue" == segue.identifier {
            let detailViewController:DetailViewController = segue.destination as! DetailViewController
            let indexPath = tableView.indexPathForSelectedRow
            let cell = tableView.cellForRow(at: indexPath!) as! CharacterCell
            
            detailViewController.character = charactersList[indexPath!.row]
            detailViewController.imageThumb = cell.imageCharacter.image
        }
    }

}


extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (charactersList.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "charactersCell", for: indexPath) as? CharacterCell
        cell?.loadCharacterCell(character: (charactersList[indexPath.row]),index: indexPath.row)
        cell?.tag = indexPath.row
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detailSegue", sender: self)
    }
}
