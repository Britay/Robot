function [] = Lisa()
global RDK robot reference scafac g assembly_reference brickh mOB aOB mYB aYB
ass = RDK.Item('Assembly');
%% Coordinates for first brick Orange
%move to brick 
move2OB1_1 = reference + [-(mOB(1).Centroid(2)/scafac), -(mOB(1).Centroid(1)/scafac), 0, 0, 0, 0 ]; % the last angle has to be transferred into degree 
move2OB_KP_1 = KUKA_2_Pose(move2OB1_1);
%move down
movedownOB2_1 = move2OB1_1 - [0,0,180,-aOB(1),0,0];
movedownOB_KP_1 = KUKA_2_Pose(movedownOB2_1);
moveoverOB_1 = assembly_reference;
moveoverOB_KP_1 = KUKA_2_Pose(moveoverOB_1);
moveoverdownOB_1 = moveoverOB_1 - [0,0,180,0,0,0];
moveoverdownOB_KP_1 = KUKA_2_Pose(moveoverdownOB_1);

%% Coordinates for second Brick Orange
move2OB1 = reference + [-(mOB(2).Centroid(2)/scafac), -(mOB(2).Centroid(1)/scafac), 0, 0, 0, 0 ]; % the last angle has to be transferred into degree 
move2OB_KP = KUKA_2_Pose(move2OB1);
%move down
movedownOB2 = move2OB1 - [0,0,180,-aOB(2),0,0];
movedownOB_KP = KUKA_2_Pose(movedownOB2);
moveoverOB = assembly_reference;
moveoverOB_KP = KUKA_2_Pose(moveoverOB);
moveoverdownOB = moveoverOB - [0,0,(180-brickh),0,0,0];
moveoverdownOB_KP = KUKA_2_Pose(moveoverdownOB);
%% Coordinates for third Brick Yellow
move2YB1 = reference + [-(mYB(1).Centroid(2)/scafac), -(mYB(1).Centroid(1)/scafac),0,0,0,0];
move2YB_KP = KUKA_2_Pose(move2YB1);
%move down
movedownYB2 = move2YB1 - [0,0,180,-aYB,0,0];
movedownYB_KP = KUKA_2_Pose(movedownYB2);
moveoverYB = assembly_reference;
moveoverYB_KP = KUKA_2_Pose(moveoverYB);
moveoverdownYB = moveoverYB - [0,0,(180-2*brickh),0,0,0];
moveoverdownYB_KP = KUKA_2_Pose(moveoverdownYB);
%% Robot movement
robot.MoveJ(move2OB_KP_1);
pause(0.5);
robot.MoveJ(movedownOB_KP_1);
g.AttachClosest();
robot.MoveJ(move2OB_KP_1);
robot.MoveJ(moveoverOB_KP_1);
robot.MoveJ(moveoverdownOB_KP_1);
g.DetachAll(ass);
robot.MoveJ(moveoverOB_KP_1);

%pick red Brick
robot.MoveJ(move2OB_KP);
pause(0.5);
robot.MoveJ(movedownOB_KP);
g.AttachClosest();
robot.MoveJ(move2OB_KP);
robot.MoveJ(moveoverOB_KP);
robot.MoveJ(moveoverdownOB_KP);
g.DetachAll(ass);
robot.MoveJ(moveoverOB_KP);

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