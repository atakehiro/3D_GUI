%�p�����[�^�ݒ�
d_num = 3; %���k����{��
d_pixel = 1.66; %X-Y�����̉𑜓x�A�}�C�N�����[�g���P��
d_frame = 0.5; %Z�����̉𑜓x�A�}�C�N�����[�g���P��
addpath('function')
%% tif�t�@�C���̓ǂݎ��
tic
[file, file_path] = uigetfile('*.tif');
file_info = imfinfo([file_path, file]);
height = file_info(1).Height;
width = file_info(1).Width;
depth = numel(file_info);
 
img = zeros(height,width,depth);
for t = 1:depth
    img(:,:,t) = imread([file_path, file], t);
end
'�f�[�^�ǂݎ�芮��'
toc
%%
Z_Y = permute(img,[1 3 2]); %�摜3�������̕ϊ�
z = floor(depth/d_num);
newImgZ_Y = ones(height, z, width);
for i = 1:width
    for j = 1:z
        b = Z_Y(:, d_num * (j-1) + 1:d_num * j, i);
        newImgZ_Y(:,j,i) = max(b,[],2);
    end
end
%%
Z_X = permute(img,[3 2 1]); %�摜3�������̕ϊ�
z = floor(depth/d_num);
newImgZ_X = ones(z, width, height);
for i = 1:height
    for j = 1:z
        b = Z_X(d_num * (j-1) + 1:d_num * j, :, i);
        newImgZ_X(j,:,i) = max(b);
    end
end
%%
gui_3d(img, newImgZ_X, newImgZ_Y, d_num, d_pixel, d_frame)