function f = audioPlayPlot(x, Fs, bardata)
%  x      -  the audio (mono)
%  Fs     -  Sampling Frequency
% bardata -  the extended 1D image to display (imshow)

% audioPlayPlot is called to both display the image, and play the audio,
% easier than trying to Alt-tab in time, and gustimating the progression
% through the image.   20131222  -mcbaron

% edited on 20140102 to auto-repmat the bardata

bardata = repmat(bardata, length(bardata)/16, 1);

% create the plot of moodbar
f = figure;
imshow(bardata);
hold on;
ylimits = get(gca, 'YLim'); % get the y-axis limits
plotdata = [ylimits(1):0.1:ylimits(2)];
hline = plot(zeros(size(plotdata)), plotdata, 'r'); % plot the marker

% instantiate the audioplayer object
player = audioplayer(x, Fs);

% setup the timer for the audioplayer object
player.TimerFcn = {@plotMarker, player, gcf, plotdata, length(bardata)}; % timer callback function (defined below)
player.TimerPeriod = .005; % minimum period of the timer in seconds

% playing the audio
% this will move the marker over the audio plot at intervals of 0.01 s
playblocking(player);

end


