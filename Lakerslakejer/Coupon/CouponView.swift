//
//  CouponView.swift
//  Lakerslakejer
//
//  Created by Julia Petersson  on 2023-05-15.
//

import SwiftUI
import Firebase

struct CouponView: View {
    
    // User behöver en Int med CouponsAvailable
    // ett medlemsnr - som sedan även svara till Qr läsaren
    //två typ av Coupontecken available - 1 unavailabel
    //CouponViewn ska med en Loop kolla hur många är available och isf väljer availablepic och om resten är unavailabel
    
    @State var coupons = 7
    @State var newCoupons = 0
    @ObservedObject var couponVM : CouponViewModel
    
    var body: some View {
        let totalCoupons = 10 // Total number of coupons
       
       
        
        Grid(alignment: .center, horizontalSpacing: 1, verticalSpacing: 1) {
            if coupons > 10 {
                Text("Du har en till 10-Block som visas när din första är förbrukat")
                    .onAppear(perform: {
                        newCoupons = coupons - 10
                        
                        //jag hantera visst inte om man har mer än tjugo,... men tänker det händer inte 
                    })
            }
            else{
                Text("")
                    .onAppear(perform: {
                        newCoupons = coupons
                    })
                
            }
            Spacer()
            GridRow{
                ForEach(0..<3) { index in
                    
                    Image(index < newCoupons ? "Coupon" : "UsedCoupon")
                        .padding()
                    
                }}
            GridRow{
                ForEach(3..<6) { index in
                    
                    Image(index < newCoupons ? "Coupon" : "UsedCoupon")
                        .padding()
                    
                }}
            GridRow{
                ForEach(6..<9) { index in
                    
                    Image(index < newCoupons ? "Coupon" : "UsedCoupon")
                        .padding()
                    
                }}
            GridRow(){
                Rectangle()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.clear)
                ForEach(9..<10) { index in
                    
                    Image(index < newCoupons ? "Coupon" : "UsedCoupon")
                        .padding()
                    
                }}.onAppear{couponVM.getCoupons()}
            
            Spacer()
            VStack {
                Rectangle()
                    .frame(width: 130, height: 130)
                    .foregroundColor(.ui.gold)
                    .padding(.bottom, 30)
                HStack{
                  Text("Medlem: ")
                    Text(String(couponVM.memberNr))}
                Text(String(couponVM.coupons))
            }
            Spacer()
        }
        
    }
}

//struct CouponView_Previews: PreviewProvider {
//    static var previews: some View {
//        CouponView()
//    }
//}
