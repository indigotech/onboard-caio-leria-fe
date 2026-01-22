import Foundation
import Combine
import Moya
import RxSwift
import RxMoya

class UserDetailViewModel: ObservableObject {
    @Published var user: UserDetail?
    @Published var errorText: String = ""
    let disposeBag = DisposeBag()
    var provider = MoyaProvider<LoginService>()
    
    func showDetails(id: String) {
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
        let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
        provider.rx.request(LoginService.userDetails(id: id))
            .filterSuccessfulStatusCodes()
            .map(ResponseUserDetail.self, using: decoder)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] user in
                self?.user = user.data
            }, onFailure: { [weak self] error in
                if let moyaError = error as? MoyaError,let response = moyaError.response {
                    let errorResponse = try? response.map(DataErrors.self)
                    self?.errorText = errorResponse?.errors?.first?.message ?? "Erro desconhecido"
                }
            })
            .disposed(by: disposeBag)
    }
}
