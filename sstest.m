clear
startP=input('��������㣺');
endP=input('�������յ㣺');
tic
load SSdata_con;
%load SSdata_tim;
%load SSdata_L;
%load SSdata_mon;
load SLdata_sl;
disp('------------------------------ֱ��--------------------------------------')
direct=0;
result_mat=[];
%-----------
for i=1:520
    if SLmat1(startP,i,1)>0&&SLmat1(endP,i,1)>0&&(SLmat1(endP,i,1)-SLmat1(startP,i,1)>0)
        distance=SLmat1(endP,i,1)-SLmat1(startP,i,1);
        money=calc_money(i,distance);
        time=distance*3;
        %direct=strvcat(direct,num2str(i));
        direct=1;
        result=[i distance 0 money time];
        result_mat=[result_mat(:,:);result(1,:)];
        %disp(['��ͨ��L' num2str(i) '����' num2str(distance) '��վ������ֱ��----�۸�' num2str(money) '----ʱ�䣺' num2str(time)]) 
    end
    if SLmat1(startP,i,2)>0&&SLmat1(endP,i,2)>0&&(SLmat1(endP,i,2)-SLmat1(startP,i,2)>0)
        distance=SLmat1(endP,i,2)-SLmat1(startP,i,2);
        money=calc_money(i,distance);
        time=distance*3;
        %direct=strvcat(direct,num2str(i));
        direct=1;
        result=[i distance 1 money time];
        result_mat=[result_mat(:,:);result(1,:)];
        %disp(['��ͨ��L' num2str(i) '����' num2str(distance) '��վ������ֱ��----�۸�' num2str(money) '----ʱ�䣺' num2str(time)]) 
    end
end
if size(result_mat,1)~=0
    money_sort=sortrows(result_mat,4);%��Ǯ����
    time_sort=sortrows(result_mat,5);%��ʱ������
    disp('���۸���������·��')
    if size(money_sort,1)<3 hang=size(money_sort,1);
    else hang=3;
    end
    for i=1:hang
        if money_sort(i,3)==0
            disp(['��ͨ��L' num2str(money_sort(i,1)) '����' num2str(money_sort(i,2)) '��վ������ֱ��----�۸�' num2str(money_sort(i,4)) '----ʱ�䣺' num2str(money_sort(i,5))])
        elseif money_sort(i,3)==1
            disp(['��ͨ��L' num2str(money_sort(i,1)) '����' num2str(money_sort(i,2)) '��վ������ֱ��----�۸�' num2str(money_sort(i,4)) '----ʱ�䣺' num2str(money_sort(i,5))])
        end
    end
    disp('��ʱ����������·��')
    for i=1:hang
    if time_sort(i,3)==0
        disp(['��ͨ��L' num2str(time_sort(i,1)) '����' num2str(time_sort(i,2)) '��վ������ֱ��----�۸�' num2str(time_sort(i,4)) '----ʱ�䣺' num2str(time_sort(i,5))])
    elseif time_sort(i,3)==1
        disp(['��ͨ��L' num2str(time_sort(i,1)) '����' num2str(time_sort(i,2)) '��վ������ֱ��----�۸�' num2str(time_sort(i,4)) '----ʱ�䣺' num2str(time_sort(i,5))])
    end
