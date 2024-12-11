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

images.addEventListener('click', () => {
  alert('Clicked')
    const modal = document.createElement("div")
    const modalImage = document.createElement("img");
    modalImage.src = images.img;
    modalImage.style.cursor = "pointer"
    modal.appendChild(modalImage)
})



imageContainerGirl.forEach(image => {
    console.log("Girl")
    const galleryImages = document.createElement("img");
    galleryImages.src = image.image;
    galleryImages.style.cursor = "pointer"
    imageContainerGirl.appendChild(galleryImages)

    const modal = document.createElement("div")
    const modalImage = document.createElement("img");
    modalImage.src = image.image;
    modalImage.style.cursor = "pointer"
    modal.appendChild(modalImage)
    
    
    const close = document.createElement("span")
    close.classList.add("close")
    close.innerText = "X"
    modal.appendChild(close)

    imageContainerGirl.addEventListener('click', () => {
        close.style.display = "block"
        modal.classList.add("modal")
        modal.style.display = "flex"
        modalImage.classList.add("modal_image")
        imageContainerGirl.appendChild(modal)

        close.addEventListener('click', () => {
            // modal.style.display = "none";
            modal.classList.remove("modal")
            modal.style.display = "none"
            close.style.display = "none"
        })
    })
})