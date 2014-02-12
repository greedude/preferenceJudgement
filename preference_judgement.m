
screens=Screen('Screens');
curScreen=max(screens);
[w,wrect] = Screen('OpenWindow',curScreen,[255 255 255]);
str9 = double(sprintf('Name:'));


width = wrect(3);
height = wrect(4);
left_border = (width - 450*2)/4;
step_l = 400 + left_border;
top_border = 0.278 * height;
bottom_border = top_border+400;

subject_name = GetEchoString(w,str9,width/3,height/2,[0 0 0],[255 255 255]);
Screen('Flip',w);
datafilename =  strcat('data\',subject_name,'.dat'); % name of data file to write to

datafilepointer = fopen(datafilename,'wt'); % open ASCII file for writing


KbName('UnifyKeyNames');
EscapeKey=KbName('ESCAPE');

shuffled_category = [2 4 3];


for j = 1:3
switch shuffled_category(j)
    case 1
        img{1} = imread('static\apple.png');
        img{2} = imread('static\banana.png');
        img{3} = imread('static\grape.png');
        img{4} = imread('static\huolongguo.png');
        img{5} = imread('static\kiwi.png');
        img{6} = imread('static\lemon.png');
        img{7} = imread('static\orange.png');
        img{8} = imread('static\pear.png');
        img{9} = imread('static\pineapple.png');
        img{10} = imread('static\strawberry.png');
        img{11} = imread('static\shiliu.png');
        img{12} = imread('static\youzi.png');
        instruction = double(sprintf('请点击图片，选择你较喜欢的水果'));
    case 2
        img{1} = imread('static\dabaicai.png');
        img{2} = imread('static\kugua.png');
        img{3} = imread('static\ou.png');
        img{4} = imread('static\potato.png');
        img{5} = imread('static\qiezi.png');
        img{6} = imread('static\shengcai.png');
        img{7} = imread('static\carrot.png');
        img{8} = imread('static\huagua.png');
        img{9} = imread('static\bocai.png');
        img{10} = imread('static\nangua.png');
        img{11} = imread('static\yumi.png');
        img{12} = imread('static\baicai.png');
        instruction = double(sprintf('请点击图片，选择你较喜欢的蔬菜'));
    case 3
        img{1} = imread('static\church.png');
        img{2} = imread('static\temple.png');
        img{3} = imread('static\beijing.png');
        img{4} = imread('static\tianchi.png');
        img{5} = imread('static\xihu.png');
        img{6} = imread('static\sichuan.png');
        img{7} = imread('static\shanghai.png');
        img{8} = imread('static\xian.png');
        img{9} = imread('static\fenghuang.png');
        img{10} = imread('static\lijiang.png');
        img{11} = imread('static\huangshan.png');
        img{12} = imread('static\sol.png');
        instruction = double(sprintf('请点击图片，选择你较喜欢的风景'));
    case 4
        img{1} = imread('static\blue1.png');
        img{2} = imread('static\blue2.png');
        img{3} = imread('static\blue3.png');
        img{4} = imread('static\blue4.png');
        img{5} = imread('static\blue5.png');
        img{6} = imread('static\blue6.png');
        img{7} = imread('static\blue7.png');
        img{8} = imread('static\blue8.png');
        img{9} = imread('static\blue9.png');
        img{10} = imread('static\blue10.png');
        img{11} = imread('static\blue11.png');
        img{12} = imread('static\blue12.png');
        instruction = double(sprintf('请选择最接近蓝色的图片'));
end

orderedImgArray = combnk(1:12,2);
control_orderedImgArray = combnk(1:7,2);
shuffledImgArray = orderedImgArray(randperm(size(orderedImgArray,1)),:);
shuffledImgArray(67:87,1) = control_orderedImgArray(1:21,2);
shuffledImgArray(67:87,2) = control_orderedImgArray(1:21,1);
DrawFormattedText(w, instruction, 'center', 'center', BlackIndex(w));
Screen('Flip',w);
WaitSecs(5);

category = shuffled_category(j);
for i=1:87
    
    
    stimuli_left = img{shuffledImgArray(i,1)};
    stimuli_right = img{shuffledImgArray(i,2)};

    tex = [0 0];
    tex(1) = Screen('MakeTexture', w, stimuli_left);
    tex(2) = Screen('MakeTexture', w, stimuli_right);

    rect = [left_border 2*left_border+step_l;top_border top_border;step_l 2*step_l+left_border;bottom_border bottom_border];
    Screen('DrawTextures', w, tex, [],rect);
    WaitSecs(0.5);
    starttime = Screen('Flip',w);
    
    left = shuffledImgArray(i,1);
    right = shuffledImgArray(i,2);
    while 1
    [x,y,button] = GetMouse(w);
        flag = 1;
        [KeyIsDown, endrt, KeyCode]=KbCheck;
        if KeyIsDown      
            if KeyCode(EscapeKey)
                Screen('CloseAll');
                fclose('all');
                return   
            end
        end
        
        if rect(1,1)<x && x<rect(3,1) && rect(2,1)<y&& y<rect(4,1)
             preference =left;

        elseif rect(1,2)<x&&x<rect(3,2) && rect(2,2)<y&&y<rect(4,2)
            preference =right;

        else
            flag = 0;
        end
        
        if  button(1)==1 && flag==1
            click_time = GetSecs;
            break;
        end
    end

%     if round(rand) ==0
%         preference = right;
%     else
%         preference = left;
%     end
    
    Screen('Flip',w);
    
    

   response_time = click_time - starttime;
%     response_time = rand;
    
    fprintf(datafilepointer,'%g %g %g %g %g\n', ...
            category, ...
            left, ...
            right, ...
            preference,...
            response_time);
  
end
end
Screen('CloseAll');