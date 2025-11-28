<x-layout>
    <h1 class="title">Bienvenue sur le site des voitures</h1>
    @auth
            <h1> Logged user {{auth()->user()->name}}
    @endauth

    @guest
            <h1>Liste des voitures </h1>
    @endguest
    

    <h1></h1>
        @foreach ($voitures as $voiture )
            <h2> {{$voiture->marque}}</h2>
            <h2> {{$voiture->vitesse}}</h2>
        @endforeach
</x-layout>
