//
//  GoogleAdMob.swift
//  adamsCalc
//
//  Created by Adam Reed on 6/24/21.
//

import SwiftUI
import GoogleMobileAds
import UIKit

final class BannerVC: UIViewControllerRepresentable  {
    
    var testBannerAdId = "ca-app-pub-3940256099942544/2934735716"
    var realBannerAdId = "ca-app-pub-4186253562269967/1810673377"

    func makeUIViewController(context: Context) -> UIViewController {
        let view = GADBannerView(adSize: kGADAdSizeBanner)

        let viewController = UIViewController()
        // Setup the real or test banner id
        view.adUnitID = realBannerAdId
        view.rootViewController = viewController
        viewController.view.addSubview(view)
        viewController.view.frame = CGRect(origin: .zero, size: kGADAdSizeBanner.size)
        view.load(GADRequest())

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct Banner:View{
    
    @EnvironmentObject var vm: EdiblyViewModel
    
    var body: some View {
        if vm.removedAdvertising != true {
            HStack(alignment: .center) {
                Spacer()
                BannerVC()
                    .background(Color(.systemGray6))
                    .frame(width: 320, height: 60, alignment: .center)
                Spacer()
            }
        }
    }
}

struct Banner_Previews: PreviewProvider {
    static var previews: some View {
        Banner()
    }
}
