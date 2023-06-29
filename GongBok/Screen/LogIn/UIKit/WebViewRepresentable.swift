//
//  WebViewRepresentable.swift
//  GongBok
//
//  Created by 최준영 on 2023/05/31.
//

import UIKit
import SwiftUI
import Combine
import WebKit

struct WebViewRepresentable: UIViewRepresentable {
    @EnvironmentObject var authObj: AuthenticationObject
    @EnvironmentObject var viewModel: LoginScreenViewModel
    
    var url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = false  //JavaScript가 사용자 상호 작용없이 창을 열 수 있는지 여부
        
        let configuration = WKWebViewConfiguration()
        
        configuration.preferences = preferences
        let dataTypes = WKWebsiteDataStore.allWebsiteDataTypes()
        let date = Date(timeIntervalSince1970: 0)
        configuration.websiteDataStore.removeData(ofTypes: dataTypes, modifiedSince: date) { }
        
        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator    //웹보기의 탐색 동작을 관리하는 데 사용하는 개체
        webView.allowsBackForwardNavigationGestures = true    //가로로 스와이프 동작이 페이지 탐색을 앞뒤로 트리거하는지 여부
        webView.scrollView.isScrollEnabled = false    //웹보기와 관련된 스크롤보기에서 스크롤 가능 여부
        
        webView.load(URLRequest(url: url))
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
    
    func sizeThatFits(_ proposal: ProposedViewSize, uiView: WKWebView, context: Context) -> CGSize? {
        guard let width = proposal.width, let height = proposal.height else { return nil }
        
        return CGSize(width: width, height: height)
    }
}

class Coordinator: NSObject, WKNavigationDelegate {
    var parent: WebViewRepresentable
    
    init(parent: WebViewRepresentable) {
        self.parent = parent
    }
    
    //navigation이 끝난을 때 호출
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //Swift->자바스크립트 함수를 호출하는 매서드
        webView.evaluateJavaScript("document.documentElement.innerText") { result, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let responseData = result as? String, let data = responseData.data(using: .utf8) {
                do {
                    let decoded = try JSONDecoder().decode(ServerAuth.self, from: data)
                    self.parent.authObj.setLocalAuthData(decoded)
                    //첫 접속일 경우
                    if decoded.role != nil {
                        self.parent.viewModel.addToStack(destination: .userInfo)
                    } else {
                        self.parent.viewModel.popTopView()
                        DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
                            self.parent.authObj.setViewState(.available)
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct TestCode: Codable {
    var role: String
    var accessToken: String
    var refreshToken: String
}


