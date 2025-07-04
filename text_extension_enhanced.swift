import SwiftUI

public extension Text {
    
    // MARK: - Original Static Methods (iOS 15 Compatible)
    
    /// Creates a new `Text` view with the given string and styles it with a `title` identifier
    /// - Parameters:
    ///   - text: The string to use to initialize the `Text` view
    ///   - fontSize: Optional custom font size
    ///   - letterSpacing: Optional custom letter spacing (tracking)
    ///   - paragraphSpacing: Optional custom paragraph spacing
    /// - Returns: A view wrapped in the `title` style
    @ViewBuilder static func title(
        _ text: String,
        fontSize: CGFloat? = nil,
        letterSpacing: CGFloat? = nil,
        paragraphSpacing: CGFloat? = nil
    ) -> some View {
        Text(text).style(
            "title",
            fontSize: fontSize,
            letterSpacing: letterSpacing,
            paragraphSpacing: paragraphSpacing
        )
    }
    
    /// Creates a new `Text` view with the given string and styles it with a `subtitle` identifier
    /// - Parameters:
    ///   - text: The string to use to initialize the `Text` view
    ///   - fontSize: Optional custom font size
    ///   - letterSpacing: Optional custom letter spacing (tracking)
    ///   - paragraphSpacing: Optional custom paragraph spacing
    /// - Returns: A view wrapped in the `subtitle` style
    @ViewBuilder static func subtitle(
        _ text: String,
        fontSize: CGFloat? = nil,
        letterSpacing: CGFloat? = nil,
        paragraphSpacing: CGFloat? = nil
    ) -> some View {
        Text(text).style(
            "subtitle",
            fontSize: fontSize,
            letterSpacing: letterSpacing,
            paragraphSpacing: paragraphSpacing
        )
    }
    
    /// Creates a new `Text` view with the given string and styles it with a `body` identifier
    /// - Parameters:
    ///   - text: The string to use to initialize the `Text` view
    ///   - fontSize: Optional custom font size
    ///   - letterSpacing: Optional custom letter spacing (tracking)
    ///   - paragraphSpacing: Optional custom paragraph spacing
    /// - Returns: A view wrapped in the `body` style
    @ViewBuilder static func body(
        _ text: String,
        fontSize: CGFloat? = nil,
        letterSpacing: CGFloat? = nil,
        paragraphSpacing: CGFloat? = nil
    ) -> some View {
        Text(text).style(
            "body",
            fontSize: fontSize,
            letterSpacing: letterSpacing,
            paragraphSpacing: paragraphSpacing
        )
    }
    
    // MARK: - Enhanced Style Method (iOS 15 Compatible)
    
    /// Applies typography style to the text with customizable parameters
    /// - Parameters:
    ///   - style: The style identifier string
    ///   - fontSize: Optional custom font size
    ///   - letterSpacing: Optional custom letter spacing (tracking)
    ///   - paragraphSpacing: Optional custom paragraph spacing
    /// - Returns: A styled Text view
    @ViewBuilder func style(
        _ style: String,
        fontSize: CGFloat? = nil,
        letterSpacing: CGFloat? = nil,
        paragraphSpacing: CGFloat? = nil
    ) -> some View {
        // Get default values based on style
        let defaultValues = getDefaultValues(for: style)
        
        VStack(alignment: .leading, spacing: 0) {
            self
                .font(.system(
                    size: fontSize ?? defaultValues.fontSize,
                    weight: defaultValues.fontWeight,
                    design: .default
                ))
                .tracking(letterSpacing ?? defaultValues.letterSpacing)
                .lineSpacing(defaultValues.lineSpacing)
            
            // Add paragraph spacing using a Spacer
            if paragraphSpacing ?? defaultValues.paragraphSpacing > 0 {
                Spacer()
                    .frame(height: paragraphSpacing ?? defaultValues.paragraphSpacing)
            }
        }
    }
    
    // MARK: - Advanced Customization Methods (iOS 15 Compatible)
    
    /// Applies typography style with font customization
    /// - Parameters:
    ///   - style: The style identifier string
    ///   - font: Custom font to use
    ///   - letterSpacing: Optional custom letter spacing
    ///   - paragraphSpacing: Optional custom paragraph spacing
    /// - Returns: A styled Text view with custom font
    @ViewBuilder func style(
        _ style: String,
        font: Font,
        letterSpacing: CGFloat? = nil,
        paragraphSpacing: CGFloat? = nil
    ) -> some View {
        let defaultValues = getDefaultValues(for: style)
        
        VStack(alignment: .leading, spacing: 0) {
            self
                .font(font)
                .tracking(letterSpacing ?? defaultValues.letterSpacing)
                .lineSpacing(defaultValues.lineSpacing)
            
            if paragraphSpacing ?? defaultValues.paragraphSpacing > 0 {
                Spacer()
                    .frame(height: paragraphSpacing ?? defaultValues.paragraphSpacing)
            }
        }
    }
    
