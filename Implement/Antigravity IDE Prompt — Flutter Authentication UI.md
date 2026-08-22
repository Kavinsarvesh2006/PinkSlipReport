# Build a Modern Flutter Mobile Authentication UI

You are a senior Flutter UI/UX developer. Build a production-quality mobile authentication module in the existing Flutter project.

Use the attached reference image as the primary visual design inspiration. Recreate the same overall visual language, spacing, card layout, typography, colors, illustrations, input fields, buttons, and navigation behavior while making the implementation clean, responsive, maintainable, and suitable for a production application.

## Technology Requirements

- Framework: Flutter
- Language: Dart
- Target: Android mobile application
- Use Material 3 where appropriate
- Follow clean Flutter architecture and reusable widgets
- Do NOT create a separate project
- Work inside the existing Flutter project
- Keep the project compatible with Android Studio
- The UI must work correctly on different Android screen sizes
- Avoid hardcoded screen dimensions
- Use responsive layouts
- Keep UI code separate from business logic

## Authentication Screens

Create these three screens:

1. Sign In
2. Sign Up
3. Forgot Password

---

## 1. Sign In Screen

Recreate the left-side design from the reference image.

### Layout

Use a light gray/white background with a centered rounded authentication card.

The card should contain:

- Top illustration area
- "Sign In" heading
- Short subtitle:
  "Enter valid user name & password to continue"
- Username input field
- Password input field
- "Forgot password?" clickable text
- Primary "Login" button
- Divider with:
  "Or Continue with"
- Google login button
- Facebook login button
- Bottom text:
  "Haven't any account? Sign up"

### Input Fields

Username:
- User/person icon
- Hint: "User name"
- Rounded border
- Comfortable padding
- Light background
- Focus state

Password:
- Lock icon
- Hint: "Password"
- Password visibility toggle
- Rounded border
- Secure text entry

### Login Button

Use a modern blue primary button.

Requirements:

- Full width
- Rounded corners
- Blue background
- White text
- Subtle elevation/shadow
- Loading state
- Disabled state

---

## 2. Sign Up Screen

Recreate the center design from the reference image.

Display:

- Top illustration
- "Sign Up" heading
- Subtitle:
  "Use proper information to continue"

Input fields:

1. Full name
2. Email address
3. Password

Password must include a visibility toggle.

Below the fields display:

"By signing up, you are agree to our Terms & Conditions and Privacy Policy"

Make "Terms & Conditions" and "Privacy Policy" clickable.

Primary button:

"Create Account"

At the bottom:

"Already have an Account? Sign in"

Clicking "Sign in" should navigate back to the Sign In screen.

---

## 3. Forgot Password Screen

Recreate the right-side design from the reference image.

Display:

- Top illustration
- "Forget Password" heading
- Subtitle:
  "Don't worry it happens. Please enter the address associate with your account"

Email input:

- Email icon
- Hint: "Email address"
- Email validation

Primary button:

"Send OTP"

After pressing Send OTP:

- Validate email
- Show loading state
- Prepare the screen flow for OTP verification
- Display appropriate success/error feedback

Bottom text:

"You remember your password? Sign in"

Clicking "Sign in" returns to the Sign In screen.

---

# Visual Design

Follow the reference image closely.

## Color Palette

Primary:
- Modern blue similar to #1268F3

Background:
- Very light gray / blue-gray

Cards:
- White or slightly translucent white

Text:
- Dark navy/blue

Secondary text:
- Muted gray-blue

Input borders:
- Very light blue-gray

Use colors consistently through a centralized theme.

Do not scatter color values throughout the code.

Create a centralized ThemeData configuration.

---

# UI Style

The application should have a modern SaaS/mobile-app authentication appearance.

Use:

- Rounded cards
- Rounded input fields
- Soft shadows
- Generous whitespace
- Clean typography
- Blue primary CTA buttons
- Minimal visual clutter
- Smooth animations
- Consistent icon sizes
- Consistent spacing

The design should feel similar to the uploaded reference image without copying any copyrighted illustration assets.

For illustrations, use suitable local/vector placeholders or Flutter-compatible illustration assets.

---

# Responsive Design

The application must adapt to:

