function [] = Homer()
global RDK robot reference mLBB scafac aLBB g assembly_reference mYB aYB mlBB alBB mWB aWB brickh
ass = RDK.Item('Assembly');
%% Coordinates for first brick LightBlue
%move to brick 
move2lBB1 = reference + [-(mLBB(1).Centroid(2)/scafac), -(mLBB(1).Centroid(1)/scafac), 0, 0, 0, 0 ]; % the last angle has to be transferred into degree 
move2lBB_KP = KUKA_2_Pose(move2lBB1);
%move down
movedownlBB2 = move2lBB1 - [0,0,180,-aLBB,0,0];
movedownlBB_KP = KUKA_2_Pose(movedownlBB2);
moveoverlBB = assembly_reference;
moveoverlBB_KP = KUKA_2_Pose(moveoverlBB);
moveoverdownlBB = moveoverlBB - [0,0,180,0,0,0]; 
moveoverdownlBB_KP = KUKA_2_Pose(moveoverdownlBB);

%% Coordinates for second Brick White
move2WB1 = reference + [-(mWB(1).Centroid(2)/scafac), -(mWB(1).Centroid(1)/scafac), 0, 0, 0, 0 ]; % the last angle has to be transferred into degree 
move2WB_KP = KUKA_2_Pose(move2WB1);
%move down
movedownWB2 = move2WB1 - [0,0,180,-aWB(1),0,0];
movedownWB_KP = KUKA_2_Pose(movedownWB2);
moveoverWB = assembly_reference;
moveoverWB_KP = KUKA_2_Pose(moveoverWB);
moveoverdownWB = moveoverWB - [0,0,(180-brickh),0,0,0];
moveoverdownWB_KP = KUKA_2_Pose(moveoverdownWB);
%% Coordinates for third Brick White
move2WB1_1 = reference + [-(mWB(2).Centroid(2)/scafac), -(mWB(2).Centroid(1)/scafac), 0, 0, 0, 0 ]; % the last angle has to be transferred into degree 
move2WB_KP_1 = KUKA_2_Pose(move2WB1_1);
%move down
movedownWB2_1 = move2WB1_1 - [0,0,180,-aWB(2),0,0];
movedownWB_KP_1 = KUKA_2_Pose(movedownWB2_1);
moveoverWB_1 = assembly_reference;
moveoverWB_KP_1 = KUKA_2_Pose(moveoverWB_1);
moveoverdownWB_1 = moveoverWB_1 - [0,0,(180-2*brickh),0,0,0];
moveoverdownWB_KP_1 = KUKA_2_Pose(moveoverdownWB_1);
%% Coordinates for fourth Brick Yellow
move2YB1 = reference + [-(mYB(1).Centroid(2)/scafac), -(mYB(1).Centroid(1)/scafac),0,0,0,0];
move2YB_KP = KUKA_2_Pose(move2YB1);
%move down
movedownYB2 = move2YB1 - [0,0,180,-aYB,0,0];
movedownYB_KP = KUKA_2_Pose(movedownYB2);
moveoverYB = assembly_reference;
moveoverYB_KP = KUKA_2_Pose(moveoverYB);
moveoverdownYB = moveoverYB - [0,0,(180-3*brickh),0,0,0];
moveoverdownYB_KP = KUKA_2_Pose(moveoverdownYB);
%% Robot movement
%pick light Blue Brick
robot.MoveJ(move2lBB_KP);
pause(0.5);
robot.MoveJ(movedownlBB_KP);
g.AttachClosest();
robot.MoveJ(move2lBB_KP);
robot.MoveJ(moveoverlBB_KP);
robot.MoveJ(moveoverdownlBB_KP);
g.DetachAll(ass);
robot.MoveJ(moveoverlBB_KP);

%pick white Brick
robot.MoveJ(move2WB_KP);
pause(0.5);
robot.MoveJ(movedownWB_KP);
%g.CloseGrapper();
g.AttachClosest();
robot.MoveJ(move2WB_KP);
robot.MoveJ(moveoverWB_KP);
robot.MoveJ(moveoverdownWB_KP);
g.DetachAll(ass);
robot.MoveJ(moveoverWB_KP);

%pick second white Brick
robot.MoveJ(move2WB_KP_1);
pause(0.5);
robot.MoveJ(movedownWB_KP_1);
g.AttachClosest();
robot.MoveJ(move2WB_KP_1);
robot.MoveJ(moveoverWB_KP_1);
robot.MoveJ(moveoverdownWB_KP_1);
g.DetachAll(ass);
robot.MoveJ(moveoverWB_KP_1);

%pick yellow Brick
robot.MoveJ(move2YB_KP);
pause(0.5);
robot.MoveJ(movedownYB_KP);
g.AttachClosest();
robot.MoveJ(move2YB_KP);
robot.MoveJ(moveoverYB_KP);
robot.MoveJ(moveoverdownYB_KP);
g.DetachAll(ass);
robot.MoveJ(moveoverYB_KP);