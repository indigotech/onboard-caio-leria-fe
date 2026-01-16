import Foundation
import Moya
import RxSwift
import RxMoya
import Combine

class UsersViewModel: ObservableObject{
    let disposeBag = DisposeBag()
    let provider = MoyaProvider<LoginService>()
    @Published var users: [User] = []
    
    func fetchUsers() {
        provider.rx.request(LoginService.fetchUser)
            .filterSuccessfulStatusCodes()
            .map(UserResponse.self)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { response in
                self.users = response.data.nodes
            }, onFailure: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
}
