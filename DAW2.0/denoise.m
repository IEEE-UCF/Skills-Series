%{
IEEE UCF - Digital Audio Workshop 2.0 (Skills Series)
12 February 2024
%}

% spec a bandpass filter to recover one sine component of g(t)
g_denoised = bandpass(g_noisy,[2400, 2600],fs);

audiowrite('g_denoised.wav',g_denoised,fs);

figure
plot(t,g_denoised);
[g_out,g_fs] = audioread('g_denoised.wav');
f0 = pitch(g_out,g_fs);
fprintf('Frequency of denoised signal: %f Hz\n',max( f0 ))

if play
    sound(g_denoised,fs);
end