%---------------------------------------------------------------
%���ܣ�����������˹����ľ���
%���ڣ�8/11/2011
%---------------------------------------------------------------
clear,clc
t1_subway=zeros(23,6);t2_subway=zeros(18,5);
temp=[];
fid=fopen('2.1 ����T1�߻��˹�����Ϣ.txt','r');
for i=1:23
    temp=fgetl(fid);
    t1_subway(i,1)=str2num(temp(2:3));
    n=find(temp=='S');
    for j=1:length(n)
        t1_subway(i,j+1)=str2num(temp(n(j)+1:n(j)+4));
    end
end
%t1_subway
save D:\matlab_files\T1_subway t1_subway
disp('����T1����·�����Ѿ�����ΪD:\matlab_files\T1_subway.mat')
fclose(fid);
fid=fopen('2.2 ����T2�߻��˹�����Ϣ.txt','r');
for i=1:18
    temp=fgetl(fid);
    t2_subway(i,1)=str2num(temp(2:3));
    n=find(temp=='S');
    for j=1:length(n)
        t2_subway(i,j+1)=str2num(temp(n(j)+1:n(j)+4));
    end
end
%t2_subway
save D:\matlab_files\T2_subway t2_subway
disp('����T1����·�����Ѿ�����ΪD:\matlab_files\T2_subway.mat')
fclose(fid);