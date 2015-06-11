%==============================================================
% 功能: 输出两个矩阵，分别是站点之间的联通矩阵、站点经过的线路统计
% 日期: 8/8/2011
%==============================================================
clear,clc
tic  %计时开始
fid=fopen('Bus.txt','r');%打开数据
if fid>0 disp('数据文件打开成功！')
else disp('打开失败'),return
end
a=[];
b=[];
maxS=0;%初始化最大站点数
%计算最大站点数
while ~feof(fid)
    a=fgetl(fid);
    if isempty(a)
        %disp('原路返回')
    else
        n=find(a=='S');
        for i=1:length(n)        
            if str2num(a(n(i)+1:n(i)+4))>maxS
                maxS=str2num(a(n(i)+1:n(i)+4)); 
            end
        end
    end
end
disp(['站点数量为: ' num2str(maxS)])
clear a b maxS
%------------------------------------------------------------
%fclose(fid);%关闭文件
%fid=fopen('Bus.txt','r');%重新打开文件
fseek(fid,0,-1);%修改文件指针，跳到文件头
%fgetl(fid)
%---------------------SS_matrix--------------------------
%SS_matrix_con表示是否直接连通，SS_matrix_tim表示时间
%SS_matrix_mon表示价格,SS_matrix_L,表示连通两站点间的公交路线
%SS_matrix_con=zeros(maxS);%站点间联通矩阵，初始化全零
a=[];    
temp_L=[];
while ~feof(fid)
    a=fgetl(fid);
    %记录当前L
    n_L=find(a=='L');
    if ~isempty(n_L)
        temp_L=str2num(a(n_L+1:n_L+3));
    end
    %temp_L
    n=find(a=='S');
    if ~isempty(n)
        for i=1:length(n)        
             for j=i:length(n)
                 a1=str2num(a(n(i)+1:n(i)+4));
                 a2=str2num(a(n(j)+1:n(j)+4));
                 SS_matrix_con(a1,a2)=1;   %SS连通矩阵
                 %SS_matrix_L(a1,a2)=temp_L;%SS的线路矩阵
                 if a1~=a2
                    SS_matrix_tim(a1,a2)=(j-i)*3;               
                 end             
             end
        end
    end
end
%------------处理原路返回的路线----------------
temp_L=1;
n=[];
fseek(fid,0,-1);%修改文件指针，跳到文件头
for i=3:(520*4-1)
    temp=fgetl(fid);
    %记录当前L
    n_L=find(a=='L');
    if ~isempty(n_L)
        temp_L=str2num(a(n_L+1:n_L+3));
    end
    if ~isempty(temp)
        if temp(1)=='S'
            n=find(temp=='S');
            for i=length(n):-1:1      
                for j=i:-1:1
                     a1=str2num(temp(n(i)+1:n(i)+4));
                     a2=str2num(temp(n(j)+1:n(j)+4));
                     SS_matrix_con(a1,a2)=1;                     
                     SS_matrix_tim(a1,a2)=(i-j)*3;
                     %SS_matrix_L(a1,a2)=temp_L;%SS的线路矩阵                    
                end
            end
        end
    end
end
%--------------------------------------------
%disp('站点之间互相连通的稀疏矩阵为')
%SS_xishu=sparse(SS_matrix);
clo=fclose(fid);%关闭数据文件
if clo==0 disp('数据文件成功关闭！')
else disp('数据文件关闭失败！'),return
end
save D:\matlab_files\SSdata_con SS_matrix_con
disp('站点S间的连通矩阵已经保存为D:\matlab_files\SSdata_con.mat') 
save D:\matlab_files\SSdata_tim SS_matrix_tim
disp('站点S间的时间矩阵已经保存为D:\matlab_files\SSdata_tim.mat')
%save D:\matlab_files\SSdata_L SS_matrix_L
%disp('站点S间的线路矩阵已经保存为D:\matlab_files\SSdata_L.mat')
toc  %结束计时
clear