//
//  ChatListCollectionViewController.swift
//  TravelTalk
//
//  Created by 금가경 on 7/19/25.
//

import UIKit

class ChatListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet var chatListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        registerNib()
        configureCollectionView()
        configureLayout()
    }
    
    // MARK: - CollectionView Initialization
    private func registerNib() {
        print(#function)
        let nib = UINib(nibName: "ChatListCollectionViewCell", bundle: nil)
        
        chatListCollectionView.register(nib, forCellWithReuseIdentifier: "ChatListCollectionViewCell")
    }
    
    private func configureCollectionView() {
        chatListCollectionView.dataSource = self
        chatListCollectionView.delegate = self
    }
    
    // MARK: - CollectionView Layout
    private func configureLayout() {
        let layout = UICollectionViewFlowLayout()
        let deviceWidth = UIScreen.main.bounds.width
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: deviceWidth, height: 60)
        
        chatListCollectionView.collectionViewLayout = layout
    }
    
    // MARK: - CollectionView Setting
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(#function)

        return ChatList.list.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(#function)
        let cell = chatListCollectionView.dequeueReusableCell(withReuseIdentifier: "ChatListCollectionViewCell", for: indexPath) as! ChatListCollectionViewCell
        
        cell.configureData(with: ChatList.list[indexPath.item])
        
        return cell
        
    }
}
