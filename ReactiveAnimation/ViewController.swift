import UIKit

class ViewController: UIViewController {

    private let button = CustomButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSubviews()
        setupConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = .black
    }
    
    private func setupSubviews() {
        view.addSubview(button)
    }
    
    private func setupConstraints() {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            button.heightAnchor.constraint(equalToConstant: 70),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
    }
}

