clear all; clc; close all;
wavs = dir([pwd, '/*.wav']);
n_wav = length(wavs);
mp3s = dir([pwd, '/*.mp3']);
n_mp3 = length(mp3s);
n_songs = n_wav + n_mp3;

for i=1:n_mp3
    [audio(i).data, audio(i).sampleFreq] = audioread(mp3s(i).name);
end
for i=(1+n_mp3):(n_mp3+n_wav)
    [audio(i).data, audio(i).sampleFreq] = audioread(wavs(i-n_mp3).name);
end

for i=1:length(audio)
    dyn_rng(i).left_right = range(audio(i).data);
end

true_dyn_range(1) = (dyn_rng(1).left_right(1) + dyn_rng(1).left_right(2))/2;
true_dyn_range(2) = (dyn_rng(2).left_right(1) + dyn_rng(2).left_right(2))/2;
true_dyn_range(3) = (dyn_rng(3).left_right(1) + dyn_rng(3).left_right(2))/2;
true_dyn_range(4) = (dyn_rng(4).left_right(1) + dyn_rng(4).left_right(2))/2;
true_dyn_range(5) = (dyn_rng(5).left_right(1) + dyn_rng(5).left_right(2))/2;
true_dyn_range(6) = (dyn_rng(5).left_right(1) + dyn_rng(5).left_right(2))/2;
true_dyn_range(7) = (dyn_rng(5).left_right(1) + dyn_rng(5).left_right(2))/2;
true_dyn_range(8) = (dyn_rng(5).left_right(1) + dyn_rng(5).left_right(2))/2;
true_dyn_range(9) = (dyn_rng(5).left_right(1) + dyn_rng(5).left_right(2))/2;
true_dyn_range(10) = (dyn_rng(5).left_right(1) + dyn_rng(5).left_right(2))/2;


true_amplitude = true_dyn_range/2;



% for i=1:length(audio)
%     fft_audio(i) = fft(audio(i).data);
% end

