function result_disp=t(startP,endP)
%clear
%startP=input('��������㣺');
%endP=input('�������յ㣺');
tic
load SSdata_con; 
load SLdata_sl;
disp('-----------------------------����һ��-----------------------------------')
result_mat1=[];result_mat2=[];
result2=[];result11=[];
for i=1:3957
    if SS_matrix_con(startP,i)==1&&SS_matrix_con(i,endP)==1    
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
    result_mat1=[];result_mat2=[];
end
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
        %disp(['��ͨ��L' num2str(money_sort(i,1)) '����' num2str(money_sort(i,2)) '��վ��' w1 '��S' num2str(money_sort(i,6)) '����ͨ��L' num2str(money_sort(i,7)) '����' num2str(money_sort(i,8)) '��վ��' w2 '���յ�----���ã�' num2str(money_sort(i,12)) '----ʱ�䣺' num2str(money_sort(i,13))])
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
        %disp(['��ͨ��L' num2str(time_sort(i,1)) '����' num2str(time_sort(i,2)) '��վ��' w1 '��S' num2str(time_sort(i,6)) '����ͨ��L' num2str(time_sort(i,7)) '����' num2str(time_sort(i,8)) '��վ��' w2 '���յ�----���ã�' num2str(time_sort(i,12)) '----ʱ�䣺' num2str(time_sort(i,13))])
    end
end
toc