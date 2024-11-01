import SwiftUI

struct CardWidgetView<Content: View>: View {
    
    let content: Content
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.2)
            content
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding()
    }
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
}

#Preview {

    NavigationStack {
        Group {
            List {
                CardWidgetView {
                    Text("Hello World!")
                }
                CardWidgetView {
                    Text("Hello World!")
                }
                CardWidgetView {
                    Text("Hello World!")
                }
                CardWidgetView {
                    Text("Hello World!")
                }
            }
        }
        .navigationTitle("Widget")
    }
}
