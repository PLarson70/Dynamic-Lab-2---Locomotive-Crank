function [v_mod] = LCSMODEL(r, d, l, theta, omega)

    beta = asin((d - (r * sin(theta))) / l);

    v_mod = ((cos(theta) .* tan(beta)) + (sin(theta))) * omega * (-r);

end