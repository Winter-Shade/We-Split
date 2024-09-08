
import SwiftUI

struct ContentView: View {
    @State private(set) var billAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 10
    @FocusState private var isAmountFocused: Bool
    
//    let tipPercentages = [10, 15, 20, 25 ,0]
    
    var totalPerPerson : (Double, Double){
        let peopleCount = Double(numberOfPeople) + 2
        let tipValue = billAmount * Double(tipPercentage)/100
        let grandTotal = billAmount + tipValue
        return (grandTotal,(grandTotal/peopleCount))
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    //                Text("Enter amount to split")
                    TextField("Amount", value: $billAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($isAmountFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("How much do you want to tip?"){
                    Picker("Tip Percentage", selection: $tipPercentage){
                        ForEach(0..<101){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Total Amount for the check"){
                    Text(totalPerPerson.0, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundStyle(tipPercentage==0 ? .gray : .black)
                }
                
                Section("Amount Per Person"){
                    Text(totalPerPerson.1,format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar{
                if isAmountFocused{
                    Button("Done"){
                        isAmountFocused = false
                    }
                }
            }
        }
        
    }
}


#Preview {
    ContentView()
}
