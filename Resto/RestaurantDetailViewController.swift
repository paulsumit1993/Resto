
import UIKit

final class RestaurantDetailViewController: UIViewController {
    private let viewModel: RestaurantDetailViewModel
    private let mapImageView = UIImageView()
    private let rootStackView = UIStackView()

    init(viewModel: RestaurantDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupView()
        setupBindings()
    }

    private func setupView() {
        title = viewModel.navigationTitle
        view.backgroundColor = .tertiarySystemGroupedBackground
        rootStackView.axis = .vertical
        rootStackView.alignment = .center
        rootStackView.spacing = 16
        view.addSubview(rootStackView)
        rootStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }

        mapImageView.layer.masksToBounds = true
        mapImageView.layer.cornerRadius = 16.0
        mapImageView.contentMode = .scaleAspectFit
        mapImageView.isHidden = true
        rootStackView.addArrangedSubview(mapImageView)
        let address = UILabel()
        address.numberOfLines = 0
        address.textAlignment = .center
        address.font = UIFont.preferredFont(forTextStyle: .headline)
        address.text = viewModel.address
        address.isHidden = viewModel.address == nil
        rootStackView.addArrangedSubview(address)
        setupButtons()
    }

    private func setupButtons() {
        let buttonStackView = UIStackView()
        buttonStackView.spacing = 16
        let directionsButtonPrimaryAction = UIAction { _ in
            self.viewModel.dispatch(event: .getDirections)
        }
        let directionsButton = UIButton.init(type: .system, primaryAction: directionsButtonPrimaryAction)
        let config = UIImage.SymbolConfiguration(pointSize: 36, weight: .semibold, scale: .large)
        let mapPinImage = UIImage(systemName: "map.fill", withConfiguration: config)
        directionsButton.setImage(mapPinImage, for: .normal)
        buttonStackView.addArrangedSubview(directionsButton)

        let callButtonPrimaryAction = UIAction { _ in
            self.viewModel.dispatch(event: .call)
        }
        let callButton = UIButton.init(type: .system, primaryAction: callButtonPrimaryAction)
        let callImage = UIImage(systemName: "phone.circle.fill", withConfiguration: config)
        callButton.setImage(callImage, for: .normal)
        callButton.isHidden = viewModel.phoneNumber == nil
        buttonStackView.addArrangedSubview(callButton)

        rootStackView.addArrangedSubview(buttonStackView)
    }

    private func setupBindings() {
        viewModel.didUpdateMapSnapshot = { [weak self] image in
            self?.mapImageView.image = image
            self?.mapImageView.isHidden = false
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
