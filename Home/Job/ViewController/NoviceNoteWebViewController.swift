
import UIKit
import WebKit
class NoviceNoteWebViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "新手须知"
        self.navigationController?.navigationBar.isTranslucent = false
        let webView = WebView()
        view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-TAB_BAR_HEIGHT + 64)
        }
        webView.delegate = self
        // 配置webView样式
        var config = WkwebViewConfig()
        config.isShowScrollIndicator = false
        config.isProgressHidden = false
        // 加载普通URL
        webView.webConfig = config
        webView.webloadType(self, .URLString(url: "http://beibeicare.com/hunter/index.php?s=/Home/index/index"))
        
        // 加载本地URL
        //        config.scriptMessageHandlerArray = ["valueName"]
        //        webView.webConfig = config
        //        webView.delegate = self
        //        webView.webloadType(self, .HTMLName(name: "test"))
        //
        // POST加载
        //        let mobile = ""
        //        let pop = ""
        //        let auth = ""
        //        let param = ["mobile":"\(mobile)","pop":"\(pop)","auth":"\(auth)"];
        //        webView.webConfig = config
        //        webView.webloadType(self, .POST(url: "http://xxxxx", parameters: param))
        
    }
    
}

extension NoviceNoteWebViewController:WKWebViewDelegate{
    
    func webViewUserContentController(_ scriptMessageHandlerArray: [String], didReceive message: WKScriptMessage) {
        print(message.body)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("开始加载")
    }
}

