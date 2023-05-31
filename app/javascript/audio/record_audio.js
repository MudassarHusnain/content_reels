window.URL = window.URL || window.webkitURL;
window.AudioContext = window.AudioContext || window.webkitAudioContext;
navigator.getUserMedia =
  navigator.getUserMedia ||
  navigator.webkitGetUserMedia ||
  navigator.mozGetUserMedia ||
  navigator.msGetUserMedia;
var recorder = new RecordVoiceAudios();
let startBtn = document.querySelector("#js-start");
let stopBtn = document.querySelector("#js-stop");
let tracks = "";
startBtn.onclick = recorder.startRecord;
stopBtn.onclick = recorder.stopRecord;

function RecordVoiceAudios() {
  let elementVolume = document.querySelector(".js-volume");
  let codeBtn = document.querySelector(".js-code");
  let pre = document.querySelector("pre");
  let downloadLink = document.getElementById("download");
  let audioElement = document.querySelector("#audio");
  let encoder = null;
  let microphone;
  let isRecording = false;
  var audioContext;
  let processor;
  let config = {
    bufferLen: 4096,
    numChannels: 2,
    mimeType: "audio/mpeg",
  };

  this.startRecord = function () {
    audioContext = new AudioContext();
    if (audioContext.createJavaScriptNode) {
      processor = audioContext.createJavaScriptNode(
        config.bufferLen,
        config.numChannels,
        config.numChannels
      );
    } else if (audioContext.createScriptProcessor) {
      processor = audioContext.createScriptProcessor(
        config.bufferLen,
        config.numChannels,
        config.numChannels
      );
    } else {
      console.log("WebAudio API has no support on this browser.");
    }

    processor.connect(audioContext.destination);
    navigator.mediaDevices
      .getUserMedia({ audio: true, video: false })
      .then(gotStreamMethod)
      .catch(logError);
  };

  let getBuffers = (event) => {
    var buffers = [];
    for (var ch = 0; ch < 2; ++ch)
      buffers[ch] = event.inputBuffer.getChannelData(ch);
    return buffers;
  };

  let gotStreamMethod = (stream) => {
    tracks = stream.getTracks();

    startBtn.setAttribute("disabled", true);
    stopBtn.removeAttribute("disabled");
    audioElement.src = "";
    config = {
      bufferLen: 4096,
      numChannels: 2,
      mimeType: "audio/mpeg",
    };
    isRecording = true;

    microphone = audioContext.createMediaStreamSource(stream);
    microphone.connect(processor);
    encoder = new Mp3LameEncoder(audioContext.sampleRate, 160);
    processor.onaudioprocess = function (event) {
      encoder.encode(getBuffers(event));
    };
  };

  this.stopRecord = function () {
    isRecording = false;
    startBtn.removeAttribute("disabled");
    stopBtn.setAttribute("disabled", true);
    audioContext.close();
    processor.disconnect();
    tracks.forEach((track) => track.stop());
    audioElement.src = URL.createObjectURL(encoder.finish());
    audioElement.value = audioElement.src;
    fetch(audioElement.value)
      .then((response) => response.blob())
      .then((blob) => {
        const reader = new FileReader();
        reader.onloadend = () => {
          audioElement.value = reader.result;
        };
        reader.readAsDataURL(blob);
      })
      .catch((error) => {
        console.error("Error fetching audio file:", error);
      });
    analizer(audioContext);
  };

  let analizer = (context) => {
    let listener = context.createAnalyser();
    microphone.connect(listener);
    listener.fftSize = 256;
    var bufferLength = listener.frequencyBinCount;
    let analyserData = new Uint8Array(bufferLength);
  };

  let logError = (error) => {
    alert(error);
    console.log(error);
  };
}
