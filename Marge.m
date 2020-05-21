function [] = Marge()
global RDK robot reference mLBB scafac aLBB g assembly_reference brickh mYB aYB mBB aBB mGB aGB
ass = RDK.Item('Assembly');
%% Coordinates for first brick Green
%move to brick 
move2GB1 = reference + [-(mGB(1).Centroid(2)/scafac), -(mGB(1).Centroid(1)/scafac), 0, 0, 0, 0 ]; % the last angle has to be transferred into degree 
move2GB_KP = KUKA_2_Pose(move2GB1);
%move down
movedownGB2 = move2GB1 - [0,0,180,-aGB(1),0,0];
movedownGB_KP = KUKA_2_Pose(movedownGB2);
moveoverGB = assembly_reference;
moveoverGB_KP = KUKA_2_Pose(moveoverGB);
moveoverdownGB = moveoverGB - [0,0,180,0,0,0]; 
moveoverdownGB_KP = KUKA_2_Pose(moveoverdownGB);
%% Coordinates for second brick Green
%move to brick 
move2GB1_1 = reference + [-(mGB(2).Centroid(2)/scafac), -(mGB(2).Centroid(1)/scafac), 0, 0, 0, 0 ]; % the last angle has to be transferred into degree 
move2GB_KP_1 = KUKA_2_Pose(move2GB1_1);
%move down
movedownGB2_1 = move2GB1_1 - [0,0,180,-aGB(2),0,0];
movedownGB_KP_1 = KUKA_2_Pose(movedownGB2_1);
moveoverGB_1 = assembly_reference;
moveoverGB_KP_1 = KUKA_2_Pose(moveoverGB_1);
moveoverdownGB_1 = moveoverGB_1 - [0,0,(180-brickh),0,0,0]; 
moveoverdownGB_KP_1 = KUKA_2_Pose(moveoverdownGB_1);
%% Coordinates for third brick Green
%move to brick 
move2GB1_2 = reference + [-(mGB(3).Centroid(2)/scafac), -(mGB(3).Centroid(1)/scafac), 0, 0, 0, 0 ]; % the last angle has to be transferred into degree 
move2GB_KP_2 = KUKA_2_Pose(move2GB1_2);
%move down
movedownGB2_2 = move2GB1_2 - [0,0,180,-aGB(3),0,0];
movedownGB_KP_2 = KUKA_2_Pose(movedownGB2_2);
moveoverGB_2 = assembly_reference;
moveoverGB_KP_2 = KUKA_2_Pose(moveoverGB_2);
moveoverdownGB_2 = moveoverGB_2 - [0,0,(180-2*brickh),0,0,0]; 
moveoverdownGB_KP_2 = KUKA_2_Pose(moveoverdownGB_2);
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

%% Coordinates for fifth Brick Blue
move2BB1 = reference + [-(mBB(1).Centroid(2)/scafac), -(mBB(1).Centroid(1)/scafac), 0, 0, 0, 0 ]; % the last angle has to be transferred into degree 
move2BB_KP = KUKA_2_Pose(move2BB1);
%move down
movedownBB2 = move2BB1 - [0,0,180,-aBB(1),0,0];
movedownBB_KP = KUKA_2_Pose(movedownBB2);
moveoverBB = assembly_reference;
moveoverBB_KP = KUKA_2_Pose(moveoverBB);
moveoverdownBB = moveoverBB - [0,0,(180-4*brickh),0,0,0];
moveoverdownBB_KP = KUKA_2_Pose(moveoverdownBB);
%% Coordinates for sixth Brick Blue
move2BB1_1 = reference + [-(mBB(2).Centroid(2)/scafac), -(mBB(2).Centroid(1)/scafac), 0, 0, 0, 0 ]; % the last angle has to be transferred into degree 
move2BB_KP_1 = KUKA_2_Pose(move2BB1_1);
%move down
movedownBB2_1 = move2BB1_1 - [0,0,180,-aBB(2),0,0];
movedownBB_KP_1 = KUKA_2_Pose(movedownBB2_1);
moveoverBB_1 = assembly_reference;
moveoverBB_KP_1 = KUKA_2_Pose(moveoverBB_1);
moveoverdownBB_1 = moveoverBB_1 - [0,0,(180-5*brickh),0,0,0];
moveoverdownBB_KP_1 = KUKA_2_Pose(moveoverdownBB_1);
%% Robot movement
%pick green Brick
robot.MoveJ(move2GB_KP);
pause(0.5);
robot.MoveJ(movedownGB_KP);
g.AttachClosest();
robot.MoveJ(move2GB_KP);
robot.MoveJ(moveoverGB_KP);
robot.MoveJ(moveoverdownGB_KP);
g.DetachAll(ass);
robot.MoveJ(moveoverGB_KP);

%pick second green Brick
robot.MoveJ(move2GB_KP_1);
pause(0.5);
robot.MoveJ(movedownGB_KP_1);
g.AttachClosest();
robot.MoveJ(move2GB_KP_1);
robot.MoveJ(moveoverGB_KP_1);
robot.MoveJ(moveoverdownGB_KP_1);
g.DetachAll(ass);
robot.MoveJ(moveoverGB_KP_1);

%pick third green Brick
robot.MoveJ(move2GB_KP_2);
pause(0.5);
robot.MoveJ(movedownGB_KP_2);
g.AttachClosest();
robot.MoveJ(move2GB_KP_2);
robot.MoveJ(moveoverGB_KP_2);
robot.MoveJ(moveoverdownGB_KP_2);
g.DetachAll(ass);
robot.MoveJ(moveoverGB_KP_2);

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

%pick blue Brick
robot.MoveJ(move2BB_KP);
pause(0.5);
robot.MoveJ(movedownBB_KP);
g.AttachClosest();
robot.MoveJ(move2BB_KP);
robot.MoveJ(moveoverBB_KP);
robot.MoveJ(moveoverdownBB_KP);
g.DetachAll(ass);
robot.MoveJ(moveoverBB_KP);

%pick second blue Brick
robot.MoveJ(move2BB_KP_1);
pause(0.5);
robot.MoveJ(movedownBB_KP_1);
g.AttachClosest();
robot.MoveJ(move2BB_KP_1);
robot.MoveJ(moveoverBB_KP_1);
robot.MoveJ(moveoverdownBB_KP_1);
g.DetachAll(ass);
robot.MoveJ(moveoverBB_KP_1);

