#!/bin/bash

# Script to customize the hacker theme
echo "🚀 Hacker Theme Customization Tool"
echo "=================================="

# Function to update CSS variables
update_color_scheme() {
    echo "🎨 Color Scheme Options:"
    echo "1. Classic Green (default)"
    echo "2. Blue Cyberpunk"
    echo "3. Red Alert"
    echo "4. Purple Neon"
    echo "5. Custom Colors"
    
    read -p "Choose a color scheme (1-5): " choice
    
    case $choice in
        1)
            echo "✅ Using Classic Green theme"
            ;;
        2)
            echo "🔵 Switching to Blue Cyberpunk..."
            sed -i.bak 's/#00ff41/#00bfff/g' assets/css/hacker-style.css
            sed -i.bak 's/#00cc33/#0099cc/g' assets/css/hacker-style.css
            sed -i.bak 's/#008f11/#006699/g' assets/css/hacker-style.css
            echo "✅ Blue theme applied!"
            ;;
        3)
            echo "🔴 Switching to Red Alert..."
            sed -i.bak 's/#00ff41/#ff4444/g' assets/css/hacker-style.css
            sed -i.bak 's/#00cc33/#cc3333/g' assets/css/hacker-style.css
            sed -i.bak 's/#008f11/#992222/g' assets/css/hacker-style.css
            echo "✅ Red theme applied!"
            ;;
        4)
            echo "🟣 Switching to Purple Neon..."
            sed -i.bak 's/#00ff41/#bf00ff/g' assets/css/hacker-style.css
            sed -i.bak 's/#00cc33/#9900cc/g' assets/css/hacker-style.css
            sed -i.bak 's/#008f11/#660099/g' assets/css/hacker-style.css
            echo "✅ Purple theme applied!"
            ;;
        5)
            echo "🎨 Custom color setup..."
            read -p "Enter primary color (hex, e.g., #ff6600): " primary
            read -p "Enter secondary color (hex, e.g., #cc5500): " secondary
            read -p "Enter dark color (hex, e.g., #994400): " dark
            
            sed -i.bak "s/#00ff41/$primary/g" assets/css/hacker-style.css
            sed -i.bak "s/#00cc33/$secondary/g" assets/css/hacker-style.css
            sed -i.bak "s/#008f11/$dark/g" assets/css/hacker-style.css
            echo "✅ Custom colors applied!"
            ;;
        *)
            echo "❌ Invalid choice"
            ;;
    esac
}

# Function to toggle effects
toggle_effects() {
    echo "⚡ Effect Options:"
    echo "1. Enable Matrix Rain"
    echo "2. Disable Matrix Rain"
    echo "3. Enable Glitch Effects"
    echo "4. Disable Glitch Effects"
    echo "5. Enable All Effects"
    echo "6. Disable All Effects"
    
    read -p "Choose an option (1-6): " effect_choice
    
    case $effect_choice in
        1)
            echo "🌧️ Matrix rain enabled"
            sed -i.bak 's/\/\/ createMatrixRain();/createMatrixRain();/' assets/js/hacker-effects.js
            ;;
        2)
            echo "🚫 Matrix rain disabled"
            sed -i.bak 's/createMatrixRain();/\/\/ createMatrixRain();/' assets/js/hacker-effects.js
            ;;
        5)
            echo "🎆 All effects enabled"
            sed -i.bak 's/\/\/ createMatrixRain();/createMatrixRain();/' assets/js/hacker-effects.js
            sed -i.bak 's/\/\/ initGlitchEffects();/initGlitchEffects();/' assets/js/hacker-effects.js
            ;;
        6)
            echo "🔇 All effects disabled"
            sed -i.bak 's/createMatrixRain();/\/\/ createMatrixRain();/' assets/js/hacker-effects.js
            sed -i.bak 's/initGlitchEffects();/\/\/ initGlitchEffects();/' assets/js/hacker-effects.js
            ;;
        *)
            echo "❌ Invalid choice"
            ;;
    esac
}

# Function to update ASCII art
update_ascii_art() {
    echo "🎭 ASCII Art Options:"
    echo "1. Keep current BAYMINE art"
    echo "2. Generate custom text"
    echo "3. Use minimal design"
    
    read -p "Choose an option (1-3): " ascii_choice
    
    case $ascii_choice in
        2)
            read -p "Enter your text (max 8 characters): " custom_text
            echo "🎨 You can generate ASCII art at: http://patorjk.com/software/taag/"
            echo "💡 Replace the ASCII art in index.md with your custom design"
            ;;
        3)
            echo "📝 Switching to minimal design..."
            # This would require more complex sed operations
            echo "💡 Manually edit the .ascii-art section in index.md"
            ;;
        *)
            echo "✅ Keeping current design"
            ;;
    esac
}

# Main menu
echo ""
echo "What would you like to customize?"
echo "1. Color Scheme"
echo "2. Visual Effects"
echo "3. ASCII Art"
echo "4. Restore Defaults"
echo "5. Exit"

read -p "Enter your choice (1-5): " main_choice

case $main_choice in
    1)
        update_color_scheme
        ;;
    2)
        toggle_effects
        ;;
    3)
        update_ascii_art
        ;;
    4)
        echo "🔄 Restoring defaults..."
        if [ -f "assets/css/hacker-style.css.bak" ]; then
            mv assets/css/hacker-style.css.bak assets/css/hacker-style.css
            echo "✅ CSS restored"
        fi
        if [ -f "assets/js/hacker-effects.js.bak" ]; then
            mv assets/js/hacker-effects.js.bak assets/js/hacker-effects.js
            echo "✅ JavaScript restored"
        fi
        echo "✅ Defaults restored!"
        ;;
    5)
        echo "👋 Goodbye!"
        exit 0
        ;;
    *)
        echo "❌ Invalid choice"
        ;;
esac

echo ""
echo "🎉 Customization complete!"
echo "💡 Test your changes with: bundle exec jekyll serve"
echo "📝 Commit your changes: git add . && git commit -m 'Customize hacker theme'"
