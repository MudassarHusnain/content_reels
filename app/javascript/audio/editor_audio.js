$(document).ready(function () {
  $('.fa-headphones').on('click', function () {
    $(".video-list").removeClass("display-block").addClass("display-none")
    $(".audio-list").removeClass("display-none").addClass("display-block")
    $(".text-list").removeClass("display-block").addClass("display-none")
    $(".image-list").removeClass("display-block").addClass("display-none")

  });

  $('.fa-clipboard').on('click', function () {
    $(".video-list").removeClass("display-block").addClass("display-none")
    $(".audio-list ").removeClass("display-block").addClass("display-none")
    $(".image-list").removeClass("display-none").addClass("display-block")
    $(".text-list").removeClass("display-block").addClass("display-none")

  });

  $('.fa-text-width').on('click', function () {
    $(".video-list").removeClass("display-block").addClass("display-none")
    $(".audio-list ").removeClass("display-block").addClass("display-none")
    $(".image-list").removeClass("display-block").addClass("display-none")
    $(".text-list").removeClass("display-none").addClass("display-block")
  });
  $('.fa-film').on('click', function () {
    $(".video-list").removeClass("display-none").addClass("display-block")
    $(".audio-list").removeClass("display-block").addClass("display-none")
    $(".image-list").removeClass("display-block").addClass("display-none")
    $(".text-list").removeClass("display-block").addClass("display-none")

  });

  $('.record-audio').on('click', function () {
    $(".record-audio-container").toggleClass("display-block")
  });
  $('.text-to-speech').on('click', function () {
    $(".text-to-speech-container").toggleClass("display-block")
  });
});