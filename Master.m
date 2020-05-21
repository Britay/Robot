clc
clear
close all

%% Robolink

RDK = Robolink; % Generate a Robolink object RDK. This object interfaces with RoboDK.
robot = RDK.Item('KUKA'); %dont know if its important
g = RDK.Item('Gripper');
RDK.RunCode('ReplaceBricks',1); %Replacing all bricks to their pre place
RDK.setSimulationSpeed(0.5);

%% variables
%the global variables are mainly used for the different coordinates and angles written in the function 'Centerpoints.m'
%the scaling factor helps to convert pixel values into mm in the 'real world' or in this case for the robot simluation program

global RDK mBB aBB mLBB aLBB mRB aRB mGB aGB mOB aOB mYB aYB mWB aWB reference scafac reference_height robot g assembly_reference brickh

scafac = 1.22; %scaling factor for transferring pixel in mm

reference = [500+(300/scafac),-300+(300/scafac),200,0,0,180] %bottom left corner of the 600x600 picture
assembly_reference = [400,400,200,0,0,180]; % these are the coordinates for the assembly destination for all figures
reference_height = 20;
brickh = 18,115; % Brickheight

%% Homing the robot
% Before the program allows to GUI to show up it homes the robot

home = KUKA_2_Pose([450,0,650,0,0,180]); % Definated home position of the robot
robot.MoveJ(home);

%% CameraOperations

%RDK.Cam2D_Close;
camref = RDK.Item('Camera'); % Calling the Reference Frame called 'Camera'
cam_h = RDK.Cam2D_Add(camref, 'FOCAL_LENGHT=6 FOV=31 FAR_LENGHT=1000 SIZE=600x600 BG_COLOR=black LIGHT_AMBIENT=red LIGHT_DIFFUSE=black LIGHT_SPECULAR=white'); % Adding a 2D Camera to the reference frame called above
file = char(RDK.getParam('PATH_OPENSTATION') + "/Bricks.png"); % getting a source destination for saving the picture as a .png. The PATHOPENSTATION  as it says includes the path from where the current station is opened.
RDK.Cam2D_Snapshot(file, cam_h); % taking a snapshot from predefined 'cam_h', and saving it in predefined 'file'

%% Calling IMG Proc function
% Calling the ImageProcessing function
%extracting all the variables from ImgProcessing that were generated in
%Centerpoints
[mBB, aBB,mLBB, aLBB, mRB, aRB, mGB, aGB, mOB, aOB, mYB, aYB, mWB, aWB] = ImgProcessing(file);


%% Build figures
%before every function call in the if-loop, is a call for the RoboDK function to replace all objects.

KeepBuilding = 1; %while loop makes sure, that the GUI doesn't stop after choosing character. It opens up the GUI again after the job is done.
while KeepBuilding ==1;
    
    %---- Select Family memeber to build ---------------------------------------------------
    message = sprintf('Which figure would you like to assemble?');
    gui = menu(message,'Maggie', 'Bart', 'Lisa','Marge','Homer','Replace Objects','Quit');
    if gui==1
        RDK.RunCode('ReplaceBricks',1); %RDK.RunCode('Program',1=True | 0=False)
        fprintf('Building Maggie');
        Maggie();
        fprintf('Done');
        robot.MoveJ(home);% After every figure that has been built, the robot moves again to its home position.
    elseif gui==2
        RDK.RunCode('ReplaceBricks',1);
        fprintf('Building Bart');
        Bart();
        fprintf('Done');
        robot.MoveJ(home);
    elseif gui==3
        RDK.RunCode('ReplaceBricks',1);
        fprintf('Building Lisa');
        Lisa();
        fprintf('Done');
        robot.MoveJ(home);
    elseif gui==4
        RDK.RunCode('ReplaceBricks',1);
        fprintf('Building Marge');
        Marge();
        fprintf('Done');
        robot.MoveJ(home);
    elseif gui==5
        RDK.RunCode('ReplaceBricks',1);
        fprintf('Building Homer');
        Homer();
        fprintf('Done');
        robot.MoveJ(home);
    elseif gui==6
        fprintf('Replacing Objects');
        RDK.RunCode('ReplaceBricks',1);
    elseif gui==7
        waitfor(msgbox('Exiting program:Robot going away from camera view'));
        KeepBuilding =0; % Changing the variable the while loop needs to ==1 to ==0: While loop ends!
        break
    else
        disp('none');
    end
end

% If user quits, end program:
disp('Program ended');
msgbox('Program ended');