end
end
if direct==0 disp('û��ֱ��ĳ�'); end
disp('-----------------------------����һ��-----------------------------------')
result_mat1=[];result_mat2=[];
result2=[];result11=[];direct1=0;
for i=1:3957
    if SS_matrix_con(startP,i)==1&&SS_matrix_con(i,endP)==1  
        direct1=1;
        %disp('In')
        for j1=1:520
            for k=1:2
                if SLmat1(startP,j1,k)>0&&SLmat1(i,j1,k)>0&&SLmat1(i,j1,k)-SLmat1(startP,j1,k)>0
                    %disp(num2str(j1))
                    distance1=SLmat1(i,j1,k)-SLmat1(startP,j1,k);
                    money1=calc_money(j1,distance1);
                    time1=distance1*3;
                    result10=[j1 distance1 k money1 time1 i];
                    result_mat1=[result_mat1(:,:);result10];
                    %disp('A')
                end
            end
        end
        %size( result_mat1)
        %disp('q')
        %result_mat1
        for j2=1:520
            for k=1:2
                %disp('B')
                if SLmat1(i,j2,k)>0&&SLmat1(endP,j2,k)>0&&(SLmat1(endP,j2,k)-SLmat1(i,j2,k)>0)
                    %disp('B')
                    distance2=SLmat1(endP,j2,k)-SLmat1(i,j2,k);
                    money2=calc_money(j2,distance2);
                    time2=distance2*3;
                    result11=[j2 distance2 k money2 time2];
                    result_mat2=[result_mat2(:,:);result11];
                    %result_mat2                    
                 end
            end
        end
         %size( result_mat2)
        %disp_str=(['��ͨ��L' num2str(j) '����' num2str(distance) '��վ�����е�S' num2str(i) ','] );
        for m=1:size(result_mat1,1)
            for n=1:size(result_mat2,1)
                result12=[result_mat1(m,:) result_mat2(n,:)];
                result2=[result2;result12];
            end
        end
        %result2
    end    
    result_mat1=[];result_mat2=[];%��Ҫ��һ��
end
if direct1~=0   
    result_disp=[result2(:,:),result2(:,4)+result2(:,10),result2(:,5)+result2(:,11)+5];
    %----------------------------------------
    if size(result_disp,1)~=0
        money_sort=sortrows(result_disp,12);%��Ǯ����
        time_sort=sortrows(result_disp,13);%��ʱ������
        if size(money_sort,1)<5  
            hang=size(money_sort,1);
        else hang=5;
        end
        disp('���۸���������·��')    
        for i=1:hang
            if money_sort(i,3)==1 w1=['����'];
            else w1=['����'];
            end
            if money_sort(i,9)==1 
                w2=['����'];
            else w2=['����'];
            end
            disp(['��ͨ��L' num2str(money_sort(i,1)) '����' num2str(money_sort(i,2)) '��վ��' w1 '��S' num2str(money_sort(i,6)) '����ͨ��L' num2str(money_sort(i,7)) '����' num2str(money_sort(i,8)) '��վ��' w2 '���յ�----���ã�' num2str(money_sort(i,12)) '----ʱ�䣺' num2str(money_sort(i,13))])
        end
        disp('��ʱ����������·��')
        for i=1:hang
            if time_sort(i,3)==1 
                w1=['����'];
            else w1=['����'];
            end
            if time_sort(i,9)==1 
                w2=['����'];
            else w2=['����'];
            end
            disp(['��ͨ��L' num2str(time_sort(i,1)) '����' num2str(time_sort(i,2)) '��վ��' w1 '��S' num2str(time_sort(i,6)) '����ͨ��L' num2str(time_sort(i,7)) '����' num2str(time_sort(i,8)) '��վ��' w2 '���յ�----���ã�' num2str(time_sort(i,12)) '----ʱ�䣺' num2str(time_sort(i,13))])
        end
    end
else
    disp('���ܻ���һ��')
