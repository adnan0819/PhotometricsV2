function m = drawGrid(in)

[h,w,c]=size(in);
in(1:ceil(h/3):end,:,:)=255; %# Change 1/3 row to white
in(:,1:ceil(w/3):end,:) = 255;
out=in;
%imshow(out);
imwrite(out,'interim1.jpg');
one=[1,1];
two=[floor(h/3),1];
three=[two(1)+floor(h/3),1];
four=[h,1];


five=[1,floor(w/3)];
six=[1*floor(h/3),floor(w/3)];
seven=[2*floor(h/3),floor(w/3)];
eight=[3*floor(h/3),floor(w/3)];

nine=[1,five(2)+floor(w/3)];
ten=[1*floor(h/3),nine(2)];
eleven=[2*floor(h/3),ten(2)];
twelve=[3*floor(h/3),eleven(2)];

thirteen=[1,nine(2)+floor(w/3)];
fourteen=[1*floor(h/3),thirteen(2)];
fifteen=[2*floor(h/3),fourteen(2)];
sixteen=[3*floor(h/3),fifteen(2)];

m=[one(1) five(1) nine(1) thirteen(1);two(1) six(1) ten(1) fourteen(1);three(1) seven(1) eleven(1) fifteen(1);four(1) eight(1) twelve(1) sixteen(1)]; 
m(:,:,2)=[one(2) five(2) nine(2) thirteen(2);two(2) six(2) ten(2) fourteen(2);three(2) seven(2) eleven(2) fifteen(2);four(2) eight(2) twelve(2) sixteen(2)]; 