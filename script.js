function reveal() {
    var reveals = document.querySelectorAll(".reveal");
  
    for (var i = 0; i < reveals.length; i++) {
      var windowHeight = window.innerHeight;
      var elementTop = reveals[i].getBoundingClientRect().top;
      var elementVisible = 150;
  
      if (elementTop < windowHeight - elementVisible) {
        reveals[i].classList.add("active");
      } else {
        reveals[i].classList.remove("active");
      }
    }
  }
  
  window.addEventListener("scroll", reveal, {passive: true});

const images = document.querySelector(".gallery_images")

// images.addEventListener('click', () => {
//   alert('Clicked')
//     const modal = document.createElement("div")
//     const modalImage = document.createElement("img");
//     modalImage.src = images.img.src;
//     modalImage.style.cursor = "pointer"
//     modal.appendChild(modalImage)
// })

const galleryImages = document.querySelectorAll(".gallery_images img");

galleryImages.forEach(image => {
  image.addEventListener('click', (event) => {
    image.addEventListener('click', (event) => {
      // 1. Create modal elements
      const modal = document.createElement("div");
      modal.classList.add("modal"); // Add a class for styling
      const modalImage = document.createElement("img");
      modalImage.src = event.target.src; // Get source from clicked image
      modalImage.style.cursor = "pointer";
      const closeButton = document.createElement("button");
      closeButton.textContent = "Close";
      closeButton.classList.add("close-button"); // Add a class for styling
    
      // 2. Append elements to modal
      modal.appendChild(modalImage);
      modal.appendChild(closeButton);
    
      // 3. Display the modal (append to body)
      document.body.appendChild(modal);
    
      // 4. Close modal functionality (optional)
      closeButton.addEventListener('click', () => {
        document.body.removeChild(modal);


      
      });
    });
  });
});

