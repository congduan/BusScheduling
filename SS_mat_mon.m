%==============================================================
% ����: ��SS_matrix_mon���󣬱�ʾ�۸�
% ����: 8/10/2011
%==============================================================
clear,clc
tic  %��ʱ��ʼ
fid=fopen('Bus.txt','r');%������
if fid>0 disp('�����ļ��򿪳ɹ���')
else disp('��ʧ��'),return
end
maxS=3957;
SS_matrix_mon=zeros(maxS);
%---------------------SS_matrix_mon--------------------------
a=[];    
temp_L=[];
while ~feof(fid)
    a=fgetl(fid);
    %��¼��ǰL
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
                SS_matrix_mon(a1,a2)=calc_money(a1,a2,temp_L,j-i);%SS�۸����
             end             
         end
     end
end
%------------����ԭ·���ص�·��----------------
temp_L=1;
n=[];
fseek(fid,0,-1);%�޸��ļ�ָ�룬�����ļ�ͷ
for i=3:(520*4-1)
    temp=fgetl(fid);
    %��¼��ǰL
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
                     SS_matrix_mon(a1,a2)=calc_money(a1,a2,temp_L,j-i);%SS�۸����
                end
            end
        end
    end
end
clear a temp_L a1 a2
%--------------------------------------------
clo=fclose(fid);%�ر������ļ�
if clo==0 disp('�����ļ��ɹ��رգ�')
else disp('�����ļ��ر�ʧ�ܣ�'),return
end
save D:\matlab_files\SSdata_mon SS_matrix_mon
disp('վ��S�����·�����Ѿ�����ΪD:\matlab_files\SSdata_mon.mat')
toc  %������ʱ
clear