//
//  ViewController.swift
//  td4
//
//  Created by SOUCHET Julie on 18/05/2022.
//

import UIKit
import Kingfisher


class MainViewController: UIViewController {

  let segmentTitles = ["Weather", "Currency"]
  var data: [(String, String)] = []
  let weather: WeatherApi = WeatherApi()

  @IBOutlet weak var segment: UISegmentedControl!
  @IBOutlet weak var titleImage: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var tableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.dataSource = self
    self.tableView.delegate = self

    // Set segment titles
    for (index, title) in segmentTitles.enumerated() {
      segment.setTitle(title, forSegmentAt: index)
    }

    // Initial view = weather
    self.title = segmentTitles[0]
    loadWeather()
    
  }

  /// Change the view title according to which segment is selected
  @IBAction func indexChanged(_ sender: Any) {
    switch segment.selectedSegmentIndex {
      case 0..<segmentTitles.count:
        self.title = segmentTitles[segment.selectedSegmentIndex]
      default:
        print("error: no action defined for this index \(segment.selectedSegmentIndex)")
    }
  }

  func loadWeather() {
    weather.loadWeather { result in
      guard let weatherData = result else {
        print("weather fetch failed: no data")
        return
      }

      DispatchQueue.main.async {
        // Iterate over the properties of the object
        for item in Mirror(reflecting: weatherData).children {
          guard let label = item.label, let value = item.value as? String else {
            return
          }

          switch label {
              // Set the title
            case "text":
              self.titleLabel.text = value
            case "icon":
              self.titleImage.kf.setImage(with: URL(string: "https:"+value))
            default:
              // Add the other properties to the table view
              let tuple: (String, String) = (label, value)
              self.data.append(tuple)
              self.tableView.reloadData()
          }
        }
      }
    }
  }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    data.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CellViewController", for: indexPath) as! CellViewController

    let item = data[indexPath.row]
    cell.label1.text = item.0
    cell.label2.text = item.1

    return cell
  }

}

