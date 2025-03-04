function [v_mod] = LCSMODEL(r, d, l, theta, omega)

    % Beta
    beta = asin((d - (r * sin(theta))) / l);

    % Velocity of the crank
    v_mod = ((cos(theta) .* tan(beta)) + (sin(theta))) .* omega * (-r);

end