end
disp('-----------------------------��������-----------------------------------')
result2_mat1=[];result2_mat2=[];result2_mat3=[];
result3=[];result31=[];
for i=1:3957
    for j=1:3957
        if SS_matrix_con(startP,i)==1&&SS_matrix_con(i,j)&&SS_matrix_con(j,endP)==1    
            %��һ�����˵�
            for k=1:520
                for m=1:2
                    if SLmat1(startP,k,m)>0&&SLmat1(i,k,m)>0&&(SLmat1(i,k,m)-SLmat1(startP,k,m)>0)
                        distance1=SLmat1(i,k,m)-SLmat1(startP,k,m);
                        money1=calc_money(k,distance1);
                        time1=distance1*3;
                        result20=[k distance1 m money1 time1 i];
                        result2_mat1=[result2_mat1(:,:);result20];
                        %disp_str=(['��ͨ��L' num2str(k) '����' num2str(distance) '��վ�����е�S' num2str(i) ','] );
                    end
                end
            end
            %�ڶ������˵�
           for k=1:520
               for m=1:2
                    if SLmat1(i,k,m)>0&&SLmat1(j,k,m)>0&&(SLmat1(j,k,m)-SLmat1(i,k,m)>0)
                        distance2=SLmat1(j,k,m)-SLmat1(i,k,m);
                        money2=calc_money(k,distance2);
                        time2=distance2*3;
                        result21=[k distance2 m money2 time2 j];
                        result2_mat2=[result2_mat2(:,:);result21];
                        %disp_str=([disp_str '����S' num2str(i) 'ͨ��L' num2str(k) '����' num2str(distance) '��վ�����е�S' num2str(j) ',']) ;
                    end
               end
           end
            %���������˵�
            for k=1:520
                 for m=1:2
                    if SLmat1(endP,k,m)>0&&SLmat1(j,k,m)>0&&(SLmat1(endP,k,m)-SLmat1(j,k,m)>0)
                        distance3=SLmat1(endP,k,m)-SLmat1(j,k,m);
                        money3=calc_money(k,distance3);
                        time3=distance3*3;
                        result22=[k distance3 m money3 time3];
                        result2_mat3=[result2_mat3(:,:);result22];
                        %disp([disp_str '����S' num2str(j) 'ͨ��L' num2str(k) '����' num2str(distance) '��վ�����е��յ�' '----�۸�' num2str(money) '----ʱ�䣺' num2str(time)]) 
                    end
                 end
             end
            %ƴ�Ӿ���
            if size(result2_mat1,1)~=0&&size(result2_mat2,1)~=0&&size(result2_mat3,1)~=0
                for m1=1:size(result2_mat1,1)
                    for n1=1:size(result2_mat2,1)
                        for k1=1:size(result2_mat3,1)
                            result22=[result2_mat2(n1,:) result2_mat3(k1,:)];
                            result31=[result2_mat1(m1,:) result22];                           
                            result3=[result3(:,:);result31];
                        end
                    end
                end
            end            
        end
        result2_mat2=[];result2_mat3=[]; result2_mat1=[];
    end
end
result2_disp=[result3(:,:),result3(:,4)+result3(:,10)+result3(:,16),result3(:,5)+result3(:,11)+result3(:,17)+10];
if size(result2_disp,1)~=0
    money_sort=sortrows(result2_disp,18);%��Ǯ����
    time_sort=sortrows(result2_disp,19);%��ʱ������
    if size(money_sort,1)<5  
        hang=size(money_sort,1);
    else hang=5;
    end
    disp('���۸���������·��')    
    for i=1:hang
        if money_sort(i,3)==1 w1=['����'];
        else w1=['����'];
        end
        if money_sort(i,9)==1 
            w2=['����'];
        else w2=['����'];
        end
        if money_sort(i,15)==1 
            w3=['����'];
        else w3=['����'];
        end
        disp(['��ͨ��L' num2str(money_sort(i,1)) '����' num2str(money_sort(i,2)) '��վ��' w1 '��S' num2str(money_sort(i,6)) '����ͨ��L' num2str(money_sort(i,7)) '����' num2str(money_sort(i,8)) '��վ��' w2 '��S' num2str(money_sort(i,12)) ',��ͨ��L' num2str(money_sort(i,13)) '����' num2str(money_sort(i,14)) '��վ��' w3 '���յ�----���ã�' num2str(money_sort(i,18)) '----ʱ�䣺' num2str(money_sort(i,19))])
    end
    disp('��ʱ����������·��')
    for i=1:hang
        if time_sort(i,3)==1 w1=['����'];
        else w1=['����'];
        end
        if time_sort(i,9)==1 
            w2=['����'];
        else w2=['����'];
        end
        if time_sort(i,15)==1 
            w3=['����'];
        else w3=['����'];
        end
        disp(['��ͨ��L' num2str(time_sort(i,1)) '����' num2str(time_sort(i,2)) '��վ��' w1 '��S' num2str(time_sort(i,6)) '����ͨ��L' num2str(time_sort(i,7)) '����' num2str(time_sort(i,8)) '��վ��' w2 '��S' num2str(time_sort(i,12)) ',��ͨ��L' num2str(time_sort(i,13)) '����' num2str(time_sort(i,14)) '��վ��' w3 '���յ�----���ã�' num2str(time_sort(i,18)) '----ʱ�䣺' num2str(time_sort(i,19))])
    end
end

toc