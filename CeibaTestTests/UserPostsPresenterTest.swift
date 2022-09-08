//
//  UserPostsPresenter.swift
//  CeibaTestTests
//
//  Created by Esteban Monsalve on 8/09/22.
//

import XCTest
@testable import CeibaTest

class UserPostsPresenterTest: XCTestCase {
    
    var interactor: FakeUserPostsInteractorInterface!
    var presenter: UserPostsPresenter!
    var view: FakeUserPostsViewInterface!
    var wireframe: FakeUserPostsWireframe!
    
    private var expectation: XCTestExpectation!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        view = FakeUserPostsViewInterface()
        interactor = FakeUserPostsInteractorInterface()
        wireframe = FakeUserPostsWireframe()
        presenter = UserPostsPresenter(
            view: view,
            interactor: interactor,
            wireframe: wireframe,
            user: UserModel(email: Constants.emptyString, id: 0, name: Constants.emptyString, phone: Constants.emptyString)
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
        presenter.viewDidLoad()
        XCTAssert(view.isReloadData)
    }
    
    func testSearchUsers() {
        presenter.viewDidLoad()
        XCTAssert(view.isReloadData)
    }
}

extension UserPostsPresenterTest {
    
    final class FakeUserPostsWireframe: UserPostsWireframeInterface {
        func initLoader() { }
        func endLoader() { }
    }
    
    final class FakeUserPostsInteractorInterface: UserPostsInteractorInterface {
        func getPosts(by userId: Int, completionHandler: @escaping (PostsResult) -> Void) {
            completionHandler(.success([Post(body: Constants.emptyString, id: 0, title: Constants.emptyString, userId: 0)]))
        }
        
    }
    
    final class FakeUserPostsViewInterface: UserPostsViewInterface {
        var isReloadData: Bool = false
        func setUserData(user: UserModel) { }
        func reloadData() {
            isReloadData = true
        }
    }
}
