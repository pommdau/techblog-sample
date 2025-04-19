//
//  LeatherView.swift
//  StitchDemo
//
//  Created by HIROKI IKEUCHI on 2025/04/18.
//

/*
 .blendMode(.normal): 色の上塗り
 .blendMode(.multiply): ホワイトは変更なし
 .blendMode(.screen): ブラックは変更なし
 */

import SwiftUI

struct LeatherView: View {
            
    @State private var leatherSize: CGSize = .init(width: 300, height: 300)
        
    let stitchScale = 0.9
    let stitchLineWidth: CGFloat = 4.0
    
    let leatherGradiend = LinearGradient(
        colors: [
            Color(red: 245/255, green: 194/255, blue: 118/255),
            Color(red: 230/255, green: 152/255, blue: 87/255),
        ],
        startPoint: .top,
        endPoint: .bottom
    )
    
    var innerIconLength: CGFloat {
        min(leatherSize.width, leatherSize.height) * 0.7
    }
    
    var cornerRadius: CGFloat {
        .calculateCornerRadius(length: min(leatherSize.width, leatherSize.height))
    }
    
    var stitchSize: CGSize {
        .init(width: leatherSize.width * stitchScale, height: leatherSize.height * stitchScale)
    }
    
    var stitchCornerRadius: CGFloat {
        min(stitchSize.width, stitchSize.height)
    }
    
    var stitchPaths: [Path] {
        Path.createStitchPaths(
            rectSise: .init(width: leatherSize.width * stitchScale, height: leatherSize.height * stitchScale),
            cornerRadius: CGFloat.calculateCornerRadius(length: stitchCornerRadius),
            lineWidth: stitchLineWidth,
            dash: [stitchLength, stitchSpaceLength],
            dashPhase: .zero,
            rotationDegree: stitchLotationDegree
        )
    }
    
    var stitchShadowPaths: [Path] {
        Path.createStitchPaths(
            rectSise: .init(width: leatherSize.width * stitchScale, height: leatherSize.height * stitchScale),
            cornerRadius: CGFloat.calculateCornerRadius(length: stitchCornerRadius),
            lineWidth: stitchLineWidth,
            dash: [stitchLength, stitchSpaceLength],
            dashPhase: stitchSpaceLength,
            rotationDegree: -stitchLotationDegree
        )
    }
    
    // MARK: Parameters
        
    @AppStorage("stitchLotationDegree")
    private var stitchLotationDegree: Double = .zero
    
    @AppStorage("stitchLength")
    private var stitchLength: Double = 10.0
    
    @AppStorage("stitchSpaceLength")
    private var stitchSpaceLength: Double = 5.0
    
    @AppStorage("hasStitchShadow")
    private var hasStitchShadow: Bool = true
    
    // MARK: - View
    
    var body: some View {
        VStack {
            leatherRectangle()
                .overlay {
                    innerIconFill()
                        .blendMode(.normal)
                }
                .overlay {
                    innerIconWhiteShadow()
                        .blendMode(.screen)
                }
                .overlay {
                    innerIconBlackShadow()
                        .blendMode(.multiply)
                }
                .overlay {
                    stitchsShadowRectangle()
                }
                .overlay {
                    stitchsRectangle()
                }
            
                .compositingGroup() // blentModeの切り替え
                .blendMode(.normal)
                .padding(.top, 20)
                .background {
                    Color.init(red: 234/255, green: 196/255, blue: 126/255)
                }
            stitchParameterForm()
        }
        .shadow(color: .black.opacity(0.5), radius: 4, x: 0, y: 8)
        .ignoresSafeArea()
    }
}

// MARK: - Stitch

extension LeatherView {
    @ViewBuilder
    private func stitchsRectangle() -> some View {
        ZStack {
            ForEach(Array(stitchPaths.enumerated()), id: \.offset) { _, path in
                path
                    .fill(Color.stitch)
                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
            }
        }
        .frame(width: stitchSize.width, height: stitchSize.height)
    }
    
