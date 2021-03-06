//
//  ProjectController.swift
//  ProjectManager
//
//  Created by conner on 8/19/20.
//  Copyright © 2020 LambdaStudents. All rights reserved.
//

import Foundation

class ProjectController {
    // MARK: Projects Array
    var projects: [Project] = []
    
    // MARK: Computed Properties
    var count: Int {
        projects.count
    }
    
    // MARK: Functions
    func addProject(_ project: Project) {
        projects.append(project)
    }
    
    func removeProjectAtIndex(_ index: Int) {
        projects.remove(at: index)
    }
    
    func replaceProject(at index: Int, with project: Project) {
        projects.remove(at: index)
        projects.insert(project, at: index)
    }
}
