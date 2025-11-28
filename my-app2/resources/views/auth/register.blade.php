<x-layout>
    <h1>Register a new account</h1>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription</title>
    <link rel="stylesheet" href="{{ asset('css/styles.css') }}">
</head>
<body>
    <div class="form-container">
        <h2>Formulaire d'Inscription</h2>
        <form id="register-form" method="post" action="{{ route('register') }}" method= "post">
            @csrf
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="name" name="name" required>
            </div>
            
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" required>
            </div>
            
            <div class="form-group">
                <label for="password">password</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <div class="form-group">
                <label for="password_confirmation">password_confirm</label>
                <input type="password" id="password_confirmation" name="password_confirmation" required>
            </div>
            
            <button type="register">register</button>
        </form>
    </div>

    <script src="{{ asset('js/scripts.js') }}"></script>
</body>
</html>
</x-layout>

