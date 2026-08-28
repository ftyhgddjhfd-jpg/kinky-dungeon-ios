# KinkyDungeon iOS App

Kinky Dungeon 网页版打包的 iOS App（WKWebView + 内嵌 HTTP 服务器）。

## 构建

推送代码到 GitHub 后，Actions 自动构建 IPA。构建完成后在 Actions 页面下载 `KinkyDungeon-ipa` 工件。

## 自签安装

1. 下载 IPA
2. 用轻松签（EasySign）等工具自签
3. 安装到 iPhone

## 本地构建（需要 Mac + Xcode）

```bash
brew install xcodegen
xcodegen generate
xcodebuild -project KinkyDungeonApp.xcodeproj -scheme KinkyDungeonApp -configuration Release -destination 'generic/platform=iOS' -derivedDataPath build CODE_SIGNING_ALLOWED=NO build
```
