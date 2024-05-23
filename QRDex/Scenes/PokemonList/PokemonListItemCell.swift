//
//  PokemonListItemCell.swift
//  QRDex
//
//  Created by N648006 N648006 on 23/5/2567 BE.
//

import UIKit
import Kingfisher

class PokemonListItemCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var pkmImg: UIImageView!
    @IBOutlet weak var bgView: UIView!
    
    func apply(pokemon: PokemonData) {
        bgView.layer.cornerRadius = 8
        bgView.layer.masksToBounds = false
        bgView.layer.shadowColor = UIColor.gray.cgColor
        bgView.layer.shadowOffset = CGSize.zero
        bgView.layer.shadowOpacity = 0.1
        bgView.layer.shadowRadius = 4.0
        title.text = "#\(pokemon.id) \(pokemon.name)"
        pkmImg.image = nil
        pkmImg.kf.indicatorType = .activity
        guard let url = URL(string: pokemon.imageURL) else {
            return
        }
        let processor = DownsamplingImageProcessor(size: pkmImg.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        pkmImg.kf.setImage(
            with: url,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheMemoryOnly
            ]
        )
    }
}

