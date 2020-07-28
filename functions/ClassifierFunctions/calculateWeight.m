function [w_new] = calculateWeight(w,cost,learningRate)
% This Function Calculate new weight coefficient

w_new = w + learningRate*(cost.');

end

