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
    
    private var visibleEmoji: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Undo", style: .plain, target: self, action: #selector(undoLastEmoji))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addNewEmoji))
        
        let layout = UICollectionViewFlowLayout()
        emojiCollection = UICollectionView(frame: view.safeAreaLayoutGuide.layoutFrame, collectionViewLayout: layout)
        emojiCollection.dataSource = self
        emojiCollection.delegate = self
        
        emojiCollection.register(EmojiCollectionCell.self, forCellWithReuseIdentifier: "Emoji Cell")
        
        view.addSubview(emojiCollection)
    }
    
    @objc func addNewEmoji() {
        let nextEmojiIndex = visibleEmoji.count
        
        if visibleEmoji.count < emojiList.count {
            visibleEmoji.append(emojiList[visibleEmoji.count])
        } else { return }
        
        emojiCollection.performBatchUpdates {
            emojiCollection.insertItems(at: [IndexPath(item: nextEmojiIndex, section: 0)])
        }
    }
    
    @objc func undoLastEmoji() {
        let lastEmojiIndex = visibleEmoji.count - 1
        
        if visibleEmoji.count > 0 {
            visibleEmoji.removeLast()
        } else { return }
        
        emojiCollection.performBatchUpdates {
            emojiCollection.deleteItems(at: [IndexPath(item: lastEmojiIndex, section: 0)])
        }
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
        return visibleEmoji.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = emojiCollection.dequeueReusableCell(withReuseIdentifier: "Emoji Cell", for: indexPath) as? EmojiCollectionCell else { return UICollectionViewCell() }

        cell.label.text = visibleEmoji[indexPath.row]
        return cell
    }
}

#Preview {
    return UINavigationController(rootViewController: EmojiViewController())
}
