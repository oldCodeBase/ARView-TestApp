//
//  MainViewController.swift
//  ARView-TestApp
//
//  Created by Ibragim Akaev on 19/05/2021.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let tableView         = UITableView(frame: .zero, style: .insetGrouped)
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private var topStreams: [Top] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureNavBar()
        configureTableView()
        uploadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureViewController() {
        title                = "Twitch"
        view.backgroundColor = .systemBackground
    }
    
    private func configureNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "pencil.circle"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(feedbackTapped))
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame      = view.bounds
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.rowHeight  = 160
        tableView.register(GameCell.self, forCellReuseIdentifier: GameCell.reuseID)
    }
    
    private func showActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func uploadData() {
        showActivityIndicator()
        NetworkManager.shared.fetchGames { [weak self] stream in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.activityIndicator.removeFromSuperview()
                self.topStreams = stream.top
                self.tableView.reloadData()
            }
        }
    }
    
    @objc private func feedbackTapped() {
        let vc = FeedBackViewController()
        vc.title = "Отзыв о программе"
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource methods
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topStreams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GameCell.reuseID) as! GameCell
        let stream = topStreams[indexPath.row]
        cell.set(stream: stream)
        return cell
    }
}
