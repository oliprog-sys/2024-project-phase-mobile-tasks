
# Flutter Authentication App

This is a Flutter application that demonstrates how Authentication works using **Bloc**, **mock remote data**, and **secure local storage** for tokens. The app includes **sign-up**, **sign-in** and **logout** functionalities.

## Features

**Sign up**: Create a new account with name, email and password
**Sign In**: Login using email and password
**Logout**: clear saved authentication and return to the log in page
**Block state management**: use flutter_bloc to manage authentication state

## How it works

1. **Sign Up**  
   - User enters `name`, `email`, and `password`.  
   - `SignUpRequested` event is dispatched to `AuthBloc`.  
   - `AuthBloc` calls `SignUpUsecase`, which uses a mock remote data source to simulate account creation.  
   - On success, a `SignUpSuccess` state is emitted.

2. **Sign up**
    - user enters `email` and `password`.
    - SignInRequested` event is dispatched to `AuthBloc`.
    - AuthBloc` calls `SignInUsecase`, which uses the mock remote data source.  
   - On success:
     - A `User` object is returned with a token.
     - Token is saved locally using `AuthLocalDataSource`.  
     - `Authenticated` state is emitted and the home page is displayed.

3. **Home Page / Logout**  
   - Shows user name and email from `Authenticated` state.  
   - Log Out button dispatches `SignOutRequested` event.  
   - `AuthBloc` calls `LogOutUsecase` to clear the token from local storage.  
   - `Unauthenticated` state is emitted, and the user is redirected to the login page.

4. **Token Storage**  
   - Tokens are securely stored in local storage (`flutter_secure_storage`) under the key `auth_token`.  
   - This allows checking login status on app start or after restarting the app.

## Dependencies

**flutter_bloc**: State management
**equatable**: Value comparison for Bloc states/events
**flutter_secure_storage**: Secure local storage for tokens
**http**: For API calls (even though currently mocked)


