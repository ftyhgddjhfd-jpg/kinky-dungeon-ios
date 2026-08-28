import UIKit
import WebKit
import GCDWebServer

class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {

    private var webView: WKWebView!
    private var server: GCDWebServer?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupWebView()
        startServer()
    }

    private func setupWebView() {
        let config = WKWebViewConfiguration()
        config.preferences.setValue(true, forKey: "allowFileAccessFromFileURLs")
        config.setValue(true, forKey: "allowUniversalAccessFromFileURLs")
        // 尽量加大 WebView 内存/性能
        config.websiteDataStore = .default()
        let controller = WKUserContentController()
        config.userContentController = controller

        webView = WKWebView(frame: view.bounds, configuration: config)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.isOpaque = false
        webView.backgroundColor = .black
        webView.scrollView.isScrollEnabled = false
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(webView)
    }

    private func startServer() {
        let webRoot = Bundle.main.path(forResource: "www", ofType: nil) ?? ""
        let server = GCDWebServer()
        server.addGETHandler(forBasePath: "/", directoryPath: webRoot, indexFilename: "index.html", cacheAge: 0, allowRangeRequests: true)
        do {
            try server.start(options: [
                GCDWebServerOption_Port: 8080,
                GCDWebServerOption_BindToLocalhost: true,
                GCDWebServerOption_AutomaticallySuspendInBackground: false,
            ])
            self.server = server
            let url = URL(string: "http://127.0.0.1:8080/index.html")!
            webView.load(URLRequest(url: url))
        } catch {
            // 兜底：直接加载本地文件（无 Range 支持，但至少能跑）
            let url = URL(fileURLWithPath: webRoot + "/index.html")
            webView.loadFileURL(url, allowingReadAccessTo: URL(fileURLWithPath: webRoot))
        }
    }

    override var prefersStatusBarHidden: Bool { true }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { .allButUpsideDown }
}
