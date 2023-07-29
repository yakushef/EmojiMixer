//
//  ViewController.swift
//  EmojiMixer
//
//  Created by Aleksey Yakushev on 29.07.2023.
//

import UIKit

final class EmojiViewController: UIViewController {
    
    var emojiCollection: UICollectionView!
    
    private let emojiList = ["🍇", "🍈", "🍉", "🍊", "🍋", "🍌", "🍍", "🥭", "🍎", "🍏", "🍐", "🍒", "🍓", "🫐", "🥝", "🍅", "🫒", "🥥", "🥑", "🍆", "🥔", "🥕", "🌽", "🌶️", "🫑", "🥒", "🥬", "🥦", "🧄", "🧅", "🍄"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        emojiCollection = UICollectionView(frame: view.safeAreaLayoutGuide.layoutFrame, collectionViewLayout: layout)
        emojiCollection.dataSource = self
        emojiCollection.delegate = self
        
        emojiCollection.register(EmojiCollectionCell.self, forCellWithReuseIdentifier: "Emoji Cell")
        
        view.addSubview(emojiCollection)
    }
}

extension EmojiViewController: UICollectionViewDelegate {

}

extension EmojiViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: emojiCollection.bounds.width / 2, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension EmojiViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojiList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = emojiCollection.dequeueReusableCell(withReuseIdentifier: "Emoji Cell", for: indexPath) as? EmojiCollectionCell else { return UICollectionViewCell() }

        cell.label.text = emojiList[indexPath.row]
        return cell
    }
}

#Preview {
    return EmojiViewController()
}
