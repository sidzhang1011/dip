function c = imcircle(bgh, bgw, centerx, centery, radiusx, radiusy)
c = zeros(bgh, bgw);
radiusx = double(radiusx);
radiusy = double(radiusy);
for x = -radiusx:radiusx
    for y = -radiusy:radiusy
        if (x/radiusx)^2 + (y/radiusy)^2 <= 1
            c(centerx + x, centery + y) = 1;
        end
    end
end