    @ViewBuilder
    private func stitchsShadowRectangle() -> some View {
        ZStack {
            ForEach(Array(stitchShadowPaths.enumerated()), id: \.offset) { _, path in
                path
//                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
                    .fill(hasStitchShadow ? .black.opacity(0.8) : .clear)
            }
        }
        .frame(width: stitchSize.width, height: stitchSize.height)
    }
}

// MARK: - Leather View

extension LeatherView {
    
    @ViewBuilder
    private func leatherRectangle() -> some View {
        // レザー模様(白色)
        Image(.leather)
            .resizable()
            .aspectRatio(1.0, contentMode: .fit)
            .saturation(0)
            .brightness(0.45)
            .mask {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .frame(width: leatherSize.width, height: leatherSize.height)
            }
        // レザーにグラデーションで着色
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(
                        leatherGradiend
                        // 上部の光沢
                            .shadow(
                                ShadowStyle.inner(color: .black.opacity(0.4), radius: 8, x: 0, y: -10)
                            )
                        // 下部の影
                            .shadow(
                                ShadowStyle.inner(color: .white.opacity(0.5), radius: 8, x: 0, y: 6)
                            )
                    )
                    .frame(width: leatherSize.width, height: leatherSize.height)
            )
        .blendMode(.multiply)
    }
    
    @ViewBuilder
    private func innerIconFill() -> some View {
        ZStack {
            Image(.leather)
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .saturation(0)
                .brightness(0.45)
                .mask {
                    Image(systemName: "figure.and.child.holdinghands")
                        .resizable()
                        .scaledToFit()
                        .frame(width: innerIconLength)
                }
            Image(systemName: "figure.and.child.holdinghands")
                .resizable()
                .scaledToFit()
                .frame(width: innerIconLength)
                .foregroundStyle(Color.innerIconFill)
        }
        .blendMode(.multiply)
    }
    
    @ViewBuilder
    private func innerIconWhiteShadow() -> some View {
        // アイコン外側下部の光沢
        Image(systemName: "figure.and.child.holdinghands")
            .resizable()
            .scaledToFit()
            .frame(width: innerIconLength)
            .foregroundStyle(
                Color.black
                    .shadow(
                        ShadowStyle.drop(color: .white.opacity(0.7), radius: 2, x: 0, y: 2)
                    )
            )
    }
    
    @ViewBuilder
    private func innerIconBlackShadow() -> some View {
        Image(systemName: "figure.and.child.holdinghands")
            .resizable()
            .scaledToFit()
            .frame(width: innerIconLength)
            .foregroundStyle(
                Color.white
                // アイコン外側上部の影
                    .shadow(
                        ShadowStyle.drop(color: .black, radius: 2, x: 0, y: -2)
                    )
                // アイコン内部の凹みの影
                    .shadow(
                        ShadowStyle.inner(color: .black, radius: 2, x: 0, y: 4)
                    )
            )
    }
}


// MARK: - Stitch Controller

extension LeatherView {
    @ViewBuilder
    private func stitchParameterForm() -> some View {
        Form {
            HStack {
                Image(systemName: "angle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                Text(String(format: "%04.1f°  ", stitchLotationDegree))
                    .monospacedDigit()
                Slider(value: $stitchLotationDegree, in: 0.0...45)
            }
            HStack {
                Image(systemName: "ruler")
                    .scaledToFit()
                    .frame(width: 20)
                Text(String(format: "%04.1f pt", stitchLength))
                    .monospacedDigit()
                Slider(value: $stitchLength, in: 1...40)
            }
            HStack {
                Image(systemName: "space")
                    .scaledToFit()
                    .frame(width: 20)
                Text(String(format: "%04.1f pt", stitchSpaceLength))
                    .monospacedDigit()
                Slider(value: $stitchSpaceLength, in: 1...40)
            }
            HStack {
                Image(systemName: "circle.dashed")
                    .scaledToFit()
                    .frame(width: 20)
                Toggle("", isOn: $hasStitchShadow)
            }
        }
    }
}

#Preview {
    LeatherView()
}
