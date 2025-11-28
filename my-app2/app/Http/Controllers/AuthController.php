<?php

namespace App\Http\Controllers;
use App\Models\User;

use Illuminate\Http\Request;

class AuthController extends Controller
{
   public function register(Request $request) {

    //validation
       $fields= $request ->validate(rules:[
        'name' => ['required','max:255'],
        'email'=> ['required','email','unique:users'],
        'password'=> ['required', 'confirmed', 'min:3']
       ]);

       // Register
    $user = User::create(attributes: $fields);

    //login
    //Auth:login($user);

    //redirect
    return redirect() ->route('index');
    //return redirect() ->
  }

  public function login(Request $request){
    //Validation
    $fields = $request->validate([
      'email' => ['required', 'email'],
      'password' => ['required']
    ]);

    //Try to login the user
    if(Auth::attempt($fields,$request->remember)){
      return redirect()->intended();
    }else{
      return back()->withErrors([
         'failed' => 'Not records'
      ]
      );
    }

  }
   
  
}
