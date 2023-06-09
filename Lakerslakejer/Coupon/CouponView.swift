//
//  CouponView.swift
//  Lakerslakejer
//
//  Created by Julia Petersson  on 2023-05-15.
//

import SwiftUI
import Firebase

struct CouponView: View {
    @ObservedObject var couponVM : CouponViewModel
    
    var body: some View {
        Grid(alignment: .center, horizontalSpacing: 1, verticalSpacing: 1) {
            Text(String(couponVM.coupons))
            if couponVM.coupons > 10 {
                Text("Du har en till 10-Block som visas när din första är förbrukat")
            }
            
            Spacer()
            GridRow{
                if couponVM.coupons > 10 {
                    ForEach(10..<13) { index in
                        
                        Image(index < couponVM.coupons ? "Coupon" : "UsedCoupon")
                            .padding()
                    }}
                else {
                    ForEach(0..<3) { index in
                        
                        Image(index < couponVM.coupons ? "Coupon" : "UsedCoupon")
                            .padding()
                    }}}
            
            GridRow{
                if couponVM.coupons > 10 {
                    ForEach(13..<16) { index in
                        
                        Image(index < couponVM.coupons ? "Coupon" : "UsedCoupon")
                            .padding()
                    }}
                else {
                ForEach(3..<6) { index in
                    
                    Image(index < couponVM.coupons ? "Coupon" : "UsedCoupon")
                        .padding()
                }}}

            GridRow{
                if couponVM.coupons > 10 {
                    ForEach(16..<19) { index in
                        
                        Image(index < couponVM.coupons ? "Coupon" : "UsedCoupon")
                            .padding()
                    }}
                else{
                    ForEach(6..<9) { index in
                        
                        Image(index < couponVM.coupons  ? "Coupon" : "UsedCoupon")
                            .padding()
                    }}}
            GridRow(){
                Rectangle()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.clear)
                
                if couponVM.coupons > 10 {
                    ForEach(19..<20) { index in
                        
                        Image(index < couponVM.coupons ? "Coupon" : "UsedCoupon")
                            .padding()
                    }}
                else{
                    ForEach(9..<10) { index in
                        
                        Image(index < couponVM.coupons ? "Coupon" : "UsedCoupon")
                            .padding()
                    }}}
            
            Spacer()
            VStack {
                let coupontext = "\(couponVM.memberNr)\n\(couponVM.coupons)"
                
                if coupontext != ""{
                    Image(uiImage: UIImage(data: returnData(str: coupontext))!).resizable().frame(width: 150, height: 150)
                }
                HStack{
                  Text("Medlem: ")
                    Text(String(couponVM.memberNr))}
                Text(String(couponVM.coupons))
            }
            Spacer()
        }.onAppear{couponVM.getCoupons()}
    }
    
    func returnData(str : String)-> Data{
        let filter = CIFilter(name: "CIQRCodeGenerator")
        let data = str.data(using: .ascii, allowLossyConversion: false)
        filter?.setValue(data, forKey: "inputMessage")
        let image = filter?.outputImage
        let uiimage = UIImage(ciImage: image!)
        return uiimage.pngData()!
    }
}
