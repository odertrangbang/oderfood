#!/bin/bash

# 🚀 ShippFR Food Delivery App - Auto Setup Script
# Developed by Sâu - Flutter Expert

echo "🚀 ShippFR Food Delivery App - Auto Setup"
echo "=========================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# Check if Flutter is installed
check_flutter() {
    print_info "Checking Flutter installation..."
    if command -v flutter &> /dev/null; then
        FLUTTER_VERSION=$(flutter --version | head -n 1)
        print_status "Flutter found: $FLUTTER_VERSION"
        return 0
    else
        print_error "Flutter not found! Please install Flutter first."
        print_info "Visit: https://flutter.dev/docs/get-started/install"
        return 1
    fi
}

# Check if we're in the right directory
check_directory() {
    if [ -f "pubspec.yaml" ] && [ -d "lib" ]; then
        print_status "Found Flutter project in current directory"
        return 0
    else
        print_error "Please run this script from the shippr_food_delivery directory"
        print_info "cd shippr_food_delivery && ./setup.sh"
        return 1
    fi
}

# Install dependencies
install_dependencies() {
    print_info "Installing Flutter dependencies..."
    if flutter pub get; then
        print_status "Dependencies installed successfully"
        return 0
    else
        print_error "Failed to install dependencies"
        return 1
    fi
}

# Check for google-services.json
check_firebase_config() {
    if [ -f "android/app/google-services.json" ]; then
        print_status "Firebase configuration found"
        return 0
    else
        print_warning "Firebase configuration not found"
        print_info "Please add google-services.json to android/app/"
        print_info "1. Go to https://console.firebase.google.com"
        print_info "2. Create project 'ShippFR'"
        print_info "3. Add Android app with package: com.shippr.food_delivery"
        print_info "4. Download google-services.json to android/app/"
        return 1
    fi
}

# Create necessary directories
create_directories() {
    print_info "Creating necessary directories..."
    
    mkdir -p assets/images
    mkdir -p assets/icons
    mkdir -p fonts
    
    print_status "Directories created"
}

# Clean and rebuild
clean_project() {
    print_info "Cleaning project..."
    flutter clean
    flutter pub get
    print_status "Project cleaned and rebuilt"
}

# Run the app
run_app() {
    print_info "Starting the app..."
    print_warning "Make sure you have an emulator running or device connected"
    
    read -p "Do you want to run the app now? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        flutter run
    else
        print_info "You can run the app later with: flutter run"
    fi
}

# Main setup function
main() {
    echo
    print_info "Starting ShippFR setup process..."
    echo
    
    # Check Flutter installation
    if ! check_flutter; then
        exit 1
    fi
    
    # Check if we're in the right directory
    if ! check_directory; then
        exit 1
    fi
    
    # Create directories
    create_directories
    
    # Install dependencies
    if ! install_dependencies; then
        exit 1
    fi
    
    # Check Firebase config
    check_firebase_config
    
    # Clean project
    clean_project
    
    echo
    print_status "Setup completed successfully! 🎉"
    echo
    print_info "Next steps:"
    echo "1. Setup Firebase project (if not done)"
    echo "2. Add Google Maps API key (optional)"
    echo "3. Run: flutter run"
    echo
    
    # Optionally run the app
    run_app
}

# Run main function
main