    /// Applies typography style with all customizable parameters
    /// - Parameters:
    ///   - style: The style identifier string
    ///   - fontSize: Optional custom font size
    ///   - fontWeight: Optional custom font weight
    ///   - letterSpacing: Optional custom letter spacing
    ///   - lineSpacing: Optional custom line spacing
    ///   - paragraphSpacing: Optional custom paragraph spacing
    /// - Returns: A fully customized styled Text view
    @ViewBuilder func style(
        _ style: String,
        fontSize: CGFloat? = nil,
        fontWeight: Font.Weight? = nil,
        letterSpacing: CGFloat? = nil,
        lineSpacing: CGFloat? = nil,
        paragraphSpacing: CGFloat? = nil
    ) -> some View {
        let defaultValues = getDefaultValues(for: style)
        
        VStack(alignment: .leading, spacing: 0) {
            self
                .font(.system(
                    size: fontSize ?? defaultValues.fontSize,
                    weight: fontWeight ?? defaultValues.fontWeight,
                    design: .default
                ))
                .tracking(letterSpacing ?? defaultValues.letterSpacing)
                .lineSpacing(lineSpacing ?? defaultValues.lineSpacing)
            
            if paragraphSpacing ?? defaultValues.paragraphSpacing > 0 {
                Spacer()
                    .frame(height: paragraphSpacing ?? defaultValues.paragraphSpacing)
            }
        }
    }
    
    // MARK: - Private Helper Methods
    
    private func getDefaultValues(for style: String) -> (
        fontSize: CGFloat,
        fontWeight: Font.Weight,
        letterSpacing: CGFloat,
        lineSpacing: CGFloat,
        paragraphSpacing: CGFloat
    ) {
        switch style {
        case "title":
            return (fontSize: 28, fontWeight: .bold, letterSpacing: 0, lineSpacing: 4, paragraphSpacing: 16)
        case "subtitle":
            return (fontSize: 18, fontWeight: .medium, letterSpacing: 0.15, lineSpacing: 2, paragraphSpacing: 12)
        case "body":
            return (fontSize: 16, fontWeight: .regular, letterSpacing: 0.5, lineSpacing: 4, paragraphSpacing: 8)
        default:
            return (fontSize: 16, fontWeight: .regular, letterSpacing: 0, lineSpacing: 0, paragraphSpacing: 0)
        }
    }
}

// MARK: - Usage Examples (iOS 15 Compatible)
@available(iOS 15.0, *)
struct TextExtensionExamples: View {
    @State private var customFontSize: CGFloat = 16
    @State private var customLetterSpacing: CGFloat = 0
    @State private var customParagraphSpacing: CGFloat = 8
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // Basic usage (original functionality)
                VStack(alignment: .leading, spacing: 8) {
                    Text.title("Title Text")
                    Text.subtitle("Subtitle Text")
                    Text.body("Body Text")
                }
                
                Divider()
                
                // With custom font size
                VStack(alignment: .leading, spacing: 8) {
                    Text.title("Custom Size Title", fontSize: 32)
                    Text.subtitle("Custom Size Subtitle", fontSize: 20)
                    Text.body("Custom Size Body", fontSize: 18)
                }
                
                Divider()
                
                // With custom letter spacing
                VStack(alignment: .leading, spacing: 8) {
                    Text.title("Spaced Title", letterSpacing: 2.0)
                    Text.subtitle("Spaced Subtitle", letterSpacing: 1.5)
                    Text.body("Spaced Body", letterSpacing: 1.0)
                }
                
                Divider()
                
                // With custom paragraph spacing
                VStack(alignment: .leading, spacing: 8) {
                    Text.title("Title with Custom Spacing", paragraphSpacing: 24)
                    Text.subtitle("Subtitle with Custom Spacing", paragraphSpacing: 18)
                    Text.body("Body with Custom Spacing", paragraphSpacing: 12)
                }
                
                Divider()
                
                // All custom parameters
                VStack(alignment: .leading, spacing: 8) {
                    Text.title(
                        "Fully Custom Title",
                        fontSize: 30,
                        letterSpacing: 1.0,
                        paragraphSpacing: 20
                    )
                    
                    Text.subtitle(
                        "Fully Custom Subtitle",
                        fontSize: 22,
                        letterSpacing: 0.8,
                        paragraphSpacing: 15
                    )
                    
                    Text.body(
                        "Fully Custom Body",
                        fontSize: 19,
                        letterSpacing: 0.6,
                        paragraphSpacing: 10
                    )
                }
                
                Divider()
                
                // Using style method directly
                VStack(alignment: .leading, spacing: 8) {
                    Text("Direct Style Usage")
                        .style("title", fontSize: 24, letterSpacing: 0.5)
                    
                    Text("Advanced Style Usage")
                        .style(
                            "body",
                            fontSize: 17,
                            fontWeight: .semibold,
                            letterSpacing: 1.2,
                            lineSpacing: 6,
                            paragraphSpacing: 14
                        )
                }
                
                Divider()
                
                // Interactive example
                VStack(alignment: .leading, spacing: 16) {
                    Text("Interactive Customization:")
                        .font(.headline)
                        .padding(.bottom, 8)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Font Size: \(Int(customFontSize))")
                            Slider(value: $customFontSize, in: 12...36, step: 1)
                        }
                        
                        HStack {
                            Text("Letter Spacing: \(customLetterSpacing, specifier: "%.1f")")
                            Slider(value: $customLetterSpacing, in: -2...4, step: 0.1)
                        }
                        
                        HStack {
                            Text("Paragraph Spacing: \(Int(customParagraphSpacing))")
                            Slider(value: $customParagraphSpacing, in: 0...32, step: 1)
                        }
                    }
                    
                    Text.body(
                        "Interactive Text Sample",
                        fontSize: customFontSize,
                        letterSpacing: customLetterSpacing,
                        paragraphSpacing: customParagraphSpacing
                    )
                }
            }
            .padding()
        }
    }
}

// MARK: - Preview
@available(iOS 15.0, *)
struct TextExtensionExamples_Previews: PreviewProvider {
    static var previews: some View {
        TextExtensionExamples()
    }
}