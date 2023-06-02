$(document).ready(function () {
  $(".headphones").on("click", function () {
    $(".video-list").toggleClass("display-none");
    $(".audio-list").toggleClass("display-block");
  });

  $(".record-audio").on("click", function () {
    $(".record-audio-container").toggleClass("display-block");
  });
  $(".text-to-speech").on("click", function () {
    $(".text-to-speech-container").toggleClass("display-block");
  });
});
