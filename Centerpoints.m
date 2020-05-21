function [measure, angle] = centerpoints(cp)
%% Concatenate the median RGB arrays of the Lego bricks

pic = im2double(cp);
[h, w, ~] = size(pic);
[labels, numlabels] = bwlabel(pic);
%% Displays the number of Lego bricks detected
measure = regionprops(imbinarize(pic(:,1:w)), 'Extrema', 'MajorAxisLength', 'MinorAxisLength', 'Centroid');
for i=1:numlabels
    % Calculate the angle using the extrema points
    sides = measure(i).Extrema(4,:) - measure(i).Extrema(6,:);
    angle(i) = rad2deg(atan(-sides(2)/sides(1)));
end
