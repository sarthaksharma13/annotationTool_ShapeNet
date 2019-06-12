clear; close all; clc;

starting_index=-1;
keypoint_number=14;
maximum_file_size=600000;
mat_name='car_keypoints_mat.mat';
model_dir = dir('/media/data/data/datasets/ShapeNet/ShapeNetCore.v1/02958343/1a0bc9ab92c915167ae33d942430658c/');
obj_prefix='/media/data/data/datasets/ShapeNet/ShapeNetCore.v1/02958343/1a0bc9ab92c915167ae33d942430658c/model'
car_mat = [];

if(exist(mat_name, 'file') == 2 )
    load(mat_name);
    if(starting_index==-1)
        starting_index=size(car_mat,1)+1;
    end
else
    starting_index=1;
    car_mat=zeros(1,keypoint_number,3);
    save(mat_name,'car_mat');
end

fig=figure();
filesize=struct2cell(dir(strcat(obj_prefix,'.obj')));
while(filesize{3}>maximum_file_size)
    starting_index
    'file size greater'
    starting_index=starting_index+1;
    filesize=struct2cell(dir(strcat(obj_prefix,'.obj')));
end            
obj_display(strcat(obj_prefix,'.obj')), hold on
view([2,1.9,-5]);
dcm_obj = datacursormode(fig);

while (1)
    w = waitforbuttonpress;

    if(w==1)
        starting_index
        a={};
        f = getCursorInfo(dcm_obj);
        a = struct2cell(f);
        if(size(a,3)==keypoint_number)
            for i=1:keypoint_number
                car_mat(starting_index,i,:)=a{2,1,i};
            end
            starting_index=starting_index+1;
            save(mat_name,'car_mat');

            filesize=struct2cell(dir(strcat(obj_prefix,'.obj')));
            while(filesize{3}>maximum_file_size)
                starting_index=starting_index+1;
                filesize=struct2cell(dir(strcat(obj_prefix,'.obj')));
            end            
            obj_display(strcat(obj_prefix,'.obj')), hold on
            view([2,1.9,-5]);
            dcm_obj = datacursormode(fig);
        else
            'keypoint selected by you are more or less than specified. hold ALT and selet points'
        end
        
    end
end


% 
% left mirror: view(90,0);camroll(90);camzoom(4.5);campan(-1.0, 0,'data', [0,1,0]);camzoom(2)
% right mirror: view(90,0);camroll(90);camzoom(4.5);campan(1.0, 0,'data', [0,1,0]);camzoom(2)
% rear: view(-90,0);camroll(-90);camzoom(4.5)
% front: view(90,0); camroll(90);camzoom(4.5);
% left front wheel: view(-180,-90);campan(-2.0, 0,'data', [0,1,0]);camzoom(4);
% left rear wheel: view(-180,-90);campan(2.0, 0,'data', [0,1,0]);camzoom(4);
% 
% right fron wheel: view(0, 90);campan(2.0, 0,'data', [0,1,0]);camzoom(4);
% 
% top: view(180,0) ; camzoom(3)