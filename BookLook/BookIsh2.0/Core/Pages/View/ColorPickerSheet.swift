//
//  ColorPickerSheet.swift
import SwiftUI

struct ColorPickerSheet: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedColor: Color = .white // Default color
    var delegate: BackgroundColorDelegate?

    var body: some View {
        VStack {
            Text("Choose a Background Color")
                .font(.headline)
                .padding()

            ColorPicker("Select Color", selection: $selectedColor)
                .padding()

            Button("Apply Color") {
                delegate?.didSelectBackgroundColor(selectedColor)
                dismiss()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}
