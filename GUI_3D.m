%パラメータ設定
d_num = 3; %圧縮する倍率
d_pixel = 1.66; %X-Y方向の解像度、マイクロメートル単位
d_frame = 0.5; %Z方向の解像度、マイクロメートル単位
addpath('function')
%% tifファイルの読み取り
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
'データ読み取り完了'
toc
%%
Z_Y = permute(img,[1 3 2]); %画像3次元軸の変換
z = floor(depth/d_num);
newImgZ_Y = ones(height, z, width);
for i = 1:width
    for j = 1:z
        b = Z_Y(:, d_num * (j-1) + 1:d_num * j, i);
        newImgZ_Y(:,j,i) = max(b,[],2);
    end
end
%%
Z_X = permute(img,[3 2 1]); %画像3次元軸の変換
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