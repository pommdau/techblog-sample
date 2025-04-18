//
//  ContentView.swift
//  StitchDemo
//
//  Created by HIROKI IKEUCHI on 2025/04/18.
//
/*
 [robb: "Quick tutorial how the stitching was achieved: - Use `strokedPath(_:)` to split the path into multiple lines, using a two-component dash array. - Convert to a CGPath, split it into subcomponents using `componentsSeparated(using:)`. - Apply a rotation to each line. - Merge them back together." — Bluesky](https://bsky.app/profile/robb.is/post/3lclsy7q3bc2q)
 [SwiftUI: Pathで二色の破線を描く](https://zenn.dev/kyome/articles/05700057859bd3)
 [dash | Apple Developer Documentation](https://developer.apple.com/documentation/swiftui/strokestyle/dash)
 [SwiftUI: エンボス風？ベベル風？の表現](https://zenn.dev/kabeya/scraps/8186e86415b2b0)
 [緑の革の質感のクローズアップの写真 – Unsplashのテクスチャーの画像](https://unsplash.com/ja/%E5%86%99%E7%9C%9F/%E7%B7%91%E3%81%AE%E9%9D%A9%E3%81%AE%E8%B3%AA%E6%84%9F%E3%81%AE%E3%82%AF%E3%83%AD%E3%83%BC%E3%82%BA%E3%82%A2%E3%83%83%E3%83%97-wjv4SRKPb-A)
 [【SwiftUI】リバースマスクを実装し、Viewを切り抜く方法 | DevelopersIO](https://dev.classmethod.jp/articles/swiftui-reverse-mask/)
 */
import SwiftUI

// MARK: - View

struct ContentView: View {
    
    // MARK: - Property
            
    private let rectangleSize: CGSize = .init(width: 300, height: 200)
    private var rectangleCornerRadius: CGFloat {
        /// https://github.com/pommdau/macos-icon-template/blob/master/macOS11/memo.md
        let minLength = min(rectangleSize.width, rectangleSize.height)
        return minLength * (186 / 824)
    }
    private let stitchLineWidth: CGFloat = 4.0
    
    // MARK: Parameters
        
    @AppStorage("stitchLotationDegree")
    private var stitchLotationDegree: Double = .zero
    
    @AppStorage("stitchLength")
    private var stitchLength: Double = 10.0
    
    @AppStorage("stitchSpaceLength")
    private var stitchSpaceLength: Double = 5.0
    
    @AppStorage("hasStitchShadow")
    private var hasStitchShadow: Bool = true
    
    // MARK: Path
    
    var stitchPaths: [Path] {
        Path.createStitchPaths(
            rectSise: rectangleSize,
            cornerRadius: rectangleCornerRadius,
            lineWidth: stitchLineWidth,
            dash: [stitchLength, stitchSpaceLength],
            dashPhase: .zero,
            rotationDegree: stitchLotationDegree
        )
    }
    
    var stitchShadowPaths: [Path] {
        Path.createStitchPaths(
            rectSise: rectangleSize,
            cornerRadius: rectangleCornerRadius,
            lineWidth: stitchLineWidth,
            dash: [stitchSpaceLength, stitchLength],
            dashPhase: stitchSpaceLength,
            rotationDegree: -stitchLotationDegree
        )
    }
    
    // MARK: - View
            
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: rectangleCornerRadius, style: .continuous)
                .foregroundStyle(Color.outerRectangle)
                .frame(width: rectangleSize.width, height: rectangleSize.height)
            
            // Stitch Shadow
            ZStack {
                ForEach(Array(stitchShadowPaths.enumerated()), id: \.offset) { _, path in
                    path
                        .fill(hasStitchShadow ? .black.opacity(0.8) : .clear)
                }
            }
            .scaleEffect(0.9) // 外形の内側に寄せる
            .frame(width: rectangleSize.width, height: rectangleSize.height)
            
            // Stitch
            ZStack {
                ForEach(Array(stitchPaths.enumerated()), id: \.offset) { _, path in
                    path
                        .fill(.white)
//                        .fill(hasStitchShadow ? .clear : .white)
                        .shadow(color: .gray, radius: 2, x: 0, y: 2)
                }
            }
            .scaleEffect(0.9) // 外形の内側に寄せる
            .frame(width: rectangleSize.width, height: rectangleSize.height)
                
            // Parameter
            parameterController()
                .frame(width: rectangleSize.width * 0.7)
        }
        
    }

    @ViewBuilder
    private func parameterController() -> some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "angle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                Text(String(format: "%04.1f°", stitchLotationDegree))
                    .monospacedDigit()
                Slider(value: $stitchLotationDegree, in: 0.0...45)
            }
            HStack {
                Image(systemName: "ruler")
                    .scaledToFit()
                    .frame(width: 20)
                Text(String(format: "%04.1f", stitchLength))
                    .monospacedDigit()
                Slider(value: $stitchLength, in: 1...40)
            }
            HStack {
                Image(systemName: "space")
                    .scaledToFit()
                    .frame(width: 20)
                Text(String(format: "%04.1f", stitchSpaceLength))
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

// MARK: - Path

extension Path {
    /// Stitchのパスを作成
    static func createStitchPaths(
        rectSise: CGSize,
        cornerRadius: CGFloat,
        lineWidth: CGFloat = 4,
        dash: [CGFloat] = [10, 5],
        dashPhase: CGFloat = 0,
        rotationDegree: CGFloat = 30,
    ) -> [Path] {
        // 全体の流れ: Path -> CGPath -> [CGPath]に分割 -> [CGPath]の変形 -> [Path]
        
        // ベースとなる点線
        let baseDashPath: Path = Path(
            roundedRect: CGRect(
                origin: .zero,
                size: .init(
                    width: rectSise.width,
                    height: rectSise.height
                )
            ),
            cornerRadius: cornerRadius,
            style: .continuous
        )
        .strokedPath(
            .init(
                lineWidth: lineWidth,
                lineCap: .round,
                lineJoin: .round,
//                miterLimit: 1,
                dash: dash,
                dashPhase: dashPhase
            )
        )
        
        let baseDashCGPath: CGPath = baseDashPath.cgPath
        let baseDashCGPaths: [CGPath] = baseDashCGPath.componentsSeparated() // パスの分割
        let transFormedBaseDashCGPaths: [CGPath] = baseDashCGPaths.map { baseStitchCGPath in
            // 自身のCGPathの中心
            let rect = baseStitchCGPath.boundingBox
            let center = CGPoint(x: rect.midX, y: rect.midY)
            
            // 中心を軸に回転するための変換
            var transform = CGAffineTransform(translationX: center.x, y: center.y)
                .rotated(by: -rotationDegree.degreesToRadians) // (0, 0)を中心に回転
                .translatedBy(x: -center.x, y: -center.y) // 上記の補正
            
            let transformedDashCGPath = baseStitchCGPath.copy(using: &transform)!
            return transformedDashCGPath
        }
        // [CGPath] -> [Path]
        return transFormedBaseDashCGPaths.map { Path($0) }
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}
