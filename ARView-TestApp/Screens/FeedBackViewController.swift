//
//  FeedBackViewController.swift
//  ARView-TestApp
//
//  Created by Ibragim Akaev on 19/05/2021.
//

import UIKit
import Cosmos

final class FeedBackViewController: UIViewController {
    
    private let ratingView = CosmosView()
    private let sendFeedbackButton = CustomButton(title: "Отправить отзыв", cornerRadius: 20)
    private let feedbackTextView: UITextView = {
        let textView = UITextView()
        textView.text            = "Ваш отзыв"
        textView.font            = UIFont.systemFont(ofSize: 20)
        textView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        sendFeedbackButton.addTarget(self, action: #selector(fedButtonTapped), for: .touchUpInside)
        
        view.addSubviews(feedbackTextView, ratingView, sendFeedbackButton)
        
        NSLayoutConstraint.activate([
            feedbackTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            feedbackTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            feedbackTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            feedbackTextView.heightAnchor.constraint(equalToConstant: 300),
            
            ratingView.topAnchor.constraint(equalTo: feedbackTextView.bottomAnchor, constant: 20),
            ratingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            sendFeedbackButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            sendFeedbackButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            sendFeedbackButton.heightAnchor.constraint(equalToConstant: 44),
            sendFeedbackButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
    
    @objc private func fedButtonTapped() {
        showAlert()
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Отзыв отправлен",
                                      message: "Спасибо за ваш отзыв",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true)
    }
}
