clear,clc
startP=input('请输入起点：');
endP=input('请输入终点：');
%D_index=searchS(startP,subway_index);
load T2_subway;
load SLdata_sl;
load SSdata_con;
railway=[24,25,26,12,27,28,29,30,31,32,18,33,34,35,36,37,38,39,24];
road11=[];road12=[];road13=[];road13_1=[];road13_2=[];
[D_index,row]=find(t2_subway==startP);
if ~isempty(D_index) %S1经过T1
    road11=[road11;[(D_index),1 6]];
    %D_index
else
    disp('起点不能直接换乘T2')
    %[L,distance,money,time]=direct_arrive(startP,S_mid)
    for i=1:size(t2_subway,1)
        for j=2:size(t2_subway,2)
            if t2_subway(i,j)~=0
                %S-S-D(t1)D...
                for k=1:520
                    for m=1:2
                        if SLmat1(startP,k,m)>0&&SLmat1(t2_subway(i,j),k,m)>0&&(SLmat1(t2_subway(i,j),k,m)-SLmat1(startP,k,m)>0)
                            road12=[road12;[k,m,t2_subway(i,j),i,(SLmat1(t2_subway(i,j),k,m)-SLmat1(startP,k,m))*3+6]];
                                          % L 上/下 S 地铁             
                        end
                    end
                end
                %S-S-S-D(t1)D...
                for s1=1:3957
                    if SS_matrix_con(startP,s1)==1&&SS_matrix_con(s1,t2_subway(i,j))==1  
                        for k=1:520
                            for m=1:2
                                if SLmat1(startP,k,m)>0&&SLmat1(s1,k,m)>0&&(SLmat1(s1,k,m)-SLmat1(startP,k,m)>0)                                    
                                    road13_1=[road13_1;[k m s1 (SLmat1(s1,k,m)-SLmat1(startP,k,m))*3]];                                   
                                end
                            end
                        end
                        for k=1:520
                            for m=1:2
                                if SLmat1(t2_subway(i,j),k,m)>0&&SLmat1(s1,k,m)>0&&(SLmat1(t2_subway(i,j),k,m)-SLmat1(s1,k,m)>0)                                    
                                    road13_2=[road13_2;[k m t2_subway(i,j) i (SLmat1(t2_subway(i,j),k,m)-SLmat1(s1,k,m))*3]];                                    
                                end
                            end
                        end
                        for m=1:size(road13_1,1)
                            for n=1:size(road13_2,1)
                                result=[road13_1(m,:) road13_2(n,:)];
                                road13=[road13;result];
                            end
                        end
                        %road13=[road13;[ ]];
                    end
                    road13_1=[];road13_2=[];
                end
            end
        end
    end
    %road12
    %road13;
end
if size(road11,1)~=0 road11_t=[ones(size(road11,1),1),6*ones(size(road11,1),1),road11(:,1)];
else road11_t=[];
end 
if size(road12,1)~=0   road12_t=[2*ones(size(road12,1),1),road12(:,5),road12(:,4)];
else road12_t=[];
end
if size(road13,1)~=0   
    road13_t=[3*ones(size(road13,1),1),road13(:,4)+road13(:,9)+6+5,road13(:,8)];    
else road13_t=[];
end
road123_t=sortrows([road11_t;road12_t;road13_t],2);
%road11,road12,road13
%---------------------------------后半段------------------------------------
road21=[];road22=[];road23=[];road23_1=[];road23_2=[];
[D_index,row]=find(t2_subway==endP);
if ~isempty(D_index) %S1经过T1
    road21=[road21;[(D_index) 6]];
    %D_index
else
    disp('不能直接换乘T2到终点')
    %[L,distance,money,time]=direct_arrive(startP,S_mid)
    for i=1:size(t2_subway,1)
        for j=2:size(t2_subway,2)
            if t2_subway(i,j)~=0
                %S-S-D(t1)D...
                for k=1:520
                    for m=1:2
                        if SLmat1(endP,k,m)>0&&SLmat1(t2_subway(i,j),k,m)>0&&(SLmat1(endP,k,m)-SLmat1(t2_subway(i,j),k,m)>0)
                            road22=[road22;[i,t2_subway(i,j),m,k,(SLmat1(endP,k,m)-SLmat1(t2_subway(i,j),k,m))*3+7]];
                                          % L 上/下 S 地铁             
                        end
                    end
                end
                %S-S-S-D(t1)D...
                for s2=1:3957
                    if SS_matrix_con(endP,s2)==1&&SS_matrix_con(s2,t2_subway(i,j))==1  
                        for k=1:520
                            for m=1:2
                                if SLmat1(endP,k,m)>0&&SLmat1(s2,k,m)>0&&(SLmat1(endP,k,m)-SLmat1(s2,k,m)>0)                                    
                                    road23_1=[road13_1;[s2 m k (SLmat1(endP,k,m)-SLmat1(s2,k,m))*3]];                                   
                                end
                            end
                        end
                        for k=1:520
                            for m=1:2
                                if SLmat1(t2_subway(i,j),k,m)>0&&SLmat1(s2,k,m)>0&&(SLmat1(s2,k,m)-SLmat1(t2_subway(i,j),k,m)>0)                                    
                                    road23_2=[road23_2;[i t2_subway(i,j) k m (SLmat1(s2,k,m)-SLmat1(t2_subway(i,j),k,m))*3]];                                    
                                end
                            end
                        end
                        for m=1:size(road23_2,1)
                            for n=1:size(road23_1,1)
                                result=[road23_2(m,:) road23_1(n,:)];
                                road23=[road23;result];
                            end
                        end
                        %road13=[road13;[ ]];
                    end
                    road23_1=[];road23_2=[];
                end
            end
        end
    end
    %road12
    %road23
