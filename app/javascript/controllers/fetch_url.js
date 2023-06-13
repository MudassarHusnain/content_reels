var urlArray = [];
    $('video').on('click', function () {
        let videoUrl = $(this).attr('src');
        urlArray.push(videoUrl);
        alert("Vedio is selected")
        $.ajax({
            url: '/send_url',
            method: 'GET',
            data: {dataUrl: urlArray},
            success: function (response) {
                console.log(response);
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    });