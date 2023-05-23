document.addEventListener('DOMContentLoaded', function() {
    let startRecordingButton = document.getElementById('start-recording');
    let stopRecordingButton = document.getElementById('stop-recording');
    let audioBlobInput = document.getElementById('audio-blob');
    let audioStream;
    let mediaRecorder;
    let chunks = []; // Define the chunks variable outside the event listener

    startRecordingButton.addEventListener('click', function() {
        navigator.mediaDevices.getUserMedia({ audio: true })
            .then(function(stream) {
                audioStream = stream;
                mediaRecorder = new MediaRecorder(stream);
                chunks = []; // Clear the chunks array before starting a new recording
                mediaRecorder.addEventListener('dataavailable', function(event) {
                    chunks.push(event.data);
                });
                mediaRecorder.start();

                startRecordingButton.disabled = true;
                stopRecordingButton.disabled = false;
            })
            .catch(function(error) {
                console.error('Error accessing microphone:', error);
            });
    });
    stopRecordingButton.addEventListener('click', function() {
        if (mediaRecorder && mediaRecorder.state !== 'inactive') {
            mediaRecorder.stop();

            mediaRecorder.addEventListener('stop', function() {
                let audioBlob = new Blob(chunks, { type: 'audio/webm' });
                audioBlobInput.value = window.URL.createObjectURL(audioBlob);

                startRecordingButton.disabled = false;
                stopRecordingButton.disabled = true;
            });
            audioStream.getTracks().forEach(function(track) {
                track.stop();
            });
        }
    });
});
