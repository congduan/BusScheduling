%==============================================================
% 功能: 求站点S和路线L矩阵，表示通过S的所有线路
% 日期: 8/9/2011
%==============================================================
clear,clc
fid=fopen('Bus.txt','r');%打开数据
if fid>0 disp('数据文件打开成功！')
else disp('打开失败'),return
end

SLmat1=zeros(3957,520,2);
temp=[];
while ~feof(fid)
%for m=1:2
    temp=fgetl(fid);
    if temp(1)=='L'
        temp_L=str2num(temp(2:4));%当前L的值
    end
    fgetl(fid);temp=fgetl(fid);
    %第三行
    if temp(1)=='上'
        n=find(temp=='S');
        for i=1:length(n)
           n_S=str2num(temp(n(i)+1:n(i)+4));
           SLmat1(n_S,temp_L,1)=i;
        end  
    elseif temp(1)=='S'||temp(1)=='环'
        n=find(temp=='S');
        for i=1:length(n)
           n_S=str2num(temp(n(i)+1:n(i)+4));
           SLmat1(n_S,temp_L,1)=i;           
        end   
        for i=length(n):-1:1
            n_S=str2num(temp(n(i)+1:n(i)+4));
            SLmat1(n_S,temp_L,2)=length(n)-i+1;
        end
    end   
    %第四行
    temp=fgetl(fid);
    if ~isempty(temp)&&temp(1)=='下'
        n=find(temp=='S');
        for i=1:length(n)
           n_S=str2num(temp(n(i)+1:n(i)+4));
           SLmat1(n_S,temp_L,2)=i;
        end        
    end
end

fclose(fid);
%-------------将SL矩阵写入文本文件-------------
save D:\matlab_files\SLdata_sl SLmat1
disp('站点S间的线路矩阵已经保存为D:\matlab_files\SLdata_sl.mat')