end

if size(road21,1)~=0  road21_t2=[ones(size(road21,1),1),6*ones(size(road21,1),1),road21(:,1)];
else road21_t2=[];
end 
if size(road22,1)~=0   road22_t2=[2*ones(size(road22,1),1),road22(:,5),road22(:,1)];
else road22_t2=[];
end
if size(road23,1)~=0   
    road23_t2=[3*ones(size(road23,1),1),road23(:,5)+road23(:,9)+7+5,road23(:,1)];    
else road23_t2=[];
end
road123_t2=sortrows([road21_t2;road22_t2;road23_t2],2);
%--------------------前一段排序---------------------------------------------
road123_t_min=[];
a=road123_t(:,3);
%road123_t
for i=1:18
    m=find(a==i);
    if ~isempty(m)
        road123_t_min=[road123_t_min;road123_t(m(1),:)];
    end
end
%road123_t1
%--------------------后一段排序---------------------------------------------
road123_t2_min=[];
a=road123_t2(:,3);
%road123_t
for i=1:18
    m=find(a==i);
    if ~isempty(m)
        road123_t2_min=[road123_t2_min;road123_t2(m(1),:)];
    end
end
%road123_t2(1:20,:);
%road123_t2_min;
%--------------------------接前后矩阵---------------------------------------
road123_con=[];
for m=1:size(road123_t_min,1)
    for n=1:size(road123_t2_min,1)
        result=[road123_t_min(m,:) road123_t2_min(n,:)];
        road123_con=[road123_con;result];
    end
end
road123_con_dif=[];road123_con_time=[];
for i=1:size(road123_con,1)
    if  road123_con(i,3)~=road123_con(i,6)
        road123_con_dif=[road123_con_dif;road123_con(i,:)];
    end
end
%------按时间排序----------------
road123_con_time=sortrows([road123_con_dif,abs(road123_con_dif(:,3)-road123_con_dif(:,6))*2.5+road123_con_dif(:,2)+road123_con_dif(:,5)],7);
road_t1=road123_con_time(1,:);
%----输出时间最短的路线-------------------------------------------------------------
switch road123_con_time(1,1)
    case 1
        %road123_con_time(1,3)
        disp(['先转到D' num2str(railway(road123_con_time(1,3))) '乘坐T2'])
    case 2
        for i=1:size(road12,1)
            if road12(i,4)==road123_con_time(1,3)&&road12(i,5)==road123_con_time(1,2)
                %road12(i,:)%前一段信息
                if road12(i,2)==1 
                    w='上行' ;
                else w='下行' ;
                end
                disp(['先通过L' num2str(road12(i,1)) w '到S' num2str(road12(i,3)) '再转到D' num2str(railway(road12(i,4))) '乘坐T2'])                
            end
        end
    case 3   
        for i=1:size(road13,1)
            if road13(i,8)==road123_con_time(1,3)&&road13(i,4)+road13(i,9)+13==road123_con_time(1,2)
                %road12(i,:)%前一段信息
                if road13(i,2)==1 
                    w1='上行' ;
                else w1='下行' ;
                end
                if road13(i,2)==1 
                    w2='上行' ;
                else w2='下行' ;
                end
                disp(['先通过L' num2str(road13(i,1)) w1 '到S' num2str(road13(i,3)) '再由L' num2str(road13(i,5)) w2 '到S' num2str(road13(i,7)) '再转到D' num2str(railway(road13(i,8))) '乘坐T2'])
            end
        end
end

switch road123_con_time(1,4)
    case 1
        %road123_con_time(1,3)
        disp(['到D' num2str(railway(road123_con_time(1,6))) '转到终点'])
    case 2
        for i=1:size(road22,1)
            if road22(i,4)==road123_con_time(1,3)&&road22(i,5)==road123_con_time(1,5)
                %road12(i,:)%前一段信息
                if road22(i,3)==1 
                    w='上行' ;
                else w='下行' ;
                end
                disp(['到D' num2str(railway(road22(i,1))) '转S' num2str(road22(i,2)) '通过L' num2str(road22(i,4)) w '到终点'])                
            end
        end
    case 3   
        for i=1:size(road23,1)
            if road23(i,1)==road123_con_time(1,6)&&road23(i,5)+road23(i,9)+12==road123_con_time(1,5)
                %road12(i,:)%前一段信息
                if road23(i,4)==1 
                    w1='上行' ;
                else w1='下行' ;
                end
                if road23(i,7)==1 
                    w2='上行' ;
                else w2='下行' ;
                end
                disp(['到D' num2str(railway(road23(i,1))) '转S' num2str(road23(i,2)) '通过L' num2str(road23(i,3)) w1 '到S' num2str(road23(i,6)) '通过L' num2str(road23(i,8)) w2 '到终点---时间：' num2str(road123_con_time(1,7))])
            end
        end
end


