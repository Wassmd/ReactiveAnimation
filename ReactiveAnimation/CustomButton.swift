import UIKit
import RxSwift
import RxCocoa

final class CustomButton: UIButton, Animatable {
    
    private let disposeBag = DisposeBag()
    
    private let aTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tap to feel Some Animation"
        return label
    }()
    
    private let aImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "year-of-tiger")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    init() {
        super.init(frame: .zero)
        
        setupView()
        setupSubView()
        setupConstraints()
        setupObserving()        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView() {
        backgroundColor = .darkGray
        layer.cornerRadius = 8
        clipsToBounds = true
        setTitleColor(.white, for: .normal)
    }
    
    private func setupSubView() {
        [aTitleLabel, aImageView].forEach(addSubview)
    }
    
    private func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            aImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            aImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            aImageView.heightAnchor.constraint(equalToConstant: 28),
            aImageView.widthAnchor.constraint(equalToConstant: 28),
            
            aTitleLabel.leadingAnchor.constraint(equalTo: aImageView.trailingAnchor, constant: 16),
            aTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            aTitleLabel.centerYAnchor.constraint(equalTo: aImageView.centerYAnchor)
            
            ])
    }
    
    private func setupObserving() {
        rx.controlEvent(.touchDown)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
        
                self.animate(view: self)
            })
            .disposed(by: disposeBag)
        
        let resetObservables = [rx.controlEvent(.touchCancel),
                                rx.controlEvent(.touchUpInside),
                                rx.controlEvent(.touchUpOutside)].map { $0.asObservable() }
        
        Observable.merge(resetObservables)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.resetToOriginalState(view: self)
            })
            .disposed(by: disposeBag)
    }
}
