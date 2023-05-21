//
//  DetailsControllerBuilder.swift
//  onTopPoke
//
//  Created by Vinicius Albino on 20/05/23.
//

import Foundation
import UIKit

final class DetailsControllerBuilder {
    func build(species: Species) -> DetailsViewController {
        let controller = DetailsViewController(species: species)
        return controller
    }
}
