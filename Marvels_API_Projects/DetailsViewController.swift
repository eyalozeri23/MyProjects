//
//  DetailsViewController.swift
//  MarvelProject
//
//  Created by HackerU on 17/05/2017.
//  Copyright © 2017 juda. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
	
	var collectionArray : [MarvelComics] = []

	@IBOutlet weak var collectionView : UICollectionView!
	@IBOutlet weak var textView: UITextView!
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var label: UILabel!
	
    var item : MarvelCharacter?
    
    var comicsItem : MarvelComics?
    
    
    func savePhotoToGallery(){
        
        // save image to photo gallery
        UIImageWriteToSavedPhotosAlbum(self.heroImage.image!, nil, nil, nil)
        
        let alertController = UIAlertController(title: "Alert", message: "Photo Saved", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func shareDescriptionText(){
        
        let textToShare =  self.item?.desc
        
        let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [textToShare!], applicationActivities: nil)
        let currentViewController : UIViewController = (UIApplication.shared.keyWindow?.rootViewController)!
        
        currentViewController.present(activityViewController, animated: true, completion: nil)
    }
    


    
    //MARK: - IBAction
    
	@IBAction func SavePhotoAction(_ sender: UIBarButtonItem) {
		
        
        //MARK: - AlertActionSheet 
        
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        let saveAction = UIAlertAction(title: "Save Photo", style: .default) { (action) in
            
           self.savePhotoToGallery()
            
        }
        let shareAction = UIAlertAction(title: "Share Text", style: .default) { (action) in
            
            self.shareDescriptionText()
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        
        optionMenu.addAction(shareAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
		
		
	}
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
		navigationItem.title = item?.name
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
		
		if let urlString = item?.thumbUrlString,
		let url = URL(string: urlString){
			heroImage.sd_setImage(with: url)
		}
		
		textView.text = item?.desc
        
        getData()
        
        if item?.desc != nil{
            if (item?.desc!.isEmpty)!{
                textView.text = "No Description"
            }
        }
        
		
    }
	
	func getData(){
		guard let id = item?.heroId else{
			return
		}
		
		MarvelAPIManager.manager.getComics(by: id.description) { (arr, str) in
			self.collectionArray = arr
			self.collectionView.reloadData()
		}
		
	}
    
    //MARK: - CollectionView
	
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return collectionArray.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? ItemCellCollectionView
		
		cell?.configureComics(with: collectionArray[indexPath.row])
		
		
		return cell!
	}
	
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		collectionView.deselectItem(at: indexPath, animated: true)
	}
    
    
    //MARK: - Navigation
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		if segue.identifier == "comicDetailSegue",
			let indexPath = collectionView.indexPathsForSelectedItems?.first,
			let nextVC = segue.destination as? ComicDetailViewController{
			
			let object = collectionArray[indexPath.item]
			nextVC.item = object
		
	}

  }
}
