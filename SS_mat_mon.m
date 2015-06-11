%==============================================================
% 功能: 求SS_matrix_mon矩阵，表示价格
% 日期: 8/10/2011
%==============================================================
clear,clc
tic  %计时开始
fid=fopen('Bus.txt','r');%打开数据
if fid>0 disp('数据文件打开成功！')
else disp('打开失败'),return
end
maxS=3957;
SS_matrix_mon=zeros(maxS);
%---------------------SS_matrix_mon--------------------------
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
    for i=1:length(n)        
         for j=i:length(n)
             a1=str2num(a(n(i)+1:n(i)+4));
             a2=str2num(a(n(j)+1:n(j)+4));
             if a1~=a2
                SS_matrix_mon(a1,a2)=calc_money(a1,a2,temp_L,j-i);%SS价格矩阵
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
                     SS_matrix_mon(a1,a2)=calc_money(a1,a2,temp_L,j-i);%SS价格矩阵
                end
            end
        end
    end
end
clear a temp_L a1 a2
%--------------------------------------------
clo=fclose(fid);%关闭数据文件
if clo==0 disp('数据文件成功关闭！')
else disp('数据文件关闭失败！'),return
end
save D:\matlab_files\SSdata_mon SS_matrix_mon
disp('站点S间的线路矩阵已经保存为D:\matlab_files\SSdata_mon.mat')
toc  %结束计时
clear