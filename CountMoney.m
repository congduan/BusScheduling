 %==============================================================
% ����: ����·��Ӧ�ļƼ۷�ʽ����
% ����: 8/9/2011
%==============================================================
clear,clc
fid=fopen('Bus.txt','r');%������
if fid>0 disp('�����ļ��򿪳ɹ���')
else disp('��ʧ��'),return
end
tempData=[];
row_L=[];
S_str=[];%�����������ʽ�ַ�
row_L_num=[];
price_mat=zeros(520,2);%�Ƽ۾���Ĭ��0Ϊ��һƱ�ۣ�1Ϊ�ֶμƼ�

while ~feof(fid)
    for i=1:4
        tempData=strvcat(tempData,fgetl(fid));
    end
    row_L=tempData(1,:);%��һ�����ݰ���L����           
   if size(row_L,2)>=4
       row_L_num=str2num(row_L(2:4));%��ǰL��ֵ
   end   
   price_mat(row_L_num,1)=row_L_num;
   if tempData(2,1)=='��'          
       price_mat(row_L_num,2)=1;
   end   
   tempData=[];row_L_num=[];%ÿ�δ������������ݺ�����    
end
price_mat
save D:\matlab_files\SSdata_CountMoney price_mat
fclose(fid)