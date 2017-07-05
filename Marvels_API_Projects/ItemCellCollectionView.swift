//
//  ItemCellCollectionView.swift
//  MarvelProject
//
//  Created by hackeru on 18/05/2017.
//  Copyright © 2017 juda. All rights reserved.
//

import UIKit

class ItemCellCollectionView: UICollectionViewCell {

	
	@IBOutlet weak var comicTitle: UILabel!	
	@IBOutlet weak var comicImage: UIImageView!
	
	func configureComics (with item : MarvelComics){
		
		let title = (item.title ?? "")
		comicTitle.text = title
		if let url = URL(string : item.thumbnailComic!){
			comicImage.sd_setImage(with: url)
		} else{
			comicImage.sd_cancelCurrentImageLoad()
			comicImage.image = nil
		}
		
		
	}
}
