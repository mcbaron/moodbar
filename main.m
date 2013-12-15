% In this project, we attempt to analyze music down into a music bar,
% effectively trying to dupilcate the results of Wood and O'Keefe of the
% University of York, in their paper "On Techniques for Content-based
% Visual Annotation to Aid Intra-track Music Navigation"
%
% 20131214 -mcbaron

clear;

% [x, Fs] = wavread('green_onions.wav');
[x, Fs] = wavread('green_onions_sample.wav');
% [x, Fs] = wavread('ritz_full.wav');
% [x, Fs] = wavread('lady_bird.wav');

% x is a column matrix

% Window size 1024 samples
Nw = 1024;
window = hamming(Nw);

% Percent OL
pOL = 50;
OLoffset = round(Nw*pOL/100);

% length of FFT
nfft = 512; % Nw/2?

% Mix to mono to prevent any problematic stereo seperation effects
x = sum(x,2);

% Normalization of output of track before changing to color
%           (v - v_min)
% v_norm = ---------------
%          (v_max - v_min)
% x_min = min(x);
% x_max = max(x);
% x = (x - x_min)/(x_max-x_min);

%% Spectral Magnitude

% I have written the STFT by hand, but I don't really need it here. I will
% include a working example in the repo for the educational value, but
% MATLAB's spectrogram tells me what I need to know.
% [S, F, T] = spectrogram(x, window, OLoffset, nfft,Fs);

% to display the full spectrogram:
% figure;
% imagesc(T,F,real(10*log10(S)));
% axis xy;

% According to Wood and O'Keefe, we can "downsample" the frequency spectra
% based on the psychoacustical research done to create the Bark scale, to
% just 24 frequency channels. Wikipedia has an ok table for what
% frequencies we should be looking at. I will however use 26 channels,
% augmenting the 24 of the Bark scale with 16000 and 18500 Hz to add some
% weight to the higher frequencies. 


% We calculate the STFT at the center frequencies of each of the critical
% bands outlined by the table for the Bark scale critical frequencies.
F = [50 150 250 350 450 570 700 840 1000 1170 1370 1600 ...
       1850 2150 2500 2900 3400 4000 4800 5800 7000 8500 10500 13500 ...
       16000 18500];
   
% A different spectrum weighting scheme utilizing the center frequencies of
% a graphic EQ. Failed my pshychoacoustic experiments.
% The center frequencies on a dbx 2231 graphic EQ:
% F = [20 25 31.5 40 50 63 80 100 125 160 200 250 315 400 500 630 800 1000 ...
%     1250 2000 2500 3150 4000 5000 6300 8000 10000 12500 16000 20000];

[S, F, T] = spectrogram(x, window, OLoffset, F, Fs);

%  Magnitude & Normalize
G = abs(sum(S));
G_min = min(G);
G_max = max(G);
G = (G - G_min)/(G_max-G_min);

I = repmat(G,163, 1);
% tiling vertically 163 times is appropriate for ~15 seconds of audio
figure; 
imshow(I);

% This gives a greyscale image that reflects the changing spectrum
% magnitude over the course of the audio. Very rough, but
% psychoacoustically consistent.

