//
//  LayerView.swift
//  StitchDemo
//
//  Created by HIROKI IKEUCHI on 2025/04/18.
//

/*
 .blendMode(.multiply): ホワイトは変更なし
 .blendMode(.screen): ブラックは変更なし
 
 
 */

import SwiftUI

extension CGFloat {
    static func calculateCornerRadius(length: CGFloat) -> CGFloat {
        /// https://github.com/pommdau/macos-icon-template/blob/master/macOS11/memo.md
        return length * (186 / 824)
    }
}

struct LayerView: View {
    
    let rectLength1: CGFloat = 300
    let rectLength2: CGFloat = 300
    
    let leatherGradiend = LinearGradient(
        colors: [
            Color(red: 245/255, green: 194/255, blue: 118/255),
            Color(red: 230/255, green: 152/255, blue: 87/255),
        ],
        startPoint: .top,
        endPoint: .bottom
    )
    
    var body: some View {
        ZStack {
            ZStack {
                ZStack {
                    outerRectangle()
                    innerIconFill()
                }
                .blendMode(.normal)
                innerIconTopWhiteShadow()
            }
            .blendMode(.screen)
            innerIconTopBlackShadow()
        }
        .blendMode(.multiply)
    }
    
    @ViewBuilder
    private func outerRectangle() -> some View {
        ZStack {
            ZStack {
                Image(.leather)
                    .resizable()
                    .scaledToFit()
                    .saturation(0)
                    .brightness(0.45)
                    .mask {
                        RoundedRectangle(cornerRadius: .calculateCornerRadius(length: rectLength1),
                                         style: .continuous)
                        .frame(width: rectLength1, height: rectLength1)
                    }
                
                RoundedRectangle(cornerRadius: .calculateCornerRadius(length: rectLength1),
                                 style: .continuous)
                .fill(
                    leatherGradiend
                        .shadow(
                            ShadowStyle.inner(color: .black.opacity(0.4), radius: 8, x: 0, y: -10)
                        )
                        .shadow(
                            ShadowStyle.inner(color: .white.opacity(0.8), radius: 4, x: 0, y: 8)
                        )
                )
                .frame(width: rectLength1, height: rectLength1)
            }
            .blendMode(.multiply)
        }
    }
    
    @ViewBuilder
    private func innerIconFill() -> some View {

        ZStack {
            Image(.leather)
                .resizable()
                .scaledToFit()
                .saturation(0)
                .brightness(0.45)
                .mask {
                    Image(systemName: "figure.and.child.holdinghands")
                        .resizable()
                        .scaledToFit()
                        .frame(width: rectLength1 * 0.7, height: rectLength1 * 0.7)
                        .foregroundStyle(Color(red: 65/255, green: 32/255, blue: 19/255))
                }
            Image(systemName: "figure.and.child.holdinghands")
                .resizable()
                .scaledToFit()
                .frame(width: rectLength1 * 0.7, height: rectLength1 * 0.7)
                .foregroundStyle(Color(red: 65/255, green: 32/255, blue: 19/255))
        }
        .blendMode(.multiply)
    
    }
    
    @ViewBuilder
    private func innerIconTopWhiteShadow() -> some View {
        Image(systemName: "figure.and.child.holdinghands")
            .resizable()
            .scaledToFit()
            .frame(width: rectLength1 * 0.7, height: rectLength1 * 0.7)
            .foregroundStyle(
                Color.black
                    .shadow(
                        ShadowStyle.drop(color: .white.opacity(0.7), radius: 2, x: 0, y: 2)
                    )
            )
    }
    
    @ViewBuilder
    private func innerIconTopBlackShadow() -> some View {
        Image(systemName: "figure.and.child.holdinghands")
            .resizable()
            .scaledToFit()
            .frame(width: rectLength1 * 0.7, height: rectLength1 * 0.7)
            .foregroundStyle(
                Color.white
                    .shadow(
                        ShadowStyle.drop(color: .black, radius: 2, x: 0, y: -2)
                    )
                // 凹み
                    .shadow(
                        ShadowStyle.inner(color: .black, radius: 2, x: 0, y: 4)
                    )
            )
    }
    
    
    @ViewBuilder
    private func innerIcon() -> some View {
        Image(systemName: "figure.and.child.holdinghands")
            .resizable()
            .scaledToFit()
            .frame(width: rectLength1 * 0.7, height: rectLength1 * 0.7)
            .foregroundStyle(
                Color(red: 65/255, green: 32/255, blue: 19/255)
                    .shadow(
                        ShadowStyle.drop(color: .black, radius: 2, x: 0, y: -2)
                    )
                    .shadow(
                        ShadowStyle.drop(color: .white.opacity(0.7), radius: 2, x: 0, y: 2)
                    )
                // 凹み
                    .shadow(
                        ShadowStyle.inner(color: .black, radius: 2, x: 0, y: 4)
                    )
            )
    }
    
    @ViewBuilder
    private func innerIcon2() -> some View {
        ZStack {
            innerIcon()
//            Image(.leather)
//                .resizable()
//                .scaledToFit()
//                .mask {
//                    ZStack {
//                        Image(systemName: "figure.and.child.holdinghands")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 200, height: 200, alignment: .center)
//                    }
//                }
//                .saturation(0)
//                .brightness(0.45)
//                .brightness(0.1)
        }
//        .blendMode(.multiply)
//        .compositingGroup()
//        .blendMode(.normal)
    }
}

#Preview {
    LayerView()
}
