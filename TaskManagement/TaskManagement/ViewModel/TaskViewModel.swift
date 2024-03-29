//
//  TaskViewModel.swift
//  TaskManagement
//
//  Created by Tony Capelli on 07/05/23.
//

import SwiftUI

class TaskViewModel: ObservableObject {
    
    // sample tasks
    
    @Published var storedTask: [Task] = [
        
        Task(taskTitle: "Meeting", taskDescription: "Discuss team task for the day", taskDate: .init(timeIntervalSince1970: 1683657336)),
        Task(taskTitle: "Icon set", taskDescription: "Edit icon for team task for next week", taskDate: .init(timeIntervalSince1970: 1683652336)),
        Task(taskTitle: "Prototype", taskDescription: "make and send prototype", taskDate: .init(timeIntervalSince1970: 1683511336)),
        Task(taskTitle: "Check asset", taskDescription: "Start checking the assets", taskDate: .init(timeIntervalSince1970: 1683505336)),
        Task(taskTitle: "Team party", taskDescription: "Make fun with team mates", taskDate: .init(timeIntervalSince1970: 1683498336))
        
    ]
    
    //MARK: Current Week Days
    @Published var currentWeek: [Date] = []
    
    //MARK: Current Day
    @Published var currentDay: Date = Date()
    
    //MARK: Filtering Today Tasks
    @Published var filteredTasks: [Task]?
    
    //MARK: Initializing
    init(){
        fetchCurrentWeek()
        filterTodayTasks()
    }
    
    //MARK: Filter Today Tasks
    func filterTodayTasks(){
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let calendar = Calendar.current
            
            let filtered = self.storedTask.filter{
                return calendar.isDate($0.taskDate, inSameDayAs: self.currentDay)
            }
                .sorted { task1, task2 in
                    return task2.taskDate < task1.taskDate
                }
            
            DispatchQueue.main.async {
                withAnimation {
                    self.filteredTasks = filtered
                }
            }
        }
    }
    
    func fetchCurrentWeek(){
        
        let today = Date()
        let calendar = Calendar.current
        
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeekDay = week?.start else {
            return
        }
        
        (1...7).forEach { day in
            
            if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekDay){
                currentWeek.append(weekday)
            }
        }
    }
    
    //MARK: Extracting Date
    func extractDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    //MARK: Checking if current Date is Today
    func isToday(date: Date) -> Bool {
        
        let calendar = Calendar.current
        
        return calendar.isDate(currentDay, inSameDayAs: date)
    }
    
    //MARK: Checking if the currentHour is task Hour
    func isCurrentHour(date: Date) -> Bool {
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let currentHour = calendar.component(.hour, from: Date())
        
        return hour == currentHour
    }
}