- Small Android phones
- Large Android phones
- Different aspect ratios
- Portrait orientation

Use:

- SafeArea
- LayoutBuilder where appropriate
- SingleChildScrollView for forms
- Flexible/Expanded where appropriate
- Responsive padding
- Avoid fixed pixel positioning

The keyboard must not hide input fields or buttons.

When the keyboard opens, the form should remain usable.

---

# Navigation

Implement clean navigation between authentication screens.

Required navigation:

Sign In
→ Forgot Password

Sign In
→ Sign Up

Sign Up
→ Sign In

Forgot Password
→ Sign In

Use Flutter's recommended navigation approach and keep navigation logic maintainable.

---

# Form Validation

Implement proper client-side validation.

Username:
- Required

Full Name:
- Required
- Minimum reasonable length

Email:
- Required
- Valid email format

Password:
- Required
- Minimum 8 characters

Display validation messages clearly below the corresponding fields.

Do not allow invalid forms to submit.

---

# Authentication Architecture

Prepare the authentication module so it can later connect to a Java Spring Boot backend.

The Flutter application should NOT contain backend/database logic.

Create a service/repository structure such as:

lib/
├── core/
│   ├── theme/
│   ├── constants/
│   └── utils/
│
├── features/
│   └── authentication/
│       ├── data/
│       ├── domain/
│       └── presentation/
│
├── services/
│
└── main.dart

Create reusable components such as:

- CustomTextField
- PasswordTextField
- PrimaryButton
- SocialLoginButton
- AuthCard
- LoadingButton

Keep widgets reusable.

---

# Backend Integration Preparation

The backend will eventually use:

- Java
- Spring Boot
- PostgreSQL
- REST API
- JWT authentication

Prepare the Flutter code so authentication API integration can be added without redesigning the UI.

Create an authentication service interface with methods conceptually equivalent to:

- login()
- register()
- forgotPassword()
- verifyOtp()
- resetPassword()

Do not implement fake backend functionality unless required for UI testing.

Use clear TODO markers where API integration will be connected.

---

# Security

Follow secure authentication practices.

- Never store plain-text passwords locally
- Do not hardcode credentials
- Do not hardcode JWT tokens
- Keep API configuration separate
- Prepare secure token storage
- Validate user input
- Handle authentication errors safely

---

# Animations

Add subtle professional animations:

- Screen transition animation
- Button loading animation
- Input focus animation
- Card fade/slide animation

Animations should be fast and subtle.

Do not over-animate the interface.

---

# Error Handling

Create user-friendly error states for:

- Invalid credentials
- Invalid email
- Empty fields
- Network failure
- Server error
- OTP failure
- Registration failure

Use SnackBar or appropriate inline error messages.

Avoid exposing technical stack traces to users.

---

# Code Quality

Follow these rules:

- Write clean Dart code
- Use meaningful class and variable names
- Avoid duplicate UI code
- Create reusable widgets
- Keep files reasonably small
- Add comments only where useful
- Avoid unnecessary packages
- Follow Flutter/Dart best practices
- Ensure null safety
- Ensure the project compiles without errors
- Run Flutter analyzer
- Fix all analyzer errors and warnings that are introduced by your implementation

---

# Final UI Goal

The final application should visually resemble the uploaded reference:

SIGN IN
→ modern centered authentication card
→ illustration
→ heading
→ username/password
→ forgot password
→ blue Login button
→ social login
→ Sign Up navigation

SIGN UP
→ illustration
→ registration fields
→ Terms & Conditions
→ Create Account
→ Sign In navigation

FORGOT PASSWORD
→ illustration
→ email field
→ Send OTP
→ Sign In navigation

The result must look polished enough for a real production mobile application rather than a basic Flutter demo.

Before finishing:

1. Inspect the existing Flutter project structure.
2. Reuse existing project configuration where possible.
3. Do not create a second Flutter project.
4. Implement the authentication UI.
5. Ensure all three screens are connected.
6. Ensure the UI is responsive.
7. Run `flutter analyze`.
8. Fix errors introduced by the implementation.
9. Run the application and verify the authentication flow.
10. Keep the implementation ready for future Java Spring Boot + PostgreSQL + JWT API integration.