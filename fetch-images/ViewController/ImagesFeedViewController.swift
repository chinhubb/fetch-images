//
//  ImagesFeedViewController.swift
//  fetch-images
//
//  Created by Jirawat on 14/3/2564 BE.
//

import Foundation
import UIKit

enum LoadState {
    case loading
    case success
    case failed
}

class ImagesFeedViewController: UIViewController {
    static let identifier = "ImagesFeedViewController"
    @IBOutlet var titleLabel: UILabel!

    @IBOutlet var tableView: UITableView!
    private let refreshControl = UIRefreshControl()

    var listPhoto: [PhotoModel]? = []
    var pageInt: Int = 1
    var max: Int = 1
    var loadState: LoadState = .loading
    var isLoading = false

    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        getImages("1")
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
        getImages("1")
    }

    func preloading() {
        loadState = .loading
        listPhoto = []
        tableView.reloadData()
    }

    func getImages(_ page:String) {
        if pageInt == 1 {
            preloading()
        }
        let repo = PhotoRepository()
        repo.getPhotoPopularByPage(page).subscribe { event in
            switch event {
            case let .next(data):
                self.loadState = .success
                self.isLoading = false
                guard let list = data.photos else { return }
                if self.pageInt == 1 {
                    self.max = data.totalPage ?? 1
                    self.listPhoto = list
                    self.tableView.reloadData()
                    self.endRefresh()
                } else {
                    let last = self.listPhoto?.count ?? 0 - 1
                    self.listPhoto = self.listPhoto! + list
                    let indexPaths = Array(last ... (last + list.count - 1)).map { IndexPath(item: $0, section: 0) }
                    self.tableView.insertRows(at: indexPaths, with: .left)
//                            self.tableView.reloadData()
                }
            case let .error(err):
                self.endRefresh()
                self.isLoading = false
                self.loadState = .failed
                self.tableView.reloadData()
            case .completed:
                break
            }
        }
    }

//    func getImages() {
//        let repository = PhotoRepository()
//        repository.getPhotoPopular().subscribe { event in
//            switch event {
//            case let .next(data):
//                let list = data.photos
//                self.listPhoto = list
//                self.tableView.reloadData()
//            case let .error(error):
//                print(error)
//            case .completed:
//                print("completed")
//            }
//        }
//    }
}

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
        return 1
    }
}
