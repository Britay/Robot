function [mBB, aBB,mLBB, aLBB, mRB, aRB, mGB, aGB, mOB, aOB, mYB, aYB, mWB, aWB] = ImgProcessing(file)
%% Read the picture and transfer it into a double
% reading the file generated in the 'Master'
img = imread(file);
%changing the read file into a double format to be used further
pic = im2double(img);
% getting the pixel dimensions of the file 
[h, w, ~] = size(pic);

%% segmentation of bricks
%when using 'square' it found 14 instead of the actual 12
se = strel('diamond', 1);
%Because red is a part of the 3D structure of many bricks and cannot really
%be filtered we used another segmentation method
seRED = strel('square', 5);
%% Color Thresholding - color detection
%In this section the imread file is used as a variable and loaded into
%another function f.e.: BB = BlueMask(pic); In this function a color
%thresholöding is made for each of the colors needed for the Simpsons
%figures

%The second line does the segmentation with use of the variables defined
%before 

% The third line is calling the imcleanborder function to clear the edges
% of the segmented brick area.

%The fourth line uses the imfill function. This function is used to fill up
%the Black/White picture to make sure that it counts as one. 

BB = BlueMask(pic);
BBClean = imopen(BB,se);
BBClean = imclearborder(BBClean);
BBClean = imfill(BBClean,'holes');

LBB = LightBlueMask(pic); 
LBBClean = imopen(LBB,se);
LBBClean = imclearborder(LBBClean);
LBBClean = imfill(LBBClean,'holes');

RB = RedMask(pic); 
RBClean = imopen(RB,seRED);
RBClean = imclearborder(RBClean);
RBClean = imfill(RBClean,'holes');

GB = GreenMask(pic);
GBClean = imopen(GB,se);
GBClean = imclearborder(GBClean);
GBClean = imfill(GBClean,'holes');

OB = OrangeMask(pic);
OBClean = imopen(OB,se);
OBClean = imclearborder(OBClean);
OBClean = imfill(OBClean,'holes');

YB = YellowMask(pic);
YBClean = imopen(YB,se);
YBClean = imclearborder(YBClean);
YBClean = imfill(YBClean,'holes');

WB = WhiteMask(pic);
WBClean = imopen(WB,se);
WBClean = imclearborder(WBClean);
WBClean = imfill(WBClean,'holes');

% Background subtraction
nobckg = SubtractBackground(pic); %no background

picClean = imopen(nobckg,se);
picClean = imfill(picClean,'holes');
picClean = imclearborder(picClean);

%% Labels the image (All commented are done in the several functions)
[labels, numlabelsComp] = bwlabel(picClean);
% [labelsBB, numlabelsBB] = bwlabel(BBClean);
% [labelsLBB, numlabelsLBB] = bwlabel(LBBClean);
% [labelsRB, numlabelsRB] = bwlabel(RBClean);
% [labelsGB, numlabelsGB] = bwlabel(GBClean);
% [labelsOB, numlabelsOB] = bwlabel(OBClean);
% [labelsYB, numlabelsYB] = bwlabel(YBClean);
% [labelsWB, numlabelsWB] = bwlabel(WBClean);

%% Converting picClean into a double
picClean = im2double(picClean);

%% Displays the number of Lego bricks detected
%This section displays the counted number of Bricks in the thresholded
%picture 
%The measurements variable is calculating, the center, the minimum and maximum length of each brick.
disp(['Number of Lego bricks: ' num2str(numlabelsComp)]);
%disp(['Number of Lego bricks: ' num2str(numlabelsBB)]); %testing if thesingle thresholds give the right brick value
measurements = regionprops(imbinarize(picClean(:,1:w)), 'Extrema', 'MajorAxisLength', 'MinorAxisLength', 'Centroid');
imshow(picClean);
%% Preallocate a vector for the angles and a matrix for the center
%Drawing lines into the brick areas in the picture where just the
%background is black. 
%This cannot be seen anymore, only if the 'close all' at the end of this
%function is disabled
theAngle = zeros(numlabelsComp,1);
center = zeros(numlabelsComp,2);

hold on
for i=1:numlabelsComp
    % Calculate the angle using the extrema points
    sides = measurements(i).Extrema(4,:) - measurements(i).Extrema(6,:);
    theAngle(i) = atan(-sides(2)/sides(1));
    
    % Rewrite the centroids into a more accessible form
    center(i,1) = measurements(i).Centroid(1);
    center(i,2) = measurements(i).Centroid(2);
    
    % Draw orientation of the Lego bricks onto figure
    hori1x = measurements(i).MajorAxisLength/2 * cos(theAngle(i)) + center(i,1);
    hori2x = -measurements(i).MajorAxisLength/2 * cos(theAngle(i)) + center(i,1);
    hori1y = -measurements(i).MajorAxisLength/2 * sin(theAngle(i)) + center(i,2);
    hori2y = measurements(i).MajorAxisLength/2 * sin(theAngle(i)) + center(i,2);
    line([hori1x,hori2x],[hori1y,hori2y])
    
    vert1x = measurements(i).MinorAxisLength/2 * cos(theAngle(i)+pi/2) + center(i,1);
    vert2x = -measurements(i).MinorAxisLength/2 * cos(theAngle(i)+pi/2) + center(i,1);
    vert1y = -measurements(i).MinorAxisLength/2 * sin(theAngle(i)+pi/2) + center(i,2);
    vert2y = measurements(i).MinorAxisLength/2 * sin(theAngle(i)+pi/2) + center(i,2);
    line([vert1x,vert2x],[vert1y,vert2y])
end
hold off

%% Getting the center coordinates of the different colors
% This sections deals with the centerpoints of each segmented picture with
% just one color in. mBB = measurements aBB = angles 
[mBB, aBB] = Centerpoints(BBClean);
[mLBB, aLBB] = Centerpoints(LBBClean);
[mRB, aRB] = Centerpoints(RBClean);
[mGB, aGB] = Centerpoints(GBClean);
[mOB, aOB] = Centerpoints(OBClean);
[mYB, aYB] = Centerpoints(YBClean);
[mWB, aWB] = Centerpoints(WBClean);

close all %closes all figures