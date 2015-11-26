//
//  PokemonDetailVC.swift
//  pokedex-app
//
//  Created by Andrew Nicholson on 24/11/2015.
//  Copyright © 2015 Nicholson Media. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexIdLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var evoStrip: UIView!
    @IBOutlet weak var bioStackView: UIStackView!
    @IBOutlet weak var evoStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = pokemon.name.capitalizedString
        let img = UIImage(named: "\(pokemon.pokedexId)")
        mainImg.image = img
        currentEvoImg.image = img
        
        //just hide the current evolution as it was suppossed to be previous. No point showing this.
        currentEvoImg.hidden = true
        
        //clear labels because it will take a second to download all this stuff.
        clearUI()
        
        pokemon.downloadPokemonDetails { () -> () in
            //this will be called after download is done
            self.updateUI()
        }
    }
    
    func clearUI() {
        descriptionLbl.text = ""
        typeLbl.text = ""
        defenseLbl.text = ""
        pokedexIdLbl.text = ""
        heightLbl.text = ""
        weightLbl.text = ""
        baseAttackLbl.text = ""
        evoLbl.text = ""
        nextEvoImg.hidden = true
        evoStrip.hidden = true
        bioStackView.hidden = true
        evoStackView.hidden = true
    }
    
    func updateUI() {
        descriptionLbl.text = pokemon.description
        typeLbl.text = pokemon.type
        defenseLbl.text = pokemon.defense
        pokedexIdLbl.text = "\(pokemon.pokedexId)"
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        baseAttackLbl.text = pokemon.attack
        
        if pokemon.nextEvolutionId == "" {
            evoLbl.text = "No Evolutions"
            nextEvoImg.hidden = true
        }else {
            nextEvoImg.hidden = false
            nextEvoImg.image = UIImage(named: pokemon.nextEvolutionId)
            var evoStr = "Next Evolution: \(pokemon.nextEvolutionTxt)"
            if pokemon.nextEvolutionLvl != "" {
                evoStr += " - LVL \(pokemon.nextEvolutionLvl)"
            }
            evoLbl.text = evoStr
        }
        evoStrip.hidden = false
        bioStackView.hidden = false
        evoStackView.hidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
