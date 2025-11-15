// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import * as ActiveStorage from "@rails/activestorage"
ActiveStorage.start()

import "@hotwired/turbo-rails"
import "controllers"

// event listener for smooth scrolling
// This will enable smooth scrolling for anchor links on the page
// It listens for clicks on links that start with '#' and scrolls to the target element smoothly
document.addEventListener("DOMContentLoaded", function () {
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener("click", function (e) {
      const target = document.querySelector(this.getAttribute("href"));
      if (target) {
        e.preventDefault();
        target.scrollIntoView({
          behavior: "smooth"
        });
      }
    });
  });
});

// Simple countdown timer (set your event date below)
document.addEventListener("DOMContentLoaded", function() {
  const eventDate = new Date("2025-11-17T17:00:00");
  function updateCountdown() {
    const now = new Date();
    const diff = eventDate - now;
    if (diff <= 0) return;
    const days = Math.floor(diff / (1000 * 60 * 60 * 24));
    const hours = Math.floor((diff / (1000 * 60 * 60)) % 24);
    const minutes = Math.floor((diff / (1000 * 60)) % 60);
    const seconds = Math.floor((diff / 1000) % 60);
    document.getElementById("days").textContent = String(days).padStart(2, '0');
    document.getElementById("hours").textContent = String(hours).padStart(2, '0');
    document.getElementById("minutes").textContent = String(minutes).padStart(2, '0');
    document.getElementById("seconds").textContent = String(seconds).padStart(2, '0');
  }
  setInterval(updateCountdown, 1000);
  updateCountdown();
});


document.addEventListener("turbo:load", () => {
  const btn = document.getElementById("cloudinary_upload_button");
  if (!btn) return;

  const widget = cloudinary.createUploadWidget({
    cloudName: "dera4cgch",
    uploadPreset: "wedding_unsigned",
    multiple: true,
    resourceType: "auto"
  }, (error, result) => {
    if (error) {
      console.error(error);
      return;
    }

    if (result.event === "success") {
      console.log("Uploaded:", result.info);

      // Enviamos la URL a Rails
      fetch("/albums/upload_direct", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
        },
        body: JSON.stringify({
          album_id: btn.dataset.albumId, // asegúrate de tener data-album-id en el botón
          file_url: result.info.secure_url
        })
      })
      .then(res => {
        if (!res.ok) throw new Error("Upload to Rails failed");
        console.log("File attached to album!");
        // Aquí podrías refrescar la galería si quieres
      })
      .catch(console.error);
    }
  });

  btn.addEventListener("click", function () {
    widget.open();
  });
});
