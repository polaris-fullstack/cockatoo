// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "trix"
import "@rails/actiontext"
import "channels"
import "controllers";
import "flowbite"; // Temporarily commented out to fix JS loading issue

import "src"

import LocalTime from "local-time"
LocalTime.start()
