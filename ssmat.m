%==============================================================
% ����: ����������󣬷ֱ���վ��֮�����ͨ����վ�㾭������·ͳ��
% ����: 8/8/2011
%==============================================================
clear,clc
tic  %��ʱ��ʼ
fid=fopen('Bus.txt','r');%������
if fid>0 disp('�����ļ��򿪳ɹ���')
else disp('��ʧ��'),return
end
a=[];
b=[];
maxS=0;%��ʼ�����վ����
%�������վ����
while ~feof(fid)
    a=fgetl(fid);
    if isempty(a)
        %disp('ԭ·����')
    else
        n=find(a=='S');
        for i=1:length(n)        
            if str2num(a(n(i)+1:n(i)+4))>maxS
                maxS=str2num(a(n(i)+1:n(i)+4)); 
            end
        end
    end
end
disp(['վ������Ϊ: ' num2str(maxS)])
clear a b maxS
%------------------------------------------------------------
%fclose(fid);%�ر��ļ�
%fid=fopen('Bus.txt','r');%���´��ļ�
fseek(fid,0,-1);%�޸��ļ�ָ�룬�����ļ�ͷ
%fgetl(fid)
%---------------------SS_matrix--------------------------
%SS_matrix_con��ʾ�Ƿ�ֱ����ͨ��SS_matrix_tim��ʾʱ��
%SS_matrix_mon��ʾ�۸�,SS_matrix_L,��ʾ��ͨ��վ���Ĺ���·��
%SS_matrix_con=zeros(maxS);%վ�����ͨ���󣬳�ʼ��ȫ��
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
    if ~isempty(n)
        for i=1:length(n)        
             for j=i:length(n)
                 a1=str2num(a(n(i)+1:n(i)+4));
                 a2=str2num(a(n(j)+1:n(j)+4));
                 SS_matrix_con(a1,a2)=1;   %SS��ͨ����
                 %SS_matrix_L(a1,a2)=temp_L;%SS����·����
                 if a1~=a2
                    SS_matrix_tim(a1,a2)=(j-i)*3;               
                 end             
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
                     SS_matrix_con(a1,a2)=1;                     
                     SS_matrix_tim(a1,a2)=(i-j)*3;
                     %SS_matrix_L(a1,a2)=temp_L;%SS����·����                    
                end
            end
        end
    end
end
%--------------------------------------------
%disp('վ��֮�以����ͨ��ϡ�����Ϊ')
%SS_xishu=sparse(SS_matrix);
clo=fclose(fid);%�ر������ļ�
if clo==0 disp('�����ļ��ɹ��رգ�')
else disp('�����ļ��ر�ʧ�ܣ�'),return
end
save D:\matlab_files\SSdata_con SS_matrix_con
disp('վ��S�����ͨ�����Ѿ�����ΪD:\matlab_files\SSdata_con.mat') 
save D:\matlab_files\SSdata_tim SS_matrix_tim
disp('վ��S���ʱ������Ѿ�����ΪD:\matlab_files\SSdata_tim.mat')
%save D:\matlab_files\SSdata_L SS_matrix_L
%disp('վ��S�����·�����Ѿ�����ΪD:\matlab_files\SSdata_L.mat')
toc  %������ʱ
clear