//
//  ApiManager.swift
//  PartyWorld
//
//  Created by Rajesh gurjar on 21/06/22.
//

import SwiftUI
import Alamofire

public class APIManager {
    
    static var shared = APIManager()
    
    func signUpApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
        
        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200..<600).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        print("Error: Cannot convert data to JSON object")
                        return
                    }
                    let SignUpModel = try JSONDecoder().decode(SignUpModel.self, from: response.data!)
                    print(jsonObject)
                    completion(SignUpModel)
                    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func socialLoginApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
        
        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200..<600).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        print("Error: Cannot convert data to JSON object")
                        return
                    }
//                    let SignUpModel = try JSONDecoder().decode(SignUpModel.self, from: response.data!)
                    print(jsonObject)
                    completion(jsonObject)
                    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func sendOTPApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
        
        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200..<600).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        print("Error: Cannot convert data to JSON object")
                        return
                    }
                    let SignUpModel = try JSONDecoder().decode(ForgotPasswordModel.self, from: response.data!)
                    print(jsonObject)
                    completion(SignUpModel)
                    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func verifyOTPApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
        
        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200..<600).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        print("Error: Cannot convert data to JSON object")
                        return
                    }
                    let SignUpModel = try JSONDecoder().decode(VerificationModel.self, from: response.data!)
                    print(jsonObject)
                    completion(SignUpModel)
                    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func resendOtpApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
        
        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200..<600).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        print("Error: Cannot convert data to JSON object")
                        return
                    }
                    print(jsonObject)
                    completion(jsonObject)
                    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
    }
//
    func loginRequestApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
        
        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200..<600).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        print("Error: Cannot convert data to JSON object")
                        return
                    }
                    let loginModel = try JSONDecoder().decode(LoginModel.self, from: response.data!)
                    print(jsonObject)
                    completion(loginModel)
                    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
    }
//    
    func resetPasswordApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
        
        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200..<600).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let loginModel = try JSONDecoder().decode(ResetPasswordtModel.self, from: response.data!)
                    print(loginModel)
                    completion(loginModel)
                    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
    }
