 %==============================================================
% 功能: 求线路对应的计价方式矩阵
% 日期: 8/9/2011
%==============================================================
clear,clc
fid=fopen('Bus.txt','r');%打开数据
if fid>0 disp('数据文件打开成功！')
else disp('打开失败'),return
end
tempData=[];
row_L=[];
S_str=[];%后面的整数形式字符
row_L_num=[];
price_mat=zeros(520,2);%计价矩阵，默认0为单一票价，1为分段计价

while ~feof(fid)
    for i=1:4
        tempData=strvcat(tempData,fgetl(fid));
    end
    row_L=tempData(1,:);%第一行数据包含L的行           
   if size(row_L,2)>=4
       row_L_num=str2num(row_L(2:4));%当前L的值
   end   
   price_mat(row_L_num,1)=row_L_num;
   if tempData(2,1)=='分'          
       price_mat(row_L_num,2)=1;
   end   
   tempData=[];row_L_num=[];%每次处理完四行数据后清零    
end
price_mat
save D:\matlab_files\SSdata_CountMoney price_mat
fclose(fid)