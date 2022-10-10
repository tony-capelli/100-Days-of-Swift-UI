//
//  ProspectsView.swift
//  HotProspect
//
//  Created by Tony Capelli on 10/10/22.
//

import SwiftUI
import CodeScanner

struct ProspectsView: View {

    enum FilterType {
        case none, contacted, uncontacted
    }
    
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    
    let filter: FilterType
    
    var body: some View {
        NavigationView{
            List{
                ForEach(filteredProspects){ prospect in
                    VStack(alignment:.leading) {
                        Text(prospect.name)
                            .font(.headline)
                        Text(prospect.emailAddress)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle(title)
            .toolbar {
                Button {
                    isShowingScanner = true
                } label: {
                    Label("Scan", systemImage: "qrcode.viewfinder")
                }
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Tony Capelli\ntonycapelli@gmail.com", completion: handleScan)
            }

        }
    }
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted People"
        case .uncontacted:
            return "Uncontacted People"
        }
    }
    
    var filteredProspects: [Prospect]{
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter{$0.isContacted}
        case .uncontacted:
            return prospects.people.filter{!$0.isContacted}
        }
    }
    
    func handleScan(result: Result<ScanResult,ScanError>){
        isShowingScanner = false
        
        switch result{
        case .success(let result):
            let detail = result.string.components(separatedBy: "\n")
            guard detail.count == 2 else {return}
            
            let person = Prospect()
            person.name = detail[0]
            person.emailAddress = detail[1]
            prospects.people.append(person)
        case .failure(let error):
            print("scan failed \(error.localizedDescription)")
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
            .environmentObject(Prospects())
    }
}
