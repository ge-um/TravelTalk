//
//  ChatListViewController.swift
//  TravelTalk
//
//  Created by 금가경 on 7/19/25.
//

import UIKit

// TODO: - CollectionView와 TableView의 차이는 무엇일까? 정리하기
class ChatListViewController: UIViewController {
    @IBOutlet var chatListCollectionView: UICollectionView!
    @IBOutlet var searchBar: UISearchBar!
    
    var filteredList = ChatList.list
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        registerNib()
        configureCollectionView()
        configureCollectionViewLayout()
        configureSearchBar()
        configureNavigationBar()
    }
    
    // MARK: - CollectionView Initialization
    private func registerNib() {
        print(self, #function)
        let nib = UINib(nibName: "ChatListCollectionViewCell", bundle: nil)
        
        chatListCollectionView.register(nib, forCellWithReuseIdentifier: "ChatListCollectionViewCell")
    }
    
    // MARK: - CollectionView Layout
    private func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = deviceWidth - 16 * 2
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: cellWidth, height: 60)
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        chatListCollectionView.collectionViewLayout = layout
    }
    
    private func configureNavigationBar() {
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        
        backBarButtonItem.tintColor = .black
        navigationItem.backBarButtonItem = backBarButtonItem
        navigationItem.title = "TRAVEL TALK"
    }
}

extension ChatListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    private func configureCollectionView() {
        chatListCollectionView.dataSource = self
        chatListCollectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(#function)

        return filteredList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(#function)
        let cell = chatListCollectionView.dequeueReusableCell(withReuseIdentifier: "ChatListCollectionViewCell", for: indexPath) as! ChatListCollectionViewCell
        
        cell.configureData(with: filteredList[indexPath.item])
        
        DispatchQueue.main.async {
            cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.width / 2
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ChatRoomViewController") as! ChatRoomViewController
        
        let chatRoom = filteredList[indexPath.item]
        vc.title = chatRoom.chatroomName
        vc.chatRoom = chatRoom
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ChatListViewController: UISearchBarDelegate {
    // TODO: - SearchBar 동작에 대해 공부하기
    func configureSearchBar() {
        searchBar.delegate = self
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "친구 이름을 검색해보세요"
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(#function)
        search(searchText: searchText)
    }
    
    // TODO: - 미리 캐싱을 하는 방식으로 반복을 줄일 수 있을지도..
    func search(searchText: String) {
        if searchText.isEmpty {
            filteredList = ChatList.list
        } else {
            let lowerCased = searchText.lowercased()
            
            filteredList = ChatList.list.filter { chatRoom in
                chatRoom.chatList.contains { chat in
                    chat.user.name.lowercased().contains(lowerCased)
                }
            }
        }
        chatListCollectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}
