'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "index.html": "6dafbac47cfb9812fe45d7f35d0475f5",
"/": "6dafbac47cfb9812fe45d7f35d0475f5",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"assets/assets/fonts/raleway_regular.otf": "a9ee3958efed8e067a30a930acdbd240",
"assets/assets/fonts/raleway_bold.otf": "244be40721eb433d88f76217952fd125",
"assets/assets/fonts/raleway_italic.otf": "28b3a87f6d6aef2382e0381709fd2dd2",
"assets/assets/images/profile.png": "b12608f35e80b280e5a8f5582bf44673",
"assets/FontManifest.json": "e4a867829087477bd3b8009f15a7e554",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/AssetManifest.json": "a0530f61a3e2572252840b96ed9a6ae7",
"assets/LICENSE": "ea379252185d071e894dcaa69bd59280",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"main.dart.js": "379bc3b48a2fe82ccf6a17f991c2b943",
"manifest.json": "557461b0bf7c545fc2cb824b29a134ef",
"CNAME": "441ca8a0a0457ec53cf51c899a46aba5"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
  );
});
