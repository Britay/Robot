function [] = Maggie()
global RDK robot reference mLBB scafac aLBB g assembly_reference mYB aYB brickh
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

%% Coordinates for second Brick Yellow
move2YB1 = reference + [-(mYB(1).Centroid(2)/scafac), -(mYB(1).Centroid(1)/scafac),0,0,0,0];
move2YB_KP = KUKA_2_Pose(move2YB1);
%move down
movedownYB2 = move2YB1 - [0,0,180,-aYB,0,0];
movedownYB_KP = KUKA_2_Pose(movedownYB2);
moveoverYB = assembly_reference;
moveoverYB_KP = KUKA_2_Pose(moveoverYB);
moveoverdownYB = moveoverYB - [0,0,(180-brickh),0,0,0];
moveoverdownYB_KP = KUKA_2_Pose(moveoverdownYB);
%% Robot movement
robot.MoveJ(move2lBB_KP);
pause(0.5);
robot.MoveJ(movedownlBB_KP);
g.AttachClosest();
robot.MoveJ(move2lBB_KP);
robot.MoveJ(moveoverlBB_KP);
robot.MoveJ(moveoverdownlBB_KP);
g.DetachAll(ass);
robot.MoveJ(moveoverlBB_KP);
robot.MoveJ(move2YB_KP);
pause(0.5);
robot.MoveJ(movedownYB_KP);
g.AttachClosest();
robot.MoveJ(move2YB_KP);
robot.MoveJ(moveoverYB_KP);
robot.MoveJ(moveoverdownYB_KP);
g.DetachAll(ass);
robot.MoveJ(moveoverYB_KP);

