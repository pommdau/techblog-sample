import SwiftUI

struct TrayView: View {
    var width: CGFloat
    var height: CGFloat
    var depth: CGFloat
    var cornerRadius: CGFloat
    var color: Color
    
    var body: some View {
        ZStack {
            Color.white
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(
                    color
                        .shadow(
                            ShadowStyle.inner(color: .white, radius: 6, x: 0, y: 2)
                        )
                        .shadow(
                            ShadowStyle.inner(color: .black.opacity(0.8), radius: 6, x: 0, y: -2)
                        )
                )
                .frame(width: width, height: height)
//                .mask {
//                    ZStack {
//                        Color.white
//                        Image(systemName: "figure.and.child.holdinghands")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: width * 0.8, height: height * 0.8)
//                            .foregroundColor(.black)
//                    }
//                    .compositingGroup()
//                    .luminanceToAlpha()   //← 白を表示、黒を透過に変換！(Viewの色が明るければ明るいほど、Viewが透明になる)                }
//                }
            
            ZStack {
                Image(systemName: "figure.and.child.holdinghands")
                    .resizable()
                    .scaledToFit()
                    .frame(width: width * 0.8, height: height * 0.8)
                    .foregroundStyle(
                        .red
                            .shadow(
                                ShadowStyle.drop(color: .black, radius: 2, x: 0, y: -2)
                            )
                            .shadow(
                                ShadowStyle.drop(color: .white, radius: 2, x: 0, y: 2)
                            )
                        // 凹み
                            .shadow(
                                ShadowStyle.inner(color: .black, radius: 2, x: 0, y: 4)
                            )
                    )
            }
        }
    }
}
 
#Preview {
    VStack {
        TrayView(
            width: 300,
            height: 300,
            depth: -10,
            cornerRadius: 40,
            color: .blue
        )
    }
}

