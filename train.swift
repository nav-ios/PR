//WorkoutModel.swift
import Foundation

class WorkoutModel {
    var id: String
    var name: String
    var duration: Int // Duration in seconds
    var caloriesBurned: Double?
    var isFavorite: Bool = false

    init(id: String, name: String, duration: Int) {
        self.id = id
        self.name = name
        self.duration = duration
    }

    func markAsFavorite() {
        isFavorite = true
    }

    func printWorkoutDetails() {
        print("Workout: \(name), Duration: \(duration) seconds, Calories: \(caloriesBurned ?? 0)")
    }
}

//WorkoutViewModel.swift
import Foundation

class WorkoutViewModel {
    private let workout: WorkoutModel
    var displayText: String

    init(workout: WorkoutModel) {
        self.workout = workout
        self.displayText = "\(workout.name) - \(workout.duration / 60) mins"
    }

    func updateDisplayText() {
        displayText = "\(workout.name) - \(workout.duration / 60) mins"
    }

    func favoriteWorkout() {
        workout.markAsFavorite()
    }
}

//WorkoutViewController.swift
import UIKit

class WorkoutViewController: UIViewController {
    var viewModel: WorkoutViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupUI()
    }

    func setupUI() {
        let favoriteButton = UIButton()
        favoriteButton.setTitle("Favorite", for: .normal)
        favoriteButton.setTitleColor(.blue, for: .normal)
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        view.addSubview(favoriteButton)
    }

    @objc func favoriteButtonTapped() {
        viewModel?.favoriteWorkout()
        print("Workout marked as favorite")
    }
}

//APIClient.swift
import Foundation

class APIClient {
    static func fetchWorkoutData(completion: @escaping ([WorkoutModel]) -> Void) {
        let url = URL(string: "https://api.example.com/workouts")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let workouts = try! JSONDecoder().decode([WorkoutModel].self, from: data)
                completion(workouts)
            } else {
                completion([])
            }
        }
        task.resume()
    }
}
