<?php

use Illuminate\Support\Facades\Route;

// SPA entry point - all routes handled by Vue Router
Route::get('/{any}', function () {
    return view('app');
})->where('any', '.*');
