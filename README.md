# Analytics Center

Analytics Center gives an opportunity to gather all Analytics Services in one place and to track events with one line of code.

Example project: https://github.com/0xMarK/HackerNews

Add Mixpanel Analytics Service and start the AnalyticsCenter:

```swift
@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AnalyticsCenter.shared.add(MixpanelAnalyticsService(
            apiToken: "XXXXXXXXXX",
            eventNameFormatter: EventNameFormatter(format: .capitalized)
        ))
        AnalyticsCenter.shared.start()
        return true
    }

}
```

Track event `screenView`:

```swift
class AppDelegate: NSObject, UIApplicationDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        analytics.track(AnalyticsEventEnum.screenView(screenClass: nil, screenName: "Top Stories"))
    }

}
```
