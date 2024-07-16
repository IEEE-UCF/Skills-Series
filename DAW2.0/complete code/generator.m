%{
IEEE UCF - Digital Audio Workshop 2.0 (Skills Series)
12 February 2024
%}
clear all; clc; close all;

%% Config
play = 1; % 0 -> no sound

% sampling frequency & period
fs = 44100; % Hz
Ts = 1/fs; % sec

f_sine = [ 100 1300 2500 ]; % 3 sine components
noiseAmplitude = 8;
length_playback = 0.5;
t = 0:Ts:length_playback; % input to sine function (timebase)

% 3 sine waves at frequency f
g = [1 1 1]*sin(2*pi*f_sine'.*t);
g_len = length(g);

%% Analysis
% time domain without noise
subplot(2,1,1)
plot(t,g)

% add noise
g_noisy = g + noiseAmplitude*rand(1,length(g)) - noiseAmplitude/2;

% time domain with noise
subplot(2,1,2)
plot(t,g_noisy)

% perform FFT to represent in frequency domain
f_spectrum = (-g_len/2:g_len/2-1)*(fs/g_len); % zero-centered frequency range

% FFT (normalized) of clean signal
figure
subplot(2,1,1)
G = fftshift(fft( g ));
plot(f_spectrum,abs( G ))
xlim([ -5000 5000 ])

% FFT (normalized) of noisy signal
subplot(2,1,2)
G_noisy = fftshift(fft( g_noisy ));
plot(f_spectrum,abs( G_noisy ))
xlim([ -5000 5000 ])

% transposed because audio range is -1 to 1
if play
    sound(g'-1,fs);
    pause(length_playback*2)
    sound(g_noisy'-1,fs);
end


