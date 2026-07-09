(function () {
  var slider = document.querySelector(".photo-slider");
  if (!slider) {
    return;
  }

  var mainImage = slider.querySelector(".photo-slider-main");
  var previousButton = slider.querySelector(".photo-slider-prev");
  var nextButton = slider.querySelector(".photo-slider-next");
  var thumbs = Array.prototype.slice.call(slider.querySelectorAll(".photo-thumb"));
  var currentIndex = 0;

  function showPhoto(index) {
    currentIndex = (index + thumbs.length) % thumbs.length;
    var activeThumb = thumbs[currentIndex];
    var src = activeThumb.getAttribute("data-src");

    mainImage.src = src;
    mainImage.alt = "Photo " + (currentIndex + 1);

    thumbs.forEach(function (thumb) {
      thumb.classList.remove("is-active");
    });

    activeThumb.classList.add("is-active");
    activeThumb.scrollIntoView({ behavior: "smooth", block: "nearest", inline: "center" });
  }

  previousButton.addEventListener("click", function () {
    showPhoto(currentIndex - 1);
  });

  nextButton.addEventListener("click", function () {
    showPhoto(currentIndex + 1);
  });

  thumbs.forEach(function (thumb, index) {
    thumb.addEventListener("click", function () {
      showPhoto(index);
    });
  });

  document.addEventListener("keydown", function (event) {
    if (event.key === "ArrowLeft") {
      showPhoto(currentIndex - 1);
    }
    if (event.key === "ArrowRight") {
      showPhoto(currentIndex + 1);
    }
  });
})();
