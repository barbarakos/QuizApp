import SwiftUI

extension Text {

    func sectionHeaderStyle(_ section: CategorySection) -> some View {
        self
            .font(.system(size: 25))
            .fontWeight(.bold)
            .textCase(nil)
            .padding(.leading, 20)
            .foregroundColor(section.colorSwiftUI)
    }

}

