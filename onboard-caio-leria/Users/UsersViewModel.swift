import Foundation
import Moya
import SwiftUI
import RxSwift
import RxMoya
import Combine

class UsersViewModel: ObservableObject {
    
    let disposeBag = DisposeBag()
    let provider = MoyaProvider<LoginService>()
    var loadNextPage = PublishSubject<Void>()
    var hasNextPage: Bool = true
    var offset: Int = 0
    var limit: Int = 20
    @Published var isfetching: Bool = false
    @Published var users: [User] = []
    
    init() {
        loadNextPage
            .filter {[weak self] in
                guard let self = self else {return false}
                return !self.isfetching && self.hasNextPage
            }
            .do(onNext: { [weak self] in
                self?.isfetching = true
            })
            .flatMap{ [weak self] _ -> Observable<UserResponse> in
                guard let self = self else {return .empty()}
                return self.provider.rx.request(LoginService.fetchUser(offset: self.offset, limit: self.limit ))
                    .filterSuccessfulStatusCodes()
                    .map(UserResponse.self)
                    .asObservable()
                    .catch { _ in
                            .empty()
                    }
            }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] response in
                guard let self = self else { return }
                self.users.append(contentsOf: response.data.nodes)
                self.offset += self.limit
                self.isfetching = false
                self.hasNextPage = response.data.pageInfo.hasNextPage
                
            }).disposed(by: disposeBag)
    }
    
    func fetchUsers() {
        loadNextPage.onNext(())
    }
    
    func logout() {
        
    }
    
}

