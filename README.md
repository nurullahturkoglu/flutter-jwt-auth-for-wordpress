# Flutter JWT Authentication for WordPress

A Flutter application that provides secure JWT-based authentication for WordPress sites. Built with modern Flutter practices and Material Design 3, this app enables users to register, log in, and access protected content through token-based authentication.

## Features

- JWT token-based authentication
- Modern Material Design 3 UI
- Secure token storage using `flutter_secure_storage`
- User data persistence with `shared_preferences`
- Protected routes with authentication middleware
- User registration and login functionality
- User profile management
- Automatic token validation and refresh

## Screenshots

### Login Screen

<img src="assets/images/login.png" alt="Login Screen" width="300" height="600"/>

### Register Screen

<img src="assets/images/register.png" alt="Register Screen" width="300" height="600"/>

### Home Screen

<img src="assets/images/home.png" alt="Home Screen" width="300" height="600"/>

### Profile Screen

<img src="assets/images/profile.png" alt="Profile Screen" width="300" height="600"/>

### Books Screen

<img src="assets/images/books.png" alt="Books Screen" width="300" height="600"/>

## Getting Started

### Prerequisites

- Flutter SDK (3.0.2 or higher)
- Dart SDK (3.0.2 or higher)
- Android Studio / Xcode (for mobile development)
- A WordPress site with JWT Authentication plugin installed

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/nurullahturkoglu/flutter-jwt-auth-for-wordpress.git
   cd flutter-jwt-auth-for-wordpress
   ```

2. Install dependencies:

   ```bash
   flutter pub get
   ```

3. Configure your WordPress API endpoint:

   Update the base URL in `lib/services/wordpress_auth_methods.dart`:

   ```dart
   static const String baseUrl = 'https://your-wordpress-site.com/';
   ```

4. Run the application:

   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── constants/
│   ├── app_routes.dart      # Route definitions
│   ├── app_strings.dart     # String constants
│   ├── api_constants.dart   # API endpoints and keys
│   ├── storage_keys.dart   # Storage key constants
│   └── fonts.dart          # Typography styles
├── models/
│   └── user_model.dart     # User data model
├── pages/
│   └── view/
│       ├── login_page.dart
│       ├── register_page.dart
│       ├── home_page.dart
│       ├── profile_page.dart
│       └── books_page.dart
├── services/
│   ├── wordpress_auth_methods.dart
│   ├── manage_secure_storage.dart
│   └── manage_shared_preferences.dart
└── widgets/
    └── auth_middleware.dart
```

## Usage

### Authentication Middleware

The `auth_middleware.dart` widget wraps protected pages and automatically validates user tokens. If validation fails, users are redirected to the login page.

```dart
AuthMiddleware(
  child: HomePage(),
)
```

### WordPress Authentication

The app integrates with WordPress using the JWT Authentication plugin. User credentials are sent to your WordPress site, and upon successful authentication, a JWT token is returned and securely stored.

#### Login Response

After successful login, you'll receive a response like this:

```json
{
  "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9...",
  "user_id": "13",
  "user_email": "user@example.com",
  "user_nicename": "username",
  "user_display_name": "Display Name",
  "user_role": "subscriber"
}
```

#### Token Validation

The app validates tokens before accessing protected routes. A valid token response looks like:

```json
{
  "code": "jwt_auth_valid_token",
  "data": {
    "status": 200,
    "user_id": "13"
  }
}
```

### WordPress Plugin Configuration

⚠️ **Important**: This app requires modifications to the JWT Authentication plugin. You'll need to edit the `jwt-authentication-for-wp-rest-api/public/class-jwt-auth-public.php` file from the [Tmeister/wp-api-jwt-auth](https://github.com/Tmeister/wp-api-jwt-auth) repository.

Add the following code snippets to the `generate_token` function:

```php
'user_id'   => $user->data->ID,
'user_role' => $user->roles[0],
```

With these modifications, you'll receive a complete response after successful login that includes user ID and role information.

For token validation, add the following to the `validate_token` function:

```php
'data' => [
    'status' => 200,
    'user_id' => $token->data->user->id,
],
```

This modification allows the app to efficiently retrieve the user ID during token validation.

### User Registration

To enable user registration, add this route to your WordPress plugin:

```php
register_rest_route($this->namespace, '/register', array(
    'methods'             => 'POST',
    'callback'            => array($this, 'create_user'),
    'permission_callback' => '__return_true',
));
```

And implement the `create_user` function:

```php
function create_user($request) {
    $params = $request->get_params();
    $username = sanitize_text_field($params['username']);
    $password = sanitize_text_field($params['password']);

    $existing_user = get_user_by('login', $username);
    if ($existing_user) {
        return array(
            'status'  => 'error',
            'message' => 'The username is already taken.',
        );
    }

    $user_id = wp_create_user($username, $password);

    if (!is_wp_error($user_id)) {
        return array(
            'status'  => 'success',
            'message' => 'User created successfully.',
            'user_id' => $user_id,
        );
    }

    return array(
        'status'  => 'error',
        'message' => 'Failed to create user.',
    );
}
```

## Architecture

The application follows a clean architecture pattern with separation of concerns:

- **Constants**: Centralized configuration and string management
- **Models**: Data structures for API responses
- **Services**: Business logic and API communication
- **Pages**: UI components and user interactions
- **Widgets**: Reusable UI components

## Dependencies

- `dio`: HTTP client for API requests
- `flutter_secure_storage`: Secure token storage
- `shared_preferences`: User data persistence

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. When contributing:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Credits

This project uses [TMeister JWT Auth](https://github.com/Tmeister/wp-api-jwt-auth) for WordPress JWT token generation and verification.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
