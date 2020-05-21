function [] = Bart()
global RDK robot reference mLBB scafac aLBB g assembly_reference mYB aYB mRB aRB brickh
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

%% Coordinates for second Brick Red
move2RB1 = reference + [-(mRB(1).Centroid(2)/scafac), -(mRB(1).Centroid(1)/scafac), 0, 0, 0, 0 ]; % the last angle has to be transferred into degree 
move2RB_KP = KUKA_2_Pose(move2RB1);
%move down
movedownRB2 = move2RB1 - [0,0,180,-aRB,0,0];
movedownRB_KP = KUKA_2_Pose(movedownRB2);
moveoverRB = assembly_reference;
moveoverRB_KP = KUKA_2_Pose(moveoverRB);
moveoverdownRB = moveoverRB - [0,0,(180-brickh),0,0,0];
moveoverdownRB_KP = KUKA_2_Pose(moveoverdownRB);
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
robot.MoveJ(move2lBB_KP);
pause(0.5);
robot.MoveJ(movedownlBB_KP);
g.AttachClosest();
robot.MoveJ(move2lBB_KP);
robot.MoveJ(moveoverlBB_KP);
robot.MoveJ(moveoverdownlBB_KP);
g.DetachAll(ass);
robot.MoveJ(moveoverlBB_KP);

%pick red Brick
robot.MoveJ(move2RB_KP);
pause(0.5);
robot.MoveJ(movedownRB_KP);
g.AttachClosest();
robot.MoveJ(move2RB_KP);
robot.MoveJ(moveoverRB_KP);
robot.MoveJ(moveoverdownRB_KP);
g.DetachAll(ass);
robot.MoveJ(moveoverRB_KP);

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