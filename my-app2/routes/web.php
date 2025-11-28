<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\VoitureController;

//Route::view('/',"posts.index")->name("home");

Route::view('/login', 'auth.login')->name('login');
Route::post('/login', [AuthController::class, 'login'])->name("login");

Route::redirect(uri: "/",destination: "voitures");
Route::resource(name: 'voitures', controller: VoitureController::class);



Route::view('/register', "auth.register")->name("register");
Route::post('/register', [AuthController::class, 'register']);

Route::view('/lagout', 'components.layout')->name('layout');
Route:: post('/lagout', [AuthController::class, 'lagout'])->name("lagout");