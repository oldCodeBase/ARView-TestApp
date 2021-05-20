//
//  MainViewController.swift
//  ARView-TestApp
//
//  Created by Ibragim Akaev on 19/05/2021.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let tableView         = UITableView(frame: .zero, style: .insetGrouped)
    private var topStreams: [Top] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureNavBar()
        configureTableView()
        uploadData()
    }
    
    private func configureViewController() {
        title                = "Twitch"
        view.backgroundColor = .systemBackground
    }
    
    private func configureNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "pencil.circle"),
            style: .plain,
            target: self,
            action: #selector(feedbackTapped)
        )
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame      = view.bounds
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.rowHeight  = 160
        tableView.register(GameCell.self, forCellReuseIdentifier: GameCell.reuseID)
    }
    
    private func uploadData() {
        NetworkManager.shared.fetchGames { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let stream):
                    self.topStreams = stream.top
                    StorageManager.save(stream: stream)
                    self.tableView.reloadData()
                case .failure:
                    self.showAlert()
                    StorageManager.retrieveData(completed: { stream in
                        self.topStreams = stream.top
                        self.tableView.reloadData()
                    })
                }
            }
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(
            title: "Отсутствует интернет",
            message: "Пожалуйста подключитесь к сети чтобы получить актуальные данные",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true)
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
