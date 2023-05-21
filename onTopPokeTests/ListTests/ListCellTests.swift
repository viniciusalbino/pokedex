//
//  ListCellTests.swift
//  onTopPokeTests
//
//  Created by Vinicius Albino on 21/05/23.
//

import Foundation
import XCTest
@testable import onTopPoke
class ListCellTests: XCTestCase {
    
    var cell: ListCell!
    
    override func setUp() {
        super.setUp()
        cell = ListCell(style: .default, reuseIdentifier: ListCell.reuseIdentifier)
    }
    
    override func tearDown() {
        cell = nil
        super.tearDown()
    }
    
    func testInit_SetsUpCell() {
        XCTAssertEqual(cell.accessoryType, .disclosureIndicator)
        XCTAssertEqual(cell.backgroundColor, .clear)
        XCTAssertEqual(cell.iconContainer.backgroundColor, .lightGray)
        XCTAssertEqual(cell.iconContainer.layer.cornerRadius, 10)
        XCTAssertTrue(cell.iconContainer.clipsToBounds)
        XCTAssertEqual(cell.icon.contentMode, .scaleAspectFill)
        XCTAssertEqual(cell.icon.image, UIImage(named: "PlaceholderImage"))
        XCTAssertEqual(cell.titleLabel.font, UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .title3).pointSize, weight: .bold))
        XCTAssertEqual(cell.titleLabel.textColor, .black)
        XCTAssertEqual(cell.titleLabel.numberOfLines, 1)
    }
}
