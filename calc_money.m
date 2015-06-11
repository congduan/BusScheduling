function money=calc_money(num_L,distance)
load SSdata_CountMoney;
if price_mat(num_L,2)==0
    money=1;
else
    money=fenduanjifei(distance);   
end