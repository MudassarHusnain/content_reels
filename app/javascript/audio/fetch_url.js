    var videoUrlArray = [];
    var imageUrlArray = [];
    document.addEventListener("click", function(event) {
        if (event.target.matches(".video_url")) {
            let videoUrl = event.target.getAttribute("src");
            videoUrlArray.push(videoUrl);
            alert("Video Added");
        }
        else if (event.target.matches(".image_url")) {
            let imageUrl = event.target.getAttribute("src");
            imageUrlArray.push(imageUrl);
            alert("Image Added");
          }
            $.ajax({
                url: '/send_url',
                method: 'GET',
                data: { image_data_Url: imageUrlArray,video_data_Url: videoUrlArray }

            });
        })

