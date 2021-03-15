//
//  ImagesFeedViewController.swift
//  fetch-images
//
//  Created by Jirawat on 14/3/2564 BE.
//

import Foundation
import UIKit

class ImagesFeedViewController: UIViewController {
    static let identifier = "ImagesFeedViewController"
    @IBOutlet var titleLabel: UILabel!

    @IBOutlet var tableView: UITableView!
    private let refreshControl = UIRefreshControl()

    var listPhoto: [PhotoModel]? = []

    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        getImages()
    }

    func initTableView() {
        tableView.register(ListImagesTableViewCell.nib, forCellReuseIdentifier: ListImagesTableViewCell.identifier)

        tableView.delegate = self
        tableView.dataSource = self

        refreshControl.addTarget(self, action: #selector(pullRefresh(sender:)), for: .valueChanged)
        tableView.alwaysBounceVertical = true
        tableView.refreshControl = refreshControl
    }

    func startRefresh() {
        if tableView.contentOffset.y == 0 {
            tableView.setContentOffset(CGPoint(x: 0, y: tableView.contentOffset.y - refreshControl.frame.size.height), animated: true)
        }

        refreshControl.beginRefreshing()
    }

    func endRefresh() {
        tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        refreshControl.endRefreshing()
    }

    @objc func pullRefresh(sender: Any) {
//        getImages(selectCatagory, selectType, "0")
    }

    func getImages(_ catagory: String, _ type: String, _ page: String) {
//        if self.page == 1 {
//            preloading()
//        }
//        let repo = FeedRepository()
//        repo.getFeed(catagory, type, page).bind().subscribe { event in
//            switch event.event {
//            case let .next(data):
//                self.loadState = .success
//                self.isLoading = false
//                guard let feed = data.data else { return }
//                if self.page == 1 {
//                    self.max = data.lastPage ?? 1
//                    self.feedList = feed
//                    self.collectionViewCard.reloadData()
//                    self.endRefresh()
//                } else {
//                    let last = self.feedList.count - 1
//                    self.feedList = self.feedList + feed
//                    let indexPaths = Array(last...(last+feed.count-1)).map { IndexPath(item: $0, section: 0) }
//                    self.collectionViewCard.insertItems(at: indexPaths)
        ////                    self.collectionViewCard.reloadData()
//                }
//            case let .error(err):
//                self.endRefresh()
//                self.isLoading = false
//                self.loadState = .failed
//                self.collectionViewCard.reloadData()
//                self.showAlert(ErrorMessage.getError(error: err))
//            case .completed:
//                break
//            }
//        }
    }

    func getImages() {
        let repository = PhotoRepository()
        repository.getPhotoPopular().subscribe { event in
            switch event {
            case let .next(data):
                let list = data.photos
                self.listPhoto = list
                self.tableView.reloadData()
            case let .error(error):
                print(error)
            case .completed:
                print("completed")
            }
        }
    }
}

// extension ImagesFeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return listPhoto?.count ?? 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailPictureCollectionViewCell.identifier, for: indexPath) as? DetailPictureCollectionViewCell else { return UICollectionViewCell() }
//        cell.setCell(listPhoto?[indexPath.row])
//
//
//        return cell
//    }
// }

extension ImagesFeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPhoto?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListImagesTableViewCell", for: indexPath) as? ListImagesTableViewCell else { return UITableViewCell() }
        cell.setCell(listPhoto?[indexPath.row])
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}
