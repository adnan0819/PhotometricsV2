

for i=1:100
    str='"im"%d".jpg"',indoor(i);
    a=imread(str);
    imwrite(a,'mirflickr/indoors/%d',str);
end