<p align="center">
    <img src="http://www.inspireidaho.com/wp-content/uploads/2018/01/InspireIdaho-Home-1280.png" style="background-color:#000000"  alt="Inspire Home">
    <br>
    <br>
    <a href="http://docs.vapor.codes/3.0/">
        <img src="http://img.shields.io/badge/vapor-3.0-2196f3.svg" alt="Documentation">
    </a>
    <a href="LICENSE">
        <img src="http://img.shields.io/badge/license-MIT-brightgreen.svg" alt="MIT License">
    </a>
    <a href="https://swift.org">
        <img src="http://img.shields.io/badge/swift-4.1-brightgreen.svg" alt="Swift 4.1">
    </a>
</p>

# restaurant-server

> Re-implementation of OpenRestaurant.app from the iBook *App Development with Swift* Unit 5: Guided Project. A simple web service (built on Vapor) to provide restaurant menu data to the iOS OrderApp constructed in that tutorial lesson.

## Build Setup
### Install

``` bash
# clone project repo from GitHub
git clone https://github.com/InspireIdaho/restaurant-server.git

# generate xcode project (its not checked into repo)
cd restaurant-server
swift package generate-xcodeproj
open restaurant-server.xcodeproj

```

### Run 
Once Xcode opens the project, at the top-left of title bar, select the **Run** Scheme, targeting **My Mac**
 
![xcode-run-scheme](https://user-images.githubusercontent.com/9576678/44289945-4170b900-a22b-11e8-9589-f94f4f27fd88.png)

Then click the Run icon ( or &#8984;R ). The server will compile and run.
> Upon first run, you should see a dialog box asking if you want to allow this process to accept incoming network connections: choose **Accept**.

Once you see the following text in the console (at bottom right of Xcode)...  

``` bash 
Server starting on http://localhost:8090

```

... the service is ready to test the OrderApp!

## iOS App Integration

The OrderApp swift code will need a minor tweak from that in the iBook. The suggested code on **p.915** of chapter *5.7 Guided Project: Restaurant* needs to be modified to this: 

``` swift
func fetchMenuItems(categoryName: String, completion: @escaping ([MenuItem]?) -> Void) {
  let initialMenuURL = baseURL.appendingPathComponent("menu")
  var components = URLComponents(url: initialMenuURL, resolvingAgainstBaseURL: true)!
  components.queryItems = [URLQueryItem(name: "category", value: categoryName)]
  let menuURL = components.url!
  let task = URLSession.shared.dataTask(with: menuURL) { (data, response, error) in
    let jsonDecoder = JSONDecoder()
    if let data = data,
      let menuItems = try? jsonDecoder.decode([MenuItem].self, from: data) {
      completion(menuItems)
    } else {
      completion(nil)
    }
  }
  task.resume()
}

```
> Notice: rather than dealing with a property `items` on `MenuItems`, Vapor enables the API to return - and the `JSONDecoder` can parse directly - an array of `MenuItem` or `[MenuItem]`.

## Help

For questions, comments, etc. - post on the InspireIdaho [Slack Channel](https://inspireidaho.slack.com) #help-github 