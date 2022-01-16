//
//  ViewController.swift
//  Resto
//
//  Created by Sumit Paul on 16/01/22.
//

import SnapKit
import UIKit

final class RestaurantsListViewController: UIViewController {
    private enum Section {
        case main
    }
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private let loadingView = UIActivityIndicatorView(style: .large)
    private let viewModel: RestaurantsListViewModel
    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, PointOfInterestInfo> = {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, PointOfInterestInfo> { cell, _, pointOfInterest in
            var content = cell.defaultContentConfiguration()
            content.text = pointOfInterest.poi.name
            content.textProperties.font = UIFont.preferredFont(forTextStyle: .headline)
            content.secondaryText = pointOfInterest.address.freeformAddress
            content.secondaryTextProperties.color = .secondaryLabel
            content.image = UIImage(systemName: "globe.asia.australia")
            cell.contentConfiguration = content

            var background = UIBackgroundConfiguration.listPlainCell()
            background.backgroundColor = .systemBackground
            cell.backgroundConfiguration = background
            cell.accessories = [.disclosureIndicator()]
            cell.tintColor = .systemTeal
        }

        return UICollectionViewDiffableDataSource<Section, PointOfInterestInfo>(collectionView: collectionView) { (collectionView, indexPath, pointOfInterest) -> UICollectionViewCell? in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: pointOfInterest)
        }
    }()

    init(viewModel: RestaurantsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .tertiarySystemGroupedBackground
        title = "Restaurants near me"
        setupView()
        setupBindings()
        viewModel.dispatch(event: .accessLocation)
    }

    private func setupView() {
        setupCollectionView()
        setupSlider()
        setupLoadingView()
    }

    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.top.bottom.equalToSuperview()
        }
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        config.backgroundColor = .tertiarySystemGroupedBackground
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout.list(using: config)
    }

    private func setupSlider() {
        let sliderContainerView = UIVisualEffectView(effect: UIBlurEffect(style: .prominent))
        sliderContainerView.layer.masksToBounds = true
        sliderContainerView.layer.cornerRadius = 16.0
        let radiusLabel = UILabel()
        radiusLabel.textColor = .darkGray
        radiusLabel.font = UIFont.preferredFont(forTextStyle: .headline)

        let sliderAction = UIAction(title: "") { action in
            if let slider = action.sender as? UISlider {
                let stepValue = self.viewModel.getStepValue(for: slider.value)
                radiusLabel.text = "Radius: \(self.viewModel.getStepValueinKM(for: stepValue))"
                slider.setValue(stepValue, animated: true)
                self.viewModel.dispatch(event: .sliderDidChange(value: stepValue))
            }
        }

        sliderContainerView.contentView.addSubview(radiusLabel)
        let slider = UISlider(frame: .zero, primaryAction: sliderAction)
        slider.minimumTrackTintColor = .systemTeal
        slider.isContinuous = false
        slider.minimumValue = viewModel.minimumStepValue
        slider.maximumValue = viewModel.maximumStepValue
        sliderContainerView.contentView.addSubview(slider)
        slider.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(8.0)
            make.height.equalTo(44)
        }
        radiusLabel.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview().inset(8.0)
            make.bottom.equalTo(slider.snp.top)
        }
        view.addSubview(sliderContainerView)
        sliderContainerView.snp.makeConstraints { make in
            make.leading.trailing.bottomMargin.equalTo(view.safeAreaLayoutGuide).inset(32)
        }
    }

    private func setupLoadingView() {
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        loadingView.isHidden = true
        loadingView.hidesWhenStopped = true
    }

    private func setupBindings() {
        viewModel.onAction = { [weak self] action in
            switch action {
            case let .applySnapshot(pointOfInterests):
                DispatchQueue.main.async {
                    if let locationName = pointOfInterests.first?.address.localName {
                        self?.title = "Restaurant · \(locationName)"
                    }
                    self?.applySnapshot(pointOfInterests: pointOfInterests)
                }
            case let .loading(value):
                DispatchQueue.main.async {
                    self?.loadingView.isHidden = !value
                    value == true ? self?.loadingView.startAnimating() : self?.loadingView.stopAnimating()
                }
            }
        }
    }

    private func applySnapshot(pointOfInterests: [PointOfInterestInfo], animatingDifferences: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, PointOfInterestInfo>()
        snapshot.appendSections([Section.main])
        snapshot.appendItems(pointOfInterests)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}
