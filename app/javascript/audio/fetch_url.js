    var videoUrlArray = [];
    var imageUrlArray = [];
    document.addEventListener("click", function(event) {
        if (event.target.matches("video")) {
            let videoUrl = event.target.getAttribute("src");
            videoUrlArray.push(videoUrl);
            alert("Video Added");
            $.ajax({
                url: '/send_url',
                method: 'GET',
                data: { video_data_Url: videoUrlArray },
            });
        }
        else if (event.target.matches("img")) {
            let imageUrl = event.target.getAttribute("src");
            imageUrlArray.push(imageUrl);
            alert("Image Added");
            $.ajax({
                url: '/send_url',
                method: 'GET',
                data: { image_data_Url: imageUrlArray }
            });
        }

})

