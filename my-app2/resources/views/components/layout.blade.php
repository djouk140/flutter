<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Commerce</title>
    <body>
        <a href="{{route(name: 'register')}}"> Register </a>
        <a href="{{route('login')}}">Login</a>
        <h1> Hello</h1>
        <main> 
            {{$slot}}
        </main>
  </body>
</head>  