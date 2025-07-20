//
//  ChatListViewController.swift
//  TravelTalk
//
//  Created by 금가경 on 7/19/25.
//

import UIKit

// TODO: - CollectionView와 TableView의 차이는 무엇일까? 정리하기
class ChatListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
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
    }
    
    // MARK: - CollectionView Initialization
    private func registerNib() {
        print(self, #function)
        let nib = UINib(nibName: "ChatListCollectionViewCell", bundle: nil)
        
        chatListCollectionView.register(nib, forCellWithReuseIdentifier: "ChatListCollectionViewCell")
    }
    
    private func configureCollectionView() {
        chatListCollectionView.dataSource = self
        chatListCollectionView.delegate = self
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
    
    // MARK: - CollectionView Setting
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(#function)

        return filteredList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(#function)
        let cell = chatListCollectionView.dequeueReusableCell(withReuseIdentifier: "ChatListCollectionViewCell", for: indexPath) as! ChatListCollectionViewCell
        
        cell.configureData(with: filteredList[indexPath.item])
        
        // TODO: - Drawing Cycle 공부하고 layoutSubView로 바꿔보기
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
    
    // TODO: - SearchBar 동작에 대해 공부하기
    // MARK: - SearchBar
    func configureSearchBar() {
        searchBar.delegate = self
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "친구 이름을 검색해보세요"
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(#function)
        search(searchText: searchText)
    }
    
    // TODO: - 끊임없는 실시간 에러 메시지가..
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