//    
    func searchListDataApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
        
        let header : HTTPHeaders = [
            "Authorization": "Bearer " + token,
            "Content-Type": "application/json"]
        
        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
            switch response.result {
            case .success(_):
                do {
                    let loginModel = try JSONDecoder().decode(SearchListModel.self, from: response.data!)
//                    print(jsonObject)
                    completion(loginModel)
                    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func shiftDetailDataApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
        
        let header : HTTPHeaders = [
            "Authorization": "Bearer " + token,
            "Content-Type": "application/json"]
        
        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
            switch response.result {
            case .success(_):
                do {
                    let loginModel = try JSONDecoder().decode(ShiftDetiailModel.self, from: response.data!)
//                    print(jsonObject)
                    completion(loginModel)
                    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func applyJobRequestApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
        
        let header : HTTPHeaders = [
            "Authorization": "Bearer " + token,
            "Content-Type": "application/json"]
        
        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        print("Error: Cannot convert data to JSON object")
                        return
                    }
                    print(jsonObject)
                    completion(jsonObject)
                    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func cancelJobRequestApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
        
        let header : HTTPHeaders = [
            "Authorization": "Bearer " + token,
            "Content-Type": "application/json"]
        
        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        print("Error: Cannot convert data to JSON object")
                        return
                    }
                    print(jsonObject)
                    completion(jsonObject)
                    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func myRquestListDataApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
        
        let header : HTTPHeaders = [
            "Authorization": "Bearer " + token,
            "Content-Type": "application/json"]
        
        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let loginModel = try JSONDecoder().decode(MyRequestModel.self, from: response.data!)
//                    print(jsonObject)
                    completion(loginModel)
                    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func dreamBarDataApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
        
        let header : HTTPHeaders = [
            "Authorization": "Bearer " + token,
            "Content-Type": "application/json"]
        
        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
            switch response.result {
            case .success(_):
                do {
                    let loginModel = try JSONDecoder().decode(DreamBarModel.self, from: response.data!)
                    print(loginModel)
                    completion(loginModel)
                    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func barDetailDataApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
        
        let header : HTTPHeaders = [
            "Authorization": "Bearer " + token,
            "Content-Type": "application/json"]
        
        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
            switch response.result {
            case .success(_):
                do {
                    let loginModel = try JSONDecoder().decode(BarDetailModel.self, from: response.data!)
                    print(loginModel)
                    completion(loginModel)
                    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func logOutApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
        
        let header : HTTPHeaders = [
            "Authorization": "Bearer " + token,
            "Content-Type": "application/json"]
        
        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        print("Error: Cannot convert data to JSON object")
                        return
                    }
                    print(jsonObject)
                    completion(jsonObject)
                    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func deleteAccountApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
        
        let header : HTTPHeaders = [
            "Authorization": "Bearer " + token,
            "Content-Type": "application/json"]
        
        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        print("Error: Cannot convert data to JSON object")
                        return
                    }
                    print(jsonObject)
                    completion(jsonObject)
                    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func termsConditionApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
        
//        let header : HTTPHeaders = [
//            "Authorization": "Bearer " + token,
//            "Content-Type": "application/json"]
        
        AF.request(URL(string: baseUrl)!,method: .get,parameters: parameter,encoding: URLEncoding.default,headers: nil).response { (response) in
            switch response.result {
            case .success(let data):
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data!) as? [String: Any] else {
                        print("Error: Cannot convert data to JSON object")
                        return
                    }
                    print(jsonObject)
                    completion(jsonObject)
                    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func privacyPolicyApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
        
//        let header : HTTPHeaders = [
//            "Authorization": "Bearer " + token,
//            "Content-Type": "application/json"]
        
        AF.request(URL(string: baseUrl)!,method: .get,parameters: parameter,encoding: URLEncoding.default,headers: nil).response { (response) in

            switch response.result {
            case .success(let data):
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data!) as? [String: Any] else {
                        print("Error: Cannot convert data to JSON object")
                        return
                    }
                    print(jsonObject)
                    completion(jsonObject)
                    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func profileVisibilityApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
        
        let header : HTTPHeaders = [
            "Authorization": "Bearer " + token,
            "Content-Type": "application/json"]
        
        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        print("Error: Cannot convert data to JSON object")
                        return
                    }
                    print(jsonObject)
                    completion(jsonObject)
                    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func notificationPreferenceApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
        
        let header : HTTPHeaders = [
            "Authorization": "Bearer " + token,
            "Content-Type": "application/json"]
        
        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        print("Error: Cannot convert data to JSON object")
                        return
                    }
                    print(jsonObject)
                    completion(jsonObject)
                    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getSkillsApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
        
//        let header : HTTPHeaders = [
//            "Authorization": "Bearer " + token,
//            "Content-Type": "application/json"]
        
        AF.request(URL(string: baseUrl)!,method: .get,parameters: parameter,encoding: URLEncoding.default,headers: nil).response { (response) in

            switch response.result {
            case .success(_):
                do {
                    let loginModel = try JSONDecoder().decode(SkillsModel.self, from: response.data!)
                    print(loginModel)
                    completion(loginModel)
                    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getLanguagesApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
        
//        let header : HTTPHeaders = [
//            "Authorization": "Bearer " + token,
//            "Content-Type": "application/json"]
        
        AF.request(URL(string: baseUrl)!,method: .get,parameters: parameter,encoding: URLEncoding.default,headers: nil).response { (response) in

            switch response.result {
            case .success(_):
                do {
                    let loginModel = try JSONDecoder().decode(LanguageModel.self, from: response.data!)
                    print(loginModel)
                    completion(loginModel)
                    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getProfileApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
        
        let header : HTTPHeaders = [
            "Authorization": "Bearer " + token,
            "Content-Type": "application/json"]
        
        AF.request(URL(string: baseUrl)!,method: .get,parameters: parameter,encoding: URLEncoding.default,headers: header).response { (response) in

            switch response.result {
            case .success(_):
                do {
                    let loginModel = try JSONDecoder().decode(ProfileModel.self, from: response.data!)
                    print(loginModel)
                    completion(loginModel)
                    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func updateLanguageApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
        
        let header : HTTPHeaders = [
            "Authorization": "Bearer " + token,
            "Content-Type": "application/json"]
        
        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        print("Error: Cannot convert data to JSON object")
                        return
                    }
                    print(jsonObject)
                    completion(jsonObject)
                    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func updateExperienceApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
        
        let header : HTTPHeaders = [
            "Authorization": "Bearer " + token,
            "Content-Type": "application/json"]
        
        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        print("Error: Cannot convert data to JSON object")
                        return
                    }
                    print(jsonObject)
                    completion(jsonObject)
                    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func updateSkillsApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
        
        let header : HTTPHeaders = [
            "Authorization": "Bearer " + token,
            "Content-Type": "application/json"]
        
        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        print("Error: Cannot convert data to JSON object")
                        return
                    }
                    print(jsonObject)
                    completion(jsonObject)
                    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
    }
//    
    func uploadImageDataWithToken(inputUrl:String,parameters:[String:Any],imageName: String,imageFile : UIImage,coverimageName: String, coverimageFile: UIImage,completion:@escaping(_:Any)->Void) {
        let token = Config().AppUserDefaults.string(forKey: "UserToken") ?? ""
        let header : HTTPHeaders = [
            "Authorization": "Bearer " + token,
            "Content-Type": "application/json"]
        let imageData = imageFile.jpegData(compressionQuality: 0.5)
        let coverImgData = coverimageFile.jpegData(compressionQuality: 0.5)
        AF.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(imageData!, withName: imageName, fileName: "image.png", mimeType: "image/jpeg")
            multipartFormData.append(coverImgData!, withName: coverimageName, fileName: "cover_image.png", mimeType: "image/jpeg")
            for key in parameters.keys{
                let name = String(key)
                if let val = parameters[name] as? String{
                    multipartFormData.append(val.data(using: .utf8)!, withName: name)
                }else{
                    multipartFormData.append("\(String(parameters[name] as? Int ?? 0))".data(using: .utf8)!, withName: name)
                }
            }
        },to: URL.init(string: inputUrl)!, usingThreshold: UInt64.init(),
                  method: .post,
                  headers: header)
            .uploadProgress(queue: .main, closure: { progress in
                //Current upload progress of file
                print("Upload Progress: \(progress.fractionCompleted)")
            }).validate(statusCode: 200..<600)
            .responseData(completionHandler: { data in
                switch data.result {
                case .success(let value):
                    do {
                        print("Value is : \(value)")
                        let dictionary = try JSONDecoder().decode(UpdateProfileModel.self, from: data.data!)
                        print("Success!")
                        completion(dictionary)
                        print(dictionary)
                    }
                    catch {
                        // catch error.
                        Loader.stop()
                        print("catch error")
                    }
                    break
                case .failure(_):
                    print("failure")
                    break
                }
            })
    }
    //MARK: - Barowner API's
    
    func searchBarListDataApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
        
        let header : HTTPHeaders = [
            "Authorization": "Bearer " + token,
            "Content-Type": "application/json"]
        
        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
            switch response.result {
            case .success(_):
                do {
                    let loginModel = try JSONDecoder().decode(BarSearchModel.self, from: response.data!)
//                    print(jsonObject)
                    completion(loginModel)
                    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func barShiftDetailApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
        
        let header : HTTPHeaders = [
            "Authorization": "Bearer " + token,
            "Content-Type": "application/json"]
        
        AF.request(URL(string: baseUrl)!,method: .post,parameters: parameter,encoding: URLEncoding.default,headers: header).response { (response) in

            switch response.result {
            case .success(_):
                do {
                    let loginModel = try JSONDecoder().decode(BarProfileModel.self, from: response.data!)
                    print(loginModel)
                    completion(loginModel)
                    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func myShiftsListApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
        
        let header : HTTPHeaders = [
            "Authorization": "Bearer " + token,
            "Content-Type": "application/json"]
        
        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
            switch response.result {
            case .success(_):
                do {
                    let loginModel = try JSONDecoder().decode(MyShiftsModel.self, from: response.data!)
                    print(loginModel)
                    completion(loginModel)
                    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func updatePostJobApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
        
        let header : HTTPHeaders = [
            "Authorization": "Bearer " + token,
            "Content-Type": "application/json"]
        
        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        print("Error: Cannot convert data to JSON object")
                        return
                    }
                    print(jsonObject)
                    completion(jsonObject)
                    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func postDetailDataApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
        
        let header : HTTPHeaders = [
            "Authorization": "Bearer " + token,
            "Content-Type": "application/json"]
        
        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
            switch response.result {
            case .success(_):
                do {
                    let loginModel = try JSONDecoder().decode(PostDetailModel.self, from: response.data!)
//                    print(jsonObject)
                    completion(loginModel)
                    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func acceptDeclineJobRequestApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
        
        let header : HTTPHeaders = [
            "Authorization": "Bearer " + token,
            "Content-Type": "application/json"]
        
        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        print("Error: Cannot convert data to JSON object")
                        return
                    }
                    print(jsonObject)
                    completion(jsonObject)
                    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getBarOwnerProfileApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
        
        let header : HTTPHeaders = [
            "Authorization": "Bearer " + token,
            "Content-Type": "application/json"]
        
        AF.request(URL(string: baseUrl)!,method: .get,parameters: parameter,encoding: URLEncoding.default,headers: header).response { (response) in

            switch response.result {
            case .success(_):
                do {
                    let loginModel = try JSONDecoder().decode(BarUserProfileModel.self, from: response.data!)
                    print(loginModel)
                    completion(loginModel)
                    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func barUploadImageDataWithToken(inputUrl:String,parameters:[String:Any],imageName: String,imageFile : UIImage,coverimageName: String, coverimageFile: UIImage,completion:@escaping(_:Any)->Void) {
        let token = Config().AppUserDefaults.string(forKey: "UserToken") ?? ""
        let header : HTTPHeaders = [
            "Authorization": "Bearer " + token,
            "Content-Type": "application/json"]
        let imageData = imageFile.jpegData(compressionQuality: 0.5)
        let coverImgData = coverimageFile.jpegData(compressionQuality: 0.5)
        AF.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(imageData!, withName: imageName, fileName: "image.png", mimeType: "image/jpeg")
            multipartFormData.append(coverImgData!, withName: coverimageName, fileName: "cover_image.png", mimeType: "image/jpeg")
            for key in parameters.keys{
                let name = String(key)
                if let val = parameters[name] as? String{
                    multipartFormData.append(val.data(using: .utf8)!, withName: name)
                }else{
                    multipartFormData.append("\(String(parameters[name] as? Int ?? 0))".data(using: .utf8)!, withName: name)
                }
            }
        },to: URL.init(string: inputUrl)!, usingThreshold: UInt64.init(),
                  method: .post,
                  headers: header)
            .uploadProgress(queue: .main, closure: { progress in
                //Current upload progress of file
                print("Upload Progress: \(progress.fractionCompleted)")
            }).validate(statusCode: 200..<600)
            .responseData(completionHandler: { data in
                switch data.result {
                case .success(let value):
                    do {
                        print("Value is : \(value)")
                        let dictionary = try JSONDecoder().decode(BarUpdateProfileModel.self, from: data.data!)
                        print("Success!")
                        completion(dictionary)
                        print(dictionary)
                    }
                    catch {
                        // catch error.
                        Loader.stop()
                        print("catch error")
                    }
                    break
                case .failure(_):
                    print("failure")
                    break
                }
            })
    }
//    func uploadImagePdfApi(inputUrl:String,parameters:[String:Any],imageName: String,isImage:Bool,imageFile : UIImage,pdfName:String,pdfFile:URL, completion:@escaping(_:Any)->Void) {
//        let token = UserDefaults.standard.value(forKey: "token") as? String ?? ""
//        let header : HTTPHeaders = [
//            "Authorization": "Bearer " + token,
//            "Content-Type": "multipart/form-data"]
////        ApiClass.TokenDict = ["Authorization": token]
//          let imageData = imageFile.jpegData(compressionQuality: 0.5)
//          AF.upload(multipartFormData: { (multipartFormData) in
//            if isImage == true{
//              multipartFormData.append(imageData!, withName: imageName, fileName: "image.png", mimeType: "image/jpeg")
//              for key in parameters.keys{
//                let name = String(key)
//                if let val = parameters[name] as? String{
//                  multipartFormData.append(val.data(using: .utf8)!, withName: name)
//                }
//              }
//            }else {
//              multipartFormData.append(pdfFile, withName: pdfName, fileName: "pdf", mimeType: "application/pdf")
//              for key in parameters.keys{
//                let name = String(key)
//                if let val = parameters[name] as? String{
//                  multipartFormData.append(val.data(using: .utf8)!, withName: name)
//                }
//              }
//            }
//          }, to:inputUrl,headers: header)
//          { (result) in
//            switch result {
//            case .success(let upload, _, _):
//              upload.uploadProgress(closure: { (Progress) in
//              })
//              upload.responseJSON { response in
//                print(response.request)
//                if let JSON = response.result.value {
//                  completion(JSON)
//                  //              LoadingOverlay.shared.hideOverlayView()
//                }else{
//                  print(response.request)
//                  print("jhflsdhfjlk")
//                  //              LoadingOverlay.shared.hideOverlayView()
//                  //              completion(response)
//                }
//              }
//            case .failure(let encodingError):
//              print("jhflsdhfjlk")
//              completion(encodingError)
//              //          LoadingOverlay.shared.hideOverlayView()
//            }
//          }
//        }
//    
//    func getMyAddressListApi(baseUrl:String,token:String,completion:@escaping(_:Any)->Void){
//        
//        let header : HTTPHeaders = [
//            "Authorization": "Bearer " + token,
//            "Content-Type": "application/json"]
//        
//        AF.request(URL(string: baseUrl)!, method: .get, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
//            switch response.result {
//            case .success( _):
//                do {
////                    let userData = try JSONDecoder().decode(MyAddressModel.self, from: response.data!)
//                    completion(userData)
//                    print(userData)
//                } catch let error as NSError {
//                    print("Failed to load: \(error.localizedDescription)")
//                    
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//    
//    func dashBoardApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
//        
//        let header : HTTPHeaders = [
//            "Authorization": "Bearer " + token,
//            "Content-Type": "application/json"]
//        
//        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
//            switch response.result {
//            case .success(let data):
//                do {
//                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                        print("Error: Cannot convert data to JSON object")
//                        return
//                    }
////                    let loginModel = try JSONDecoder().decode(HomeModel.self, from: response.data!)
//                    print(jsonObject)
//                    completion(loginModel)
//                } catch {
//                    print("Error: Trying to convert JSON data to string")
//                    return
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//    
//    func vendorListApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
//        
//        let header : HTTPHeaders = [
//            "Authorization": "Bearer " + token,
//            "Content-Type": "application/json"]
//        
//        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
//            switch response.result {
//            case .success(let data):
//                do {
//                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                        print("Error: Cannot convert data to JSON object")
//                        return
//                    }
////                    let loginModel = try JSONDecoder().decode(VendorListModel.self, from: response.data!)
//                    print(jsonObject)
//                    completion(loginModel)
//                } catch {
//                    print("Error: Trying to convert JSON data to string")
////                    completion(data)
//                    return
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//    
//    func vendorDetailApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
//        
//        let header : HTTPHeaders = [
//            "Authorization": "Bearer " + token,
//            "Content-Type": "application/json"]
//        
//        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
//            switch response.result {
//            case .success(let data):
//                do {
//                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                        print("Error: Cannot convert data to JSON object")
//                        return
//                    }
////                    let loginModel = try JSONDecoder().decode(VendorAboutModel.self, from: response.data!)
//                    print(jsonObject)
//                    completion(loginModel)
//                } catch {
//                    print("Error: Trying to convert JSON data to string")
////                    completion(data)
//                    return
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//    
//    func vendorProductApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
//        
//        let header : HTTPHeaders = [
//            "Authorization": "Bearer " + token,
//            "Content-Type": "application/json"]
//        
//        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
//            switch response.result {
//            case .success(let data):
//                do {
//                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                        print("Error: Cannot convert data to JSON object")
//                        return
//                    }
////                    let loginModel = try JSONDecoder().decode(VendorProductModel.self, from: response.data!)
//                    print(jsonObject)
//                    completion(loginModel)
//                } catch {
//                    print("Error: Trying to convert JSON data to string")
////                    completion(data)
//                    return
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//    
//    func vendorGalleryApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
//        
//        let header : HTTPHeaders = [
//            "Authorization": "Bearer " + token,
//            "Content-Type": "application/json"]
//        
//        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
//            switch response.result {
//            case .success(let data):
//                do {
//                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                        print("Error: Cannot convert data to JSON object")
//                        return
//                    }
////                    let loginModel = try JSONDecoder().decode(VendorGalleryModel.self, from: response.data!)
//                    print(jsonObject)
//                    completion(loginModel)
//                } catch {
//                    print("Error: Trying to convert JSON data to string")
////                    completion(data)
//                    return
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//    
//    func productDetailsApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
//        
//        let header : HTTPHeaders = [
//            "Authorization": "Bearer " + token,
//            "Content-Type": "application/json"]
//        
//        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
//            switch response.result {
//            case .success(let data):
//                do {
//                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                        print("Error: Cannot convert data to JSON object")
//                        return
//                    }
////                    let loginModel = try JSONDecoder().decode(ProductDetailModel.self, from: response.data!)
//                    print(jsonObject)
//                    completion(loginModel)
//                } catch {
//                    print("Error: Trying to convert JSON data to string")
////                    completion(data)
//                    return
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//    
//    func productInfoApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
//        
//        let header : HTTPHeaders = [
//            "Authorization": "Bearer " + token,
//            "Content-Type": "application/json"]
//        
//        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
//            switch response.result {
//            case .success(let data):
//                do {
//                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                        print("Error: Cannot convert data to JSON object")
//                        return
//                    }
////                    let loginModel = try JSONDecoder().decode(ProductInfoModel.self, from: response.data!)
//                    print(jsonObject)
//                    completion(loginModel)
//                } catch {
//                    print("Error: Trying to convert JSON data to string")
////                    completion(data)
//                    return
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//    
//    func saveRemoveProductApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
//        
//        let header : HTTPHeaders = [
//            "Authorization": "Bearer " + token,
//            "Content-Type": "application/json"]
//        
//        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
//            switch response.result {
//            case .success(let data):
//                do {
//                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                        print("Error: Cannot convert data to JSON object")
//                        return
//                    }
////                    let loginModel = try JSONDecoder().decode(ProductInfoModel.self, from: response.data!)
//                    print(jsonObject)
//                    completion(jsonObject)
//                } catch {
//                    print("Error: Trying to convert JSON data to string")
////                    completion(data)
//                    return
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//    
//    func shippingMethodListApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
//        
//        let header : HTTPHeaders = [
//            "Authorization": "Bearer " + token,
//            "Content-Type": "application/json"]
//        
//        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
//            switch response.result {
//            case .success(let data):
//                do {
//                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                        print("Error: Cannot convert data to JSON object")
//                        return
//                    }
////                    let loginModel = try JSONDecoder().decode(ShippingMethodModel.self, from: response.data!)
//                    print(jsonObject)
//                    completion(loginModel)
//                } catch {
//                    print("Error: Trying to convert JSON data to string")
////                    completion(data)
//                    return
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//        
//    func saveOrderDataApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
//        
//        let header : HTTPHeaders = [
//            "Authorization": "Bearer " + token,
//            "Content-Type": "application/json"]
//        
//        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
//            switch response.result {
//            case .success(let data):
//                do {
//                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                        print("Error: Cannot convert data to JSON object")
//                        return
//                    }
//                    print(jsonObject)
//                    completion(jsonObject)
//                    
//                } catch {
//                    print("Error: Trying to convert JSON data to string")
//                    return
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//    
//    func getOrderDataApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
//        
//        let header : HTTPHeaders = [
//            "Authorization": "Bearer " + token,
//            "Content-Type": "application/json"]
//        
//        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
//            switch response.result {
//            case .success(let data):
//                do {
//                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                        print("Error: Cannot convert data to JSON object")
//                        return
//                    }
////                    let loginModel = try JSONDecoder().decode(ConfirmBookingModel.self, from: response.data!)
//                    print(jsonObject)
//                    completion(loginModel)
//                } catch {
//                    print("Error: Trying to convert JSON data to string")
////                    completion(data)
//                    return
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//    
//    func confirmOrderAPI(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
//        
//        let header : HTTPHeaders = [
//            "Authorization": "Bearer " + token,
//            "Content-Type": "application/json"]
//        
//        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
//            switch response.result {
//            case .success(let data):
//                do {
//                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                        print("Error: Cannot convert data to JSON object")
//                        return
//                    }
////                    let loginModel = try JSONDecoder().decode(ConfirmBookingModel.self, from: response.data!)
//                    print(jsonObject)
//                    completion(jsonObject)
//                } catch {
//                    print("Error: Trying to convert JSON data to string")
////                    completion(data)
//                    return
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//    
//    func deleteOrderAPI(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
//        
//        let header : HTTPHeaders = [
//            "Authorization": "Bearer " + token,
//            "Content-Type": "application/json"]
//        
//        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
//            switch response.result {
//            case .success(let data):
//                do {
//                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                        print("Error: Cannot convert data to JSON object")
//                        return
//                    }
////                    let loginModel = try JSONDecoder().decode(ConfirmBookingModel.self, from: response.data!)
//                    print(jsonObject)
//                    completion(jsonObject)
//                } catch {
//                    print("Error: Trying to convert JSON data to string")
////                    completion(data)
//                    return
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//    
//    func myOrderDataAPI(baseUrl:String, parameter:[String:Any],token:String,type:Int,completion:@escaping(_:Any)->Void){
//        
//        let header : HTTPHeaders = [
//            "Authorization": "Bearer " + token,
//            "Content-Type": "application/json"]
//        
//        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
//            switch response.result {
//            case .success(let data):
//                do {
//                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                        print("Error: Cannot convert data to JSON object")
//                        return
//                    }
//                    if type == 1{
////                        let loginModel = try JSONDecoder().decode(UpcomingOrderDataModel.self, from: response.data!)
//                        print(jsonObject)
//                        completion(loginModel)
//                    }else if type == 2 {
////                        let loginModel = try JSONDecoder().decode(DeliveredOrderDataModel.self, from: response.data!)
//                        print(jsonObject)
//                        completion(loginModel)
//                    }else{
////                        let loginModel = try JSONDecoder().decode(CanceledOrderDataModel.self, from: response.data!)
//                        print(jsonObject)
//                        completion(loginModel)
//                    }
//                    
//                } catch {
//                    print("Error: Trying to convert JSON data to string")
////                    completion(data)
//                    return
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//    
//    func upcomingDetailsDataAPI(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
//        
//        let header : HTTPHeaders = [
//            "Authorization": "Bearer " + token,
//            "Content-Type": "application/json"]
//        
//        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
//            switch response.result {
//            case .success(let data):
//                do {
//                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                        print("Error: Cannot convert data to JSON object")
//                        return
//                    }
////                    let loginModel = try JSONDecoder().decode(UpcomingDetailsModel.self, from: response.data!)
//                    print(jsonObject)
//                    completion(loginModel)
//                } catch {
//                    print("Error: Trying to convert JSON data to string")
////                    completion(data)
//                    return
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//    
//    func deliveredDetailsDataAPI(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
//        
//        let header : HTTPHeaders = [
//            "Authorization": "Bearer " + token,
//            "Content-Type": "application/json"]
//        
//        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
//            switch response.result {
//            case .success(let data):
//                do {
//                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                        print("Error: Cannot convert data to JSON object")
//                        return
//                    }
////                    let loginModel = try JSONDecoder().decode(DeliveredDetailModel.self, from: response.data!)
//                    print(jsonObject)
//                    completion(loginModel)
//                } catch {
//                    print("Error: Trying to convert JSON data to string")
////                    completion(data)
//                    return
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//    
//    func canceledDetailsDataAPI(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
//        
//        let header : HTTPHeaders = [
//            "Authorization": "Bearer " + token,
//            "Content-Type": "application/json"]
//        
//        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
//            switch response.result {
//            case .success(let data):
//                do {
//                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                        print("Error: Cannot convert data to JSON object")
//                        return
//                    }
////                    let loginModel = try JSONDecoder().decode(CanceledDetailModel.self, from: response.data!)
//                    print(jsonObject)
//                    completion(loginModel)
//                } catch {
//                    print("Error: Trying to convert JSON data to string")
////                    completion(data)
//                    return
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//    
//    func canceledReasonDataAPI(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
//        
//        let header : HTTPHeaders = [
//            "Authorization": "Bearer " + token,
//            "Content-Type": "application/json"]
//        
//        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
//            switch response.result {
//            case .success(let data):
//                do {
//                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                        print("Error: Cannot convert data to JSON object")
//                        return
//                    }
////                    let loginModel = try JSONDecoder().decode(CancelPopUpModel.self, from: response.data!)
//                    print(jsonObject)
//                    completion(loginModel)
//                } catch {
//                    print("Error: Trying to convert JSON data to string")
////                    completion(data)
//                    return
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//    
//    func cancelOrderAPI(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
//        
//        let header : HTTPHeaders = [
//            "Authorization": "Bearer " + token,
//            "Content-Type": "application/json"]
//        
//        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
//            switch response.result {
//            case .success(let data):
//                do {
//                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                        print("Error: Cannot convert data to JSON object")
//                        return
//                    }
////                    let loginModel = try JSONDecoder().decode(ConfirmBookingModel.self, from: response.data!)
//                    print(jsonObject)
//                    completion(jsonObject)
//                } catch {
//                    print("Error: Trying to convert JSON data to string")
////                    completion(data)
//                    return
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//    
//    func offerCouponListApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
//        
//        let header : HTTPHeaders = [
//            "Authorization": "Bearer " + token,
//            "Content-Type": "application/json"]
//        
//        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
//            switch response.result {
//            case .success(let data):
//                do {
//                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                        print("Error: Cannot convert data to JSON object")
//                        return
//                    }
////                    let loginModel = try JSONDecoder().decode(OfferCouponModel.self, from: response.data!)
//                    print(jsonObject)
//                    completion(loginModel)
//                } catch {
//                    print("Error: Trying to convert JSON data to string")
////                    completion(data)
//                    return
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//    
//    func favoriteProductListApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
//        
//        let header : HTTPHeaders = [
//            "Authorization": "Bearer " + token,
//            "Content-Type": "application/json"]
//        
//        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
//            switch response.result {
//            case .success(let data):
//                do {
//                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                        print("Error: Cannot convert data to JSON object")
//                        return
//                    }
//                    let loginModel = try JSONDecoder().decode(FavoriteModel.self, from: response.data!)
//                    print(jsonObject)
//                    completion(loginModel)
//                } catch {
//                    print("Error: Trying to convert JSON data to string")
////                    completion(data)
//                    return
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//    
//    func orderIdListApi(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
//        
//        let header : HTTPHeaders = [
//            "Authorization": "Bearer " + token,
//            "Content-Type": "application/json"]
//        
//        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
//            switch response.result {
//            case .success(let data):
//                do {
//                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                        print("Error: Cannot convert data to JSON object")
//                        return
//                    }
//                    let loginModel = try JSONDecoder().decode(HelpSupportModel.self, from: response.data!)
//                    print(jsonObject)
//                    completion(loginModel)
//                } catch {
//                    print("Error: Trying to convert JSON data to string")
////                    completion(data)
//                    return
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//    
//    func helpSupportAPI(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
//        
//        let header : HTTPHeaders = [
//            "Authorization": "Bearer " + token,
//            "Content-Type": "application/json"]
//        
//        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
//            switch response.result {
//            case .success(let data):
//                do {
//                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                        print("Error: Cannot convert data to JSON object")
//                        return
//                    }
////                    let loginModel = try JSONDecoder().decode(ConfirmBookingModel.self, from: response.data!)
//                    print(jsonObject)
//                    completion(jsonObject)
//                } catch {
//                    print("Error: Trying to convert JSON data to string")
////                    completion(data)
//                    return
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//    
//    func submitReviewAPI(baseUrl:String, parameter:[String:Any],token:String,completion:@escaping(_:Any)->Void){
//        
//        let header : HTTPHeaders = [
//            "Authorization": "Bearer " + token,
//            "Content-Type": "application/json"]
//        
//        AF.request(URL(string: baseUrl)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseData { response in
//            switch response.result {
//            case .success(let data):
//                do {
//                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                        print("Error: Cannot convert data to JSON object")
//                        return
//                    }
////                    let loginModel = try JSONDecoder().decode(ConfirmBookingModel.self, from: response.data!)
//                    print(jsonObject)
//                    completion(jsonObject)
//                } catch {
//                    print("Error: Trying to convert JSON data to string")
////                    completion(data)
//                    return
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
}
