//
//  ViewController.swift
//  desafioIos
//
//  Created by Mateus Fernandes on 18/06/20.
//  Copyright © 2020 Mateus Fernandes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var catsList:[Cat] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (collectionView.frame.size.width - 30) / 3, height: collectionView.frame.size.height / 6)
        collectionView.collectionViewLayout = layout
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        Api.getCats { (cats) in
            DispatchQueue.main.async {
                self.catsList = cats
                self.collectionView.reloadData()
            }
        }
    }
}

//MARK: UICollectionExtensions
extension ViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catsList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        let urlImage = self.catsList[indexPath.row].linkImg!
        cell.applyCatsImageFromUrl(url: urlImage)
        return cell
    }
}
