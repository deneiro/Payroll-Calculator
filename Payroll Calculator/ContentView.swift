//
//  ContentView.swift
//  Payroll Calculator
//
//  Created by Eldar Bauyrzhan on 28.12.2024.
//

import SwiftUI

struct ContentView: View {
    @State var payType = 0
    @State var basic = "20000.00"
    @State var daysIn = "12.00"
    @State var taxable = true
    @State var insurance = false
    
    @State var gross = 0.00
    @State var netPay = 0.00
    @State var taxDeducted = 0.00
    @State var insuranceDeducted = 0.00
    let pctTax = 0.15
    let pctInsurance = 0.02
    
    
    var body: some View {
        VStack {
            Form{
                Picker(selection: $payType, label: Text("Pay type")){
                    Text("Salary").tag(0)
                    Text("Wage").tag(1)
                }
                Text("Basic / Day rate")
                TextField("", text: $basic)
                    .multilineTextAlignment(.trailing)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                Text("Days in month")
                TextField("", text: $daysIn)
                    .multilineTextAlignment(.trailing)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                Toggle(isOn: $taxable){
                    Text("Taxable")
                }
                Toggle(isOn: $insurance){
                    Text("Insurance")
                }
                
                let gridItems = [GridItem(), GridItem()]
                
                LazyVGrid(columns: gridItems){
                    Text("Gross")
                        .padding(.top, 4)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(formatNumber(num: gross))
                        .padding(.top, 4)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    Text("Less")
                        .padding(.top, 4)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("")
                    Text("Tax")
                        .padding(.top, 4)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(formatNumber(num: taxDeducted))
                        .padding(.top, 4)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    Text("Insurance")
                        .padding(.top, 4)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(formatNumber(num: insuranceDeducted))
                        .padding(.top, 4)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    Text("Net")
                        .padding(.top, 4)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(formatNumber(num: netPay))
                        .padding(.top, 4)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
                Button{
                    computePay()
                }label: {
                    Text("Compute")
                        .padding(10)
                        .frame(maxWidth:.infinity,alignment:.center)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(4.0)
                        .shadow(radius: 3.0)
                }
            }.padding()
        }
        .padding()
    }
    
    func formatNumber(num: Double) -> String{
        let numStr = String(num)
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        if let formattedString = formatter.string(from: NSNumber(value: num)){
            return formattedString
        }
        
        return numStr
        
    }
    
    func computePay(){
        taxDeducted = taxable ? pctTax * (Double(basic) ?? 0.00) : 0.00
        insuranceDeducted = insurance ? pctInsurance * (Double(basic) ?? 0.00) : 0.00
        if payType == 1 {
            gross = (Double(daysIn) ?? 0.00) * (Double(basic) ?? 0.00)
        }else{
            gross = Double(basic) ?? 0.00
        }
        netPay = gross - taxDeducted - insuranceDeducted
    }
}

#Preview {
    ContentView()
}
