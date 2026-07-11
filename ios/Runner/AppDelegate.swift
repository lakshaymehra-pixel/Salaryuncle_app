import UIKit
import Flutter
import FirebaseCore 

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)

 /** For Appsflyer implementation */
//     	<key>Appsflyer</key>
//        	<dict>
//        		<key>appid</key>
//        		<string>6503283983</string>
//        		<key>com.appsflyer.onelink.domain</key>
//        		<string>suryaloan.onelink.me</string>
//        		<key>devkey</key>
//        		<string>fupfvH2AJ3JwqVvW9z2747</string>
//        	</dict>

/** For Facebook SDK implementation */
// 	<key>FacebookAdvertiserIDCollectionEnabled</key>
// 	<true/>
// 	<key>FacebookAppID</key>
// 	<string>997903871848012</string>
// 	<key>FacebookClientToken</key>
// 	<string>bac922d7dde23de7b2ed02d0443f7752</string>
// 	<key>FacebookDisplayName</key>
// 	<string>SuryaLoan</string>
// 	<key>FlutterDeepLinkingEnabled</key>
// 	<true/>
      
  }
}
