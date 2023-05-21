import UIKit

/// Details view showing the evolution chain of a Pokémon (WIP)
///
/// It now only shows a placeholder image, make it so that it also shows the evolution chain of the selected Pokémon, in whatever way you think works best.
/// The evolution chain url can be fetched using the endpoint `APIRouter.getSpecies(URL)` (returns type `SpeciesDetails`), and the evolution chain details through `APIRouter.getEvolutionChain(URL)` (returns type `EvolutionChainDetails`).
/// Requires a working `RequestHandler`
///
class DetailsViewController: UIViewController {
    
    private lazy var viewModel: DetailsViewModel = DetailsViewModel(delegate: self)
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "PlaceholderImage")
        return imageView
    }()
    
    init(species: Species) {
        super.init(nibName: nil, bundle: nil)
        viewModel.currentSpecies = species
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = viewModel.currentSpecies?.name ?? ""
        
        setupViews()
        loadDetails()
    }
    
    private func setupViews() {
        // TODO Feel free to set up the screen any way you like
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func loadDetails() {
        guard let species = viewModel.currentSpecies else {
            return
        }
        ImageDownloader.shared.downloadImage(with: species.imageURL(), completionHandler: { image, cached in
            self.imageView.image = image
        }, placeholderImage: nil)
        viewModel.loadContent(specie: species)
    }
    
    private func setupEvolutionView(evolutionSpecies: Species) {
        let evolutionView = EvolutionView(frame: .zero)
        view.addSubview(evolutionView)
        evolutionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            evolutionView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 6),
            evolutionView.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
            evolutionView.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor)
        ])
        evolutionView.fill(name: evolutionSpecies.name, url: evolutionSpecies.imageURL() ?? "")
    }
}


extension DetailsViewController: DetailsViewModelDelegate {
    func finishedFetchingChain(evolutionSpecies: Species) {
        DispatchQueue.main.async {
            self.setupEvolutionView(evolutionSpecies: evolutionSpecies)
        }
    }
    
    func errorFetchingSpecies() {
        DispatchQueue.main.async { [self] in
            self.showErrorAlert()
        }
    }
}
