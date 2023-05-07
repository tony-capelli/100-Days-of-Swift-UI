//
//  Home.swift
//  TaskManagement
//
//  Created by Tony Capelli on 07/05/23.
//

import SwiftUI

struct Home: View {
    @StateObject var taskModel: TaskViewModel = TaskViewModel()
    @Namespace var animation
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            //MARK: lazy stack with Pinned Header
            LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]) {
                Section {
                    
                    //MARK: Current Week View
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack(spacing: 10) {
                            
                            ForEach(taskModel.currentWeek, id:\.self){ day in
                                
                                VStack(spacing: 10){
                                    
                                    Text(taskModel.extractDate(date: day, format: "dd"))
                                        .font(.system(size: 15))
                                        .fontWeight(.semibold)
                                    
                                    Text(taskModel.extractDate(date: day, format: "EEE"))
                                        .font(.system(size: 14))
                                    
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 8, height: 8)
                                        .opacity(taskModel.isToday(date: day) ? 1:0)
                                       
                                }
                                //MARK: Foreground Style
                                .foregroundStyle(taskModel.isToday(date: day) ? .primary : .secondary)
                                .foregroundColor(taskModel.isToday(date: day) ? .white : .black)
                                //MARK: Capsule shape
                                .frame(width: 45, height: 90)
                                .background {
                                    ZStack {
                                        //MARK: Matched Geometry Effect
                                        if taskModel.isToday(date: day){
                                            Capsule()
                                                .fill(.black)
                                                .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                                        }
                                       
                                    }
                                }
                                .contentShape(Capsule())
                                .onTapGesture {
                                    //MARK: Updating current Day+
                                    withAnimation {
                                        taskModel.currentDay = day
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    TasksView()
                     
                } header: {
                     HeaderView()
                }
            }
        }
    }
    
    //MARK: Tasks View
    func TasksView() -> some View {
        
        LazyVStack(spacing: 18){
            if let tasks = taskModel.filteredTasks{
                
                if tasks.isEmpty {
                    Text("No tasks found")
                } else {
                    
                    ForEach(tasks){ task in
                        TaskCardView(task: task)
                    }
                }
                
                
            }else{
                ProgressView()
                    .offset(y:100)
            }
        }
    }
    
    //MARK: Task Card View
    func TaskCardView(task: Task) -> some View {
        
        HStack {
            Text(task.taskTitle)
        }
    }
    
    //MARK: Header
    func HeaderView()-> some View {
        HStack(spacing: 10){
            
            VStack(alignment: .leading, spacing: 10) {
                
                Text(Date().formatted(date: .abbreviated, time: .omitted))
                    .foregroundColor(.gray)
                
                Text("Today")
                    .font(.largeTitle.bold())
            }
            .hLeading()
            
            Button {
                
            } label: {
                
                Image("Profile")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
            }

        }
        .padding()
        .background(Color.white)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

//MARK: UI Design Helper functions
extension View{
    
    func hLeading() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func hTrailing() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    func hCenter() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .center)
    }
}
