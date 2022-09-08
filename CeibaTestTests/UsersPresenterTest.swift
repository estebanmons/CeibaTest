//
//  UsersPresenterTest.swift
//  CeibaTestTests
//
//  Created by Esteban Monsalve on 8/09/22.
//

import XCTest
@testable import CeibaTest

class UsersPresenterTest: XCTestCase {
    
    var interactor: FakeUsersInteractorInterface!
    var presenter: UsersPresenter!
    var view: FakeUsersViewInterface!
    var wireframe: FakeUsersWireframe!
    
    private var expectation: XCTestExpectation!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        view = FakeUsersViewInterface()
        interactor = FakeUsersInteractorInterface()
        wireframe = FakeUsersWireframe()
        presenter = UsersPresenter(
            view: view,
            interactor: interactor,
            wireframe: wireframe
        )
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testViewDidLoad() {
        presenter.refreshData()
        XCTAssert(view.isReloadData)
    }
}

extension UsersPresenterTest {
    
    final class FakeUsersWireframe: UsersWireframeInterface {
        func goToPosts(user: UserModel) { }
        func initLoader() { }
        func endLoader() { }
    }
    
    final class FakeUsersInteractorInterface: UsersInteractorInterface {
        
        var coreDataManager: CoreDataManager { CoreDataManager.sharedInstance }
        
        func requestGetUsers(refreshData: Bool, completionHandler: @escaping (UsersResult) -> Void) {
            completionHandler(
                .success(
                    [
                        UserModel(email: Constants.emptyString, id: 0, name: Constants.emptyString, phone: Constants.emptyString)
                    ]
                )
            )
        }
    }
    
    final class FakeUsersViewInterface: UsersViewInterface {
        var isReloadData: Bool = false
        func reloadData() {
            isReloadData = true
        }
    }